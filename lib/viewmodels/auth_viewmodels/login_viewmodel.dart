import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController userTypeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? selectedUserType;
  bool isObscure = true;

  bool isBtnEnabled = false;
  final List<String> userTypes = [
    "Admin",
    "Other Users (SPCB, Auditor, RD’S) ",
    "Inspection",
    "Producer",
    "Retreader",
    "Recycler",
    "Custom"
  ];

  bool isEnabled() {
    isBtnEnabled = (emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        selectedUserType != null);
    notifyListeners();
    return isBtnEnabled;
  }

  void onUserTypeChanged(dynamic value) {
    selectedUserType = value;
    notifyListeners();
  }
}
