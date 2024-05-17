import 'dart:developer';
import 'dart:io';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ProducerWidgetViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  String? producerDropdownError;
  String? tyreDropdownError;
  String? yearDropdownError;
  String? monthDropdownError;
  String? changeDropdown;
  
  void changeDropdownValue(dropdownValue, newValue) {
    producerDropdownError = null;
    tyreDropdownError = null;
    yearDropdownError = null;
    monthDropdownError = null;
    changeDropdown = newValue;
    updateUI();
    if (changeDropdown == null) {
      switch (dropdownValue) {
        case "producer":
          producerDropdownError = "Please select the value";
          updateUI();
          break;
        case "tyre":
          tyreDropdownError = "Please select the value";
          updateUI();
          break;
        case "year":
          yearDropdownError = "Please select the value";
          updateUI();
          break;
        case "month":
          monthDropdownError = "Please select the value";
          updateUI();
          break;
        default:
          updateUI();
      }
    }
  }

  String? filename;
  String? fileError;
  Future<FilePickerResult?> openFileManager(context) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path ?? "");
      filename = file.path.split('/').last;
      log(filename ?? "");
      updateUI();
    } else {
      fileError = "Please select a file";
      updateUI();
    }
    return result;
  }

    void viewPDF(BuildContext context, String path) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFView(filePath: path)),
    );
  }


  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      //Navigator.pushReplacementNamed(context, AppRoutes.producerRoute);
    }
  }
}
