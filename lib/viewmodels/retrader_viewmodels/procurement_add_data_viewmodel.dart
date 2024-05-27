import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/controllers/retreader/procurement_repository.dart';
import 'package:cpcb_tyre/models/request/retreader/procurement_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ProcurementAddDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  String? yearDropdownValue;
  String? yearDropdownError;
  String? changeDropdown;

  TextEditingController nameOfWasteTyreSupplierController =
      TextEditingController();
  TextEditingController contactDetailsController = TextEditingController();
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
  DateTime? date;

  String? filePath;
  String? fileError;
  String? fileName;
  String? fileSize;
  double? fileSizeNum;
  FileSizeModel? fileSizeModel;
  final _procurementRepo = ProcurementRepository();
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
    String dateText = date.toString();
    dateController.text = HelperFunctions().getFormattedDate(dateText);
    HelperFunctions().logger(dateController.text);
  }

  Future<void> postProcurementData(
      BuildContext context, ProcurementRequestModel request) async {
    state = ViewState.busy;
    try {
      if (formKey.currentState?.validate() ?? false) {
        APIResponse response =
            await _procurementRepo.postProcurementData(request);
        if (response.isSuccess == true) {
          if (context.mounted) {
            state = ViewState.idle;
            HelperFunctions()
                .commonSuccessSnackBar(context,MessageConstant().successfullySubmitted);
            MaterialAppViewModel.selectedPageIndex = 1;
            Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.retraderHomeScreenRoute,
                ModalRoute.withName(AppRoutes.retraderHomeScreenRoute));
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
        HelperFunctions().commonErrorSnackBar(context,MessageConstant().somethingWentWrong);
      }
    } catch (e) {
      HelperFunctions().logger('$e');
    }
    state = ViewState.idle;
  }

  String? contactDetailsValidation() {
    return Validations().validatePhone(contactDetailsController.text);
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
    //  "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    fileSizeNum = bytes / pow(1024, i);
    return FileSizeModel(
        fileSize:
            '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}',
        fileSizeNum: fileSizeNum ?? 0);
    // return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
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

  void changeDropdownValue(newValue) {
    changeDropdown = newValue;
    if (changeDropdown != null) {
      String startYear = changeDropdown!.split('-').first;
      int year = int.parse(startYear);
      startDate = DateTime(year);
      updateUI();
      HelperFunctions().logger(startDate.toString());
    }
    updateUI();
    if (changeDropdown == null) {
      yearDropdownError = MessageConstant().pleaseSelectDropdownValue;
    }
  }

  String? quantityReceivedValidation() {
    return Validations()
        .numbericWithDotValidation(quantityReceivedController.text);
  }

  void onChange() {
    String text = dateController.text;
    if (text.length < newText.length) {
      newText = text;
    } else if (text.isNotEmpty && text != newText) {
      String tempText = text.replaceAll("-", "");
      if (tempText.length == 2 || tempText.length == 4) {
        newText = '$text-';
        dateController.text = newText;
      }
    }
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
    updateUI();
    if (changeDropdown == null) {
      changeDropdownValue(null);
    }
    if (formKey.currentState?.validate() ?? false) {
    } else {}
  }

  void postRequest(BuildContext context) {
    postProcurementData(
        context,
        ProcurementRequestModel(
          uploadInvoice: uploadInvoiceDoc,
          financialYear: changeDropdown,
          sellerName: nameOfWasteTyreSupplierController.text,
          contactDetails: contactDetailsController.text,
          supplierAddress: addressController.text,
          typeOfRawMaterial: typeOfRawMaterialController.text,
          purchaseQuantity: quantityReceivedController.text,
          invoiceNumber: invoiceNumberController.text,
          supplierGstNo: gstController.text,
          purchaseDate: dateController.text.replaceAll("-", "/"),
          sellerMobile: supplierContactDetailsController.text,
        ));
  }
}
class FileSizeModel {
  String fileSize;
  double fileSizeNum;
  FileSizeModel({required this.fileSize, required this.fileSizeNum});
}
