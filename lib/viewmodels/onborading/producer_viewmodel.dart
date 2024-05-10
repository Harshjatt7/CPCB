import 'dart:developer';
import 'dart:io';

import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProducerViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  String? dropdownValue;
  changeDropdownValue(newValue) {
    dropdownValue = newValue;
    log(dropdownValue??"");
    updateUI();
  }

  String? filename;
  String? response;
  openFileManager(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path ?? "");
      filename = file.path.split('/').last;
      log(filename ?? "");
      updateUI();
    } else {
      response= "Please select a file";
      updateUI();
    }
  }

  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      //Navigator.pushReplacementNamed(context, AppRoutes.producerRoute);
    }
  }
}
