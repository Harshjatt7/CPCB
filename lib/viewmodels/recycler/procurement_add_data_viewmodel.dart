import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class RecyclerProcurementAddDataViewModel extends BaseViewModel {
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

  String? filePath;
  String? fileError;
  String? fileName;
  String? fileSize;
  double? fileSizeNum;
  FileSizeModel? fileSizeModel;

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
      fileError = "Please select a file";
      updateUI();
    }
    return result;
  }

  String? contactDetailsValidation() {
    return Validations().validatePhone(contactDetailsController.text);
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
      await openFileManager(context);
    } else {
      viewPDF(context, filePath ?? "");
    }
  }

  void handleOnSuffixTap(BuildContext context) {
    if (uploadInvoiceController.text.isEmpty) {
      openFileManager(context);
    } else {
      uploadInvoiceController.text = "";
      filePath = null;
      updateUI();
    }
  }

  void changeDropdownValue(newValue) {
    changeDropdown = newValue;
    updateUI();
    if (changeDropdown == null) {
      yearDropdownError = "Please select a value from dropdown";
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
      return "Please provide a value";
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
    HelperFunctions().logger(fileSizeModel?.fileSize ?? "");
    if (uploadInvoiceController.text.isEmpty) {
      return "Please upload the invoice file";
    }
    if (fileSizeModel?.fileSize.contains("MB") ?? false) {
      if (fileSizeModel!.fileSizeNum > 2.0) {
        return "Max file size 2 mb";
      }
    }
    return null;
  }

  void formValidation() {
    updateUI();
    if (changeDropdown == null) {
      changeDropdownValue(null);
    }
    if (formKey.currentState?.validate() ?? false) {
     
    }
  }
}

class FileSizeModel {
  String fileSize;
  double fileSizeNum;
  FileSizeModel({required this.fileSize, required this.fileSizeNum});
}
