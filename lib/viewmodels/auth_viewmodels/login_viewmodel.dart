import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController userTypeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isBtnEnabled = false;

  bool isEnabled() {
    isBtnEnabled =
        (emailController.text.isNotEmpty && passController.text.isNotEmpty);
    notifyListeners();
    return isBtnEnabled;
  }
}
