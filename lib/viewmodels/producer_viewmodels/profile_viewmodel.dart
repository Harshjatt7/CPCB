import 'package:cpcb_tyre/store/secure_storage.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/routes_constant.dart';

class ProfileViewModel extends BaseViewModel {
  void clearAppData(context) async {
    await SecureStorage.instance.deleteAllValues();
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginScreenRoute, (route) => false);
  }
}
