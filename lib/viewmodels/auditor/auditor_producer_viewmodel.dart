import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class AuditorProducerViewModel extends BaseViewModel {
  TextEditingController companyNameController = TextEditingController();
  String companyNameGroupVal = "Confirmed";

  void changeComapnyNameGroupVal(String? val) {
    if (val != null) {
      companyNameGroupVal = val;
    }

    notifyListeners();
  }

  void initialize() {
    companyNameController = TextEditingController(text: "1231298i0eiq091");
  }
}
