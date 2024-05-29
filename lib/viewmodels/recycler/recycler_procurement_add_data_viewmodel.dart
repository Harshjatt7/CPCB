import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/controllers/recycler/recycler_procurement_repository.dart';
import 'package:cpcb_tyre/models/request/recycler/recycler_procurement_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/recycler/recycler_procurement_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class RecyclerProcurementAddDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

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
  DateTime? date;

  String? filePath;
  String? fileError;
  String? fileName;
  String? fileSize;
  double? fileSizeNum;
  FileSizeModel? fileSizeModel;
  final _recyclerRepo = RecyclerProcurementRepository();
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
      fileError = MessageConstant().pleaseSelectFile;
      updateUI();
    }
    return result;
  }

  dateTimeConvert() {
    if (date != null) {
      dateController.text = HelperFunctions().getFormattedDate(date: date!);
    }
    HelperFunctions().logger(dateController.text);
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

  void viewPDF(BuildContext context, String path) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFView(filePath: path)),
    );
  }

  void addYear() {
    for (int i = 0; i < 5; i++) {
      financialYearList
          .add("${DateTime.now().year + (i)}-${DateTime.now().year + (i + 1)}");
    }
  }

  String? monthDropdownError;

  APIResponse<RecyclerProcurementConstantsResponseData?>?
      _recyclerResponseModel;
  APIResponse<RecyclerProcurementConstantsResponseData?>?
      get recyclerResponseModel => _recyclerResponseModel;

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
        HelperFunctions().logger(MessageConstant().somethingWentWrong);
      }
    } catch (err) {
      HelperFunctions().logger("$err");
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
        APIResponse response =
            await _recyclerRepo.postRecyclerProcurementData(request);
        if (response.isSuccess == true) {
          if (context.mounted) {
            state = ViewState.idle;
            HelperFunctions().commonSuccessSnackBar(
                context, MessageConstant().successfullySubmitted);
            MaterialAppViewModel.selectedPageIndex = 1;
            Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.recyclerHomeScreenRoute,
                ModalRoute.withName(AppRoutes.recyclerHomeScreenRoute));
          }
        } else {
          final apiError = response.error?.errorsList;

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
        HelperFunctions()
            .commonErrorSnackBar(context, MessageConstant().somethingWentWrong);
      }
    } catch (e) {
      HelperFunctions().logger('$e');
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
      viewPDF(context, filePath ?? "");
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

  void dropDownValidation() {
    yearDropdownError = financialYearDropdownValue == null
        ? MessageConstant().pleaseSelectValue
        : null;
    rawMaterialDropdownError = rawMaterialDropdownValue == null
        ? MessageConstant().pleaseSelectValue
        : null;
    tyreSourceDropdownError = tyreSourceDropdownValue == null
        ? MessageConstant().pleaseSelectValue
        : null;
    updateUI();
  }

  void financialYearDropDownConverter(newValue) {
    financialYearDropdownValue = newValue;
    if (financialYearDropdownValue != null) {
      String startYear = financialYearDropdownValue!.split('-').first;
      int year = int.parse(startYear);
      startDate = DateTime(year, 4, 1);
      updateUI();
    }
    updateUI();
    if (financialYearDropdownValue == null) {
      yearDropdownError = MessageConstant().pleaseSelectDropdownValue;
    }
  }

  void changeDropdownValue(dropdownType, newValue) {
    switch (dropdownType) {
      case RecyclerProcurementDataDropdown.financialYear:
        financialYearDropDownConverter(newValue);
        yearDropdownError =
            newValue == null ? MessageConstant().pleaseSelectValue : null;
        break;
      case RecyclerProcurementDataDropdown.typeOfRawMaterial:
        rawMaterialDropdownValue = newValue;
        rawMaterialDropdownError =
            newValue == null ? MessageConstant().pleaseSelectValue : null;
        break;
      case RecyclerProcurementDataDropdown.tyreSource:
        tyreSourceDropdownValue = newValue;
        tyreSourceDropdownError =
            newValue == null ? MessageConstant().pleaseSelectValue : null;
        break;
      default:
        break;
    }
    updateUI();
  }

  String? quantityReceivedValidation() {
    return Validations()
        .numbericWithDotValidation(quantityReceivedController.text);
  }

  String? valueValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return MessageConstant().pleaseProvideValue;
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
      return MessageConstant().pleaseUploadInvoice;
    }
    if (fileSizeModel?.fileSize.contains("MB") ?? false) {
      if (fileSizeModel!.fileSizeNum > 2.0) {
        return MessageConstant().maxFileSize;
      }
    }
    return null;
  }

  void formValidation(BuildContext context) {
    dropDownValidation();
    if (formKey.currentState?.validate() ?? false) {
      postData(context);
    }
  }
}

class FileSizeModel {
  String fileSize;
  double fileSizeNum;
  FileSizeModel({required this.fileSize, required this.fileSizeNum});
}
