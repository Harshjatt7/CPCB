import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class CommonStepperViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  int index = 1;
  int totalIndex = 0;
  void getUser(String? user) {
    switch (user) {
      case "Producer":
        totalIndex = 3;
        break;
      case "Recycler":
        totalIndex = 5;
        break;
      default:
        totalIndex = 3;
        break;
    }
    updateUI();
  }

  void onBackButton(BuildContext context) {
    if (index > 1) {
      index--;
      updateUI();
    } else {
      Navigator.pop(context);
    }
  }

  void onNextButton(BuildContext context, String? user) {
    switch (user) {
      case "Producer":
        if (index < 3) {
          index++;
          updateUI();
        }
        break;
      case "Recycler":
        if (index < 5) {
          index++;
          updateUI();
        }
        break;
      default:
        if (index < 5) {
          index++;
          updateUI();
        }
        break;
    }
  }

  void formValidation(BuildContext context, String? userType) {
    if (formKey.currentState?.validate() ?? false) {
      onNextButton(context, userType);
    } else {}
  }
}
