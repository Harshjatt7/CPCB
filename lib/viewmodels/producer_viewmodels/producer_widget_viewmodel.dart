import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class ProducerWidgetViewModel extends BaseViewModel {
  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      //Navigator.pushReplacementNamed(context, AppRoutes.producerRoute);
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();
  String? dropdownValue;
  String? dropdownError;

  changeDropdownValue(newValue) {
    dropdownError = null;
    dropdownValue = newValue;
    updateUI();
    if (dropdownValue == null) {
      dropdownError = "Please select the value";
      updateUI();
    }
  }

  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
}
