import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/recycler/recycler_repository.dart';
import 'package:cpcb_tyre/models/request/recycler/recycler_procurement_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/models/response/common/file_size_model.dart';
import 'package:cpcb_tyre/models/response/recycler/recycler_procurement_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RecyclerProcurementAddDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final StringConstants stringConstants = StringConstants();
  final MessageConstant messageConstant = MessageConstant();
  final HelperFunctions helperFunctions = HelperFunctions();

  String? financialYearDropdownValue;
  String? rawMaterialDropdownValue;
  String? tyreSourceDropdownValue;
  String? yearDropdownError;
  String? rawMaterialDropdownError;
  String? tyreSourceDropdownError;

  TextEditingController sellerNameController = TextEditingController();
  TextEditingController sellerMobileController = TextEditingController();
  TextEditingController supplierContactDetailsController =
      TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeOfRawMaterialController = TextEditingController();
  TextEditingController quantityReceivedController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController uploadInvoiceController = TextEditingController();

  List<String> financialYearList = <String>[];
  List<String> typeOfRawMaterial = <String>[];
  List<String> tyreSource = <String>[];
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
  final _recyclerRepo = RecyclerRepository();
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
  String? sourceTyreError;

  String? changeDropdown;
  String newText = '';

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

  String? contactDetailsValidation() {
    return Validations().validatePhone(sellerMobileController.text);
  }

  String? nameValidation() {
    return Validations().validateName(sellerNameController.text);
  }

  String? supplierContactDetailsValidation() {
    return Validations().validatePhone(supplierContactDetailsController.text);
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
    for (int i = 0; i < 5; i++) {
      financialYearList
          .add("${DateTime.now().year + (i)}-${DateTime.now().year + (i + 1)}");
    }
  }

  APIResponse<RecyclerProcurementConstantsResponseData?>?
      _recyclerResponseModel;
  APIResponse<RecyclerProcurementConstantsResponseData?>?
      get recyclerResponseModel => _recyclerResponseModel;

  APIResponse<AddDataResponseModel?>? _addResponseModel;
  APIResponse<AddDataResponseModel?>? get addResponseModel => _addResponseModel;

  Future<APIResponse<RecyclerProcurementConstantsResponseData?>?>
      getData() async {
    state = ViewState.busy;
    financialYearList = [];
    typeOfRawMaterial = [];
    typeOfRawMaterial = [];
    try {
      _recyclerResponseModel =
          await _recyclerRepo.getRecyclerProcurementConstantData();
      if (_recyclerResponseModel?.isSuccess == true) {
        _recyclerResponseModel?.data =
            RecyclerProcurementConstantsResponseData.fromJson(
                _recyclerResponseModel?.completeResponse);

        financialYearList
            .addAll(_recyclerResponseModel?.data?.data?.financialYear ?? []);

        if (_recyclerResponseModel?.data?.data?.rawMaterialType != null) {
          typeOfRawMaterial.add(
              _recyclerResponseModel?.data?.data?.rawMaterialType?.flapsTubes ??
                  "");
          typeOfRawMaterial.add(
              _recyclerResponseModel?.data?.data?.rawMaterialType?.tyres ?? "");
        }
        tyreSource.addAll(_recyclerResponseModel?.data?.data?.tyreSource ?? []);
      } else {
        helperFunctions.logger(messageConstant.somethingWentWrong);
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _recyclerResponseModel;
  }

  Future<void> postData(BuildContext context) async {
    state = ViewState.busy;
    String purchasedDate = '$date';
    RecyclerProcurementRequestModel request = RecyclerProcurementRequestModel(
      financeYear: financialYearDropdownValue,
      invoiceFile: uploadInvoiceDoc?.filename,
      purchasedDate: purchasedDate.split(' ').first,
      purchasedQuantity: quantityReceivedController.text,
      rawMaterial: rawMaterialDropdownValue == "Scrap tyre/used tyre/cut tyre"
          ? "Tyres"
          : rawMaterialDropdownValue,
      sellerAddress: addressController.text,
      sellerGstNo: gstController.text,
      sourceTyres: tyreSourceDropdownValue,
      invoiceNumber: invoiceNumberController.text,
      sellerMobile: sellerMobileController.text,
      sellerName: sellerNameController.text,
    );

    try {
      if (formKey.currentState?.validate() ?? false) {
        APIResponse<AddDataResponseModel?>? response =
            await _recyclerRepo.postRecyclerProcurementData(request);

        if (response?.isSuccess == true) {
          response?.data =
              AddDataResponseModel.fromJson(response.completeResponse);
          if (context.mounted) {
            state = ViewState.idle;

            helperFunctions.commonSuccessSnackBar(
                context, response?.data?.message ?? "");
            MaterialAppViewModel.selectedPageIndex = 1;
            Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.recyclerHomeScreenRoute,
                ModalRoute.withName(AppRoutes.recyclerHomeScreenRoute));
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
          sourceTyreError = (apiError?.sourceTyre ?? []).isEmpty
              ? ""
              : apiError?.sourceTyre?.first ?? "";
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

  void handleOnTap(BuildContext context) async {
    if (uploadInvoiceController.text.isEmpty) {
      var res = await openFileManager(context);

      if (res != null) {
        uploadInvoiceController.text =
            res.files.isEmpty ? "" : res.files.first.name;
        uploadInvoiceDoc = await MultipartFile.fromFile(
            res.files.first.path ?? '',
            filename: "uploadInvoice.pdf");
      }
    } else {
      helperFunctions.openFile(filePath ?? '');
    }
  }

  void handleOnSuffixTap(BuildContext context) async {
    if (uploadInvoiceController.text.isEmpty) {
      var res = await openFileManager(context);

      if (res != null) {
        uploadInvoiceController.text =
            res.files.isEmpty ? "" : res.files.first.name;
        uploadInvoiceDoc = await MultipartFile.fromFile(
            res.files.first.path ?? '',
            filename: "uploadInvoice.pdf");
      }
    } else {
      uploadInvoiceController.text = "";
      filePath = null;
      updateUI();
    }
  }

  void financialYearDropDownConverter(newValue) {
    financialYearDropdownValue = newValue;
    if (financialYearDropdownValue != null) {
      String startYear = financialYearDropdownValue!.split('-').first;
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
    if (financialYearDropdownValue == null) {
      yearDropdownError = messageConstant.pleaseSelectDropdownValue;
    }
  }

  void changeRawMaterialDropdownValue(newValue) {
    rawMaterialDropdownValue = newValue;
    updateUI();
    if (changeDropdown == null) {
      rawMaterialDropdownError = messageConstant.mandatoryTypeRawMaterial;
    }
  }

  void changetyreSourceDropdownValue(newValue) {
    tyreSourceDropdownValue = newValue;
    updateUI();
    if (changeDropdown == null) {
      tyreSourceDropdownError =
          messageConstant.mandatoryTypeRawMaterial; //to change
    }
  }

  void changeFinancialDropdownValue(newValue) {
    financialYearDropdownValue = newValue;
    if (financialYearDropdownValue != null) {
      String startYear = financialYearDropdownValue!.split('-').first;
      int year = int.parse(startYear);
      startDate = DateTime(year, 4, 1);
      updateUI();
    }
    updateUI();
    if (financialYearDropdownValue == null) {
      yearDropdownError = messageConstant.mandatoryFinancialYear;
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
    if (formKey.currentState?.validate() ?? false) {
    } else {
      if (financialYearDropdownValue == null) {
        changeFinancialDropdownValue(null);
      }
      if (rawMaterialDropdownValue == null) {
        changeRawMaterialDropdownValue(null);
      }
      if (tyreSourceDropdownValue == null) {
        changetyreSourceDropdownValue(null);
      }
    }
  }
}
