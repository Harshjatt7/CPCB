import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerForm5ViewModel extends BaseViewModel {
  TextEditingController etpCapacityController = TextEditingController();
  TextEditingController etpRemarksInstalledController = TextEditingController();
  TextEditingController etpRemarksCapacityController = TextEditingController();
  TextEditingController summmaryRemakrController = TextEditingController();

  String radioInstalled = 'confirmed';
  String radioCapacity = 'confirmed';
  final MessageConstant messageConstant = MessageConstant();
  String? installDropdownValue;
  List installList = <String>[];

  String? summaryValidation() {
    if (summmaryRemakrController.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

  void changeDropdownValue(newValue) {
    installDropdownValue = newValue;
    updateUI();
  }
}
