import 'dart:io';

import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  String? filename;
  String? fileError;

  void openFileManager(context) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result != null) {
      final file = File(result.files.single.path ?? "");
      filename = file.path.split('/').last;
      updateUI();
    } else {
      fileError = "Please select a file";
      updateUI();
    }
  }

  void addYear() {
    for (int i = 0; i < 50; i++) {
      financialYearList.add("${DateTime.now().year + (i)}");
    }
  }

  void changeDropdownValue(newValue) {
    changeDropdown = newValue;
    updateUI();
    if (changeDropdown == null) {
      yearDropdownError = "Please select a value from dropdown";
    }
  }

  String? valueValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return "Please provide a value";
    } else {
      return null;
    }
  }

  String? dateValidation() {
    if (dateController.text.isEmpty) {
      return "Please select a date";
    }
    return null;
  }

  String? uploadInvoiceValidation() {
    if (uploadInvoiceController.text.isEmpty) {
      return "Please upload the invoice file";
    }
    return null;
  }

  void formValidation() {
    updateUI();
    changeDropdownValue(null);
    if (formKey.currentState?.validate() ?? false) {}
  }
}
