import 'dart:developer';
import 'dart:io';

import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProducerViewModel extends BaseViewModel {
  String dropdownValue = "";
  changeDropdownValue(newValue) {
    dropdownValue = newValue;
    log(dropdownValue);
    updateUI();
  }

  File? _file;
  String? fileName;
  openFileManager(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path ?? "");
      _file = file;
      fileName = file.path.split('/').last;     
      log(fileName??"");
      updateUI();
    } else {
      log('Please select file');
    }
  }

  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      //Navigator.pushReplacementNamed(context, AppRoutes.producerRoute);
    }
  }
}
