import 'package:cpcb_tyre/store/secure_storage.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/routes_constant.dart';

class SplashViewModel extends BaseViewModel {
  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    SecureStorage.instance.storeSensitiveInfo("isFirstInstall", true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
    }
  }
}
