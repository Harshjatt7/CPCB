import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/retreader/retreader_repository.dart';
import 'package:cpcb_tyre/models/request/retreader/procurement_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/models/response/common/file_size_model.dart';
import 'package:cpcb_tyre/models/response/retreader/get_raw_material_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProcurementAddDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final StringConstants stringConstants = StringConstants();
  final MessageConstant messageConstant = MessageConstant();
  final HelperFunctions helperFunctions = HelperFunctions();

  String? yearDropdownValue;
  String? yearDropdownError;
  String? changeDropdown;
  String? rawMaterialDropdownValue;
  String? rawMaterialDropdownError;
  List<String> typeOfRawMaterial = <String>[];

  TextEditingController nameOfWasteTyreSupplierController =
      TextEditingController();
  TextEditingController supplierContactDetailsController =
      TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeOfRawMaterialController = TextEditingController();
  TextEditingController quantityReceivedController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController uploadInvoiceController = TextEditingController();
  List financialYearList = <String>[];
  MultipartFile? uploadInvoiceDoc;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime? date;

  String? filePath;
  String? fileError;
  String? fileName;
  String? fileSize;
  double? fileSizeNum;
  FileSizeModel? fileSizeModel;
  final _retreaderRepo = RetreaderRepository();
  String? financialYearError;
  String? supplierNameError;
  String? supplierContactError;
  String? addressError;
  String? rawMaterialError;
  String? quantityReceivedError;
  String? uploadInvoiceError;
  String? invoiceNumberError;
  String? gstNumberError;
  String? purchaseDateError;

  String newText = '';
  FilePickerResult? pickedFile;

  APIResponse<RawMaterialResponseModel?>? _rawMaterialResponseModel;
  APIResponse<RawMaterialResponseModel?>? get rawMaterialResponseModel =>
      _rawMaterialResponseModel;

  Future<FilePickerResult?> openFileManager(context) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result != null) {
      final file = File(result.files.single.path ?? "");
      filePath = file.path;
      fileSizeModel = await getFileSize(filePath ?? '', 1);
      fileSize = fileSizeModel?.fileSize ?? "0 B";
      fileName = file.path.split('/').last;
      updateUI();
    } else {
      fileError = messageConstant.pleaseSelectFile;
      updateUI();
    }
    return result;
  }

  void dateTimeConvert() {
    if (date != null) {
      dateController.text = helperFunctions.getFormattedDate(date: date!);
    }
    helperFunctions.logger(dateController.text);
  }

  String? nameValidation() {
    return Validations().validateName(nameOfWasteTyreSupplierController.text);
  }

  void changeRawMaterialDropdownValue(newValue) {
    rawMaterialDropdownValue = newValue;
    if (rawMaterialDropdownValue == null) {
      rawMaterialDropdownError = messageConstant.mandatoryTypeRawMaterial;
    }
    updateUI();
  }

  Future<APIResponse<RawMaterialResponseModel?>?> getRawMaterialData() async {
    state = ViewState.busy;

    typeOfRawMaterial = [];
    try {
      _rawMaterialResponseModel =
          await _retreaderRepo.getRetreaderRawMaterial();
      if (_rawMaterialResponseModel?.isSuccess == true) {
        _rawMaterialResponseModel?.data = RawMaterialResponseModel.fromJson(
            _rawMaterialResponseModel?.completeResponse);

        if (_rawMaterialResponseModel?.data?.data?.biasPly != null) {
          typeOfRawMaterial
              .add(_rawMaterialResponseModel?.data?.data?.biasPly ?? "");
          typeOfRawMaterial
              .add(_rawMaterialResponseModel?.data?.data?.radial ?? "");
        }
      } else {
        helperFunctions.logger(messageConstant.somethingWentWrong);
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _rawMaterialResponseModel;
  }

  Future<void> postProcurementData(
      BuildContext context, ProcurementRequestModel request) async {
    state = ViewState.busy;
    APIResponse<AddDataResponseModel?>? response;
    try {
      if (formKey.currentState?.validate() ?? false) {
        response = await _retreaderRepo.postProcurementData(request);
        if (response?.isSuccess == true) {
          response?.data =
              AddDataResponseModel.fromJson(response.completeResponse);
          if (context.mounted) {
            state = ViewState.idle;
            helperFunctions.commonSuccessSnackBar(
                context,
                response?.data?.message ??
                    messageConstant.successfullySubmitted);
            MaterialAppViewModel.selectedPageIndex = 1;
            Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.retraderHomeScreenRoute,
                ModalRoute.withName(AppRoutes.retraderHomeScreenRoute));
          }
        } else {
          final apiError = response?.error?.errorsList;

          financialYearError = (apiError?.financeYear ?? []).isEmpty
              ? ""
              : apiError?.financeYear?.first ?? "";
          supplierNameError = (apiError?.sellerName ?? []).isEmpty
              ? ""
              : apiError?.sellerName?.first ?? "";
          supplierContactError = (apiError?.sellerMobile ?? []).isEmpty
              ? ""
              : apiError?.sellerMobile?.first ?? "";
          addressError = (apiError?.sellerAddress ?? []).isEmpty
              ? ""
              : apiError?.sellerAddress?.first ?? "";
          rawMaterialError = (apiError?.rawMaterial ?? []).isEmpty
              ? ""
              : apiError?.rawMaterial?.first ?? "";
          quantityReceivedError = (apiError?.purchasedQuantity ?? []).isEmpty
              ? ""
              : apiError?.purchasedQuantity?.first ?? "";
          uploadInvoiceError = (apiError?.procurementInvoiceFile ?? []).isEmpty
              ? ""
              : apiError?.procurementInvoiceFile?.first ?? "";
          invoiceNumberError = (apiError?.invoiceNumber ?? []).isEmpty
              ? ""
              : apiError?.invoiceNumber?.first ?? "";
          gstNumberError = (apiError?.sellerGstNo ?? []).isEmpty
              ? ""
              : apiError?.sellerGstNo?.first ?? "";
          purchaseDateError = (apiError?.purchaseDate ?? []).isEmpty
              ? ""
              : apiError?.purchaseDate?.first ?? "";
        }
      } else {
        helperFunctions.commonErrorSnackBar(
            context, messageConstant.somethingWentWrong);
      }
    } catch (e) {
      helperFunctions.logger('$e');
    }
    state = ViewState.idle;
  }

  String? supplierContactDetailsValidation() {
    if (supplierContactDetailsController.text.isNotEmpty) {
      return Validations().validatePhone(supplierContactDetailsController.text);
    }
    return null;
  }

  Future<FileSizeModel> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) {
      return FileSizeModel(fileSize: "0 B", fileSizeNum: 0);
    }
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    fileSizeNum = bytes / pow(1024, i);
    return FileSizeModel(
        fileSize:
            '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}',
        fileSizeNum: fileSizeNum ?? 0);
  }

  void addYear() {
    int year = 2022;
    int currentYear = DateTime.now().year;
    while (year <= currentYear) {
      financialYearList.add('$year-${year + 1}');
      year++;
    }
  }

  void handleOnTap(BuildContext context) async {
    if (uploadInvoiceController.text.isEmpty) {
      pickedFile = await openFileManager(context);

      if (pickedFile != null) {
        uploadInvoiceController.text =
            pickedFile!.files.isEmpty ? "" : pickedFile!.files.first.name;
      }
    } else {
      helperFunctions.openFile(filePath ?? "");
    }
  }

  void handleOnSuffixTap(BuildContext context) async {
    if (uploadInvoiceController.text.isEmpty) {
      pickedFile = await openFileManager(context);

      if (pickedFile != null) {
        uploadInvoiceController.text =
            pickedFile!.files.isEmpty ? "" : pickedFile!.files.first.name;
      }
    } else {
      uploadInvoiceController.text = "";
      filePath = null;
      updateUI();
    }
  }

  void changeDropdownValue(newValue) {
    changeDropdown = newValue;
    if (changeDropdown != null) {
      String startYear = changeDropdown!.split('-').first;
      String lastYear = changeDropdown!.split('-').last;
      int stYear = int.parse(startYear);
      int edYear = int.parse(lastYear);
      startDate = DateTime(stYear, 4, 1);
      endDate = startYear == DateTime.now().year.toString()
          ? DateTime.now()
          : DateTime(edYear, 3, 31);

      updateUI();
    }
    updateUI();
    if (changeDropdown == null) {
      yearDropdownError = messageConstant.pleaseSelectDropdownValue;
    }
  }

  String? quantityReceivedValidation() {
    return Validations()
        .numbericWithDotValidation(quantityReceivedController.text);
  }

  String? valueValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    } else {
      return null;
    }
  }

  String? gstNumberValidation() {
    return Validations().gstValidation(gstController.text);
  }

  String? dateValidation() {
    return Validations().dateValidation(dateController.text);
  }

  String? uploadInvoiceValidation() {
    if (uploadInvoiceController.text.isEmpty) {
      return messageConstant.pleaseUploadInvoice;
    }
    if (fileSizeModel?.fileSize.contains("MB") ?? false) {
      if (fileSizeModel!.fileSizeNum > 2.0) {
        return messageConstant.maxFileSize;
      }
    }
    return null;
  }

  void formValidation(BuildContext context) {
    updateUI();
    if (changeDropdown == null) {
      changeDropdownValue(null);
    }
    if (formKey.currentState?.validate() ?? false) {
    } else {}
  }

  Future addProcurementData(BuildContext context) async {
    if (pickedFile != null) {
      uploadInvoiceDoc = await MultipartFile.fromFile(
          pickedFile!.files.first.path ?? '',
          filename: "uploadInvoice.pdf");
    }
    if (context.mounted) {
      postProcurementData(
          context,
          ProcurementRequestModel(
            uploadInvoice: uploadInvoiceDoc,
            financialYear: changeDropdown,
            sellerName: nameOfWasteTyreSupplierController.text,
            supplierAddress: addressController.text,
            typeOfRawMaterial: rawMaterialDropdownValue,
            purchaseQuantity: quantityReceivedController.text,
            invoiceNumber: invoiceNumberController.text,
            supplierGstNo: gstController.text,
            purchaseDate: dateController.text,
            sellerMobile: supplierContactDetailsController.text,
          ));
    }
  }
}
