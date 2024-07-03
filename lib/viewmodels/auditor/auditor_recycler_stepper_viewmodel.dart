import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerStepperViewModel extends BaseViewModel {
  int index = 1;
  int totalIndex = 5;

  void onBackButton(BuildContext context) {
    if (index > 1) {
      index--;
      updateUI();
    } else {
      Navigator.pop(context);
    }
  }

  void onNextButton(BuildContext context) {
    if (index < 5) {
      index++;
      updateUI();
    }
  }
}
