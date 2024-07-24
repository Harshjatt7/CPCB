// ignore_for_file: use_build_context_synchronously

import 'package:cpcb_tyre/store/secure_storage.dart';
import 'package:cpcb_tyre/utils/helper/global_provider_helper.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/enums/enums.dart';
import '../../constants/routes_constant.dart';
import '../material_app_viewmodel.dart';

class SplashViewModel extends BaseViewModel {
  final HelperFunctions helperFunctions = HelperFunctions();
  bool? isJailbroken;

  Future<void> initPlatformState(BuildContext context) async {
    bool jailbroken;
    bool developerMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;

      HelperFunctions().logger("developerMode >> $developerMode");
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!context.mounted) return;

    isJailbroken = jailbroken;

    if (isJailbroken == false) {
      wait(context);
    }

    updateUI();
  }

  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    // await SecureStorage.instance.storeSensitiveInfo("isFirstInstall", true);

    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isFirstInstall') ?? true) {
      await SecureStorage.instance.deleteAllValues();

      prefs.setBool('isFirstInstall', false);
    }

    await helperFunctions.getLoginStatus(context);
    if (context.globalProvider.isLogin == false) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
    } else {
      await helperFunctions.getUserType(context);
      switch (MaterialAppViewModel.userTypeEnum ?? UserTypes.custom) {
        case UserTypes.admin:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.adminHomeScreenRoute);
          }
          break;
        case UserTypes.auditor:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.auditorHomeScreen);
          }
          break;
        case UserTypes.spcb:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.spcbHomeScreenRoute);
          }
          break;
        case UserTypes.inspection:
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '');
          }
          break;
        case UserTypes.producer:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.producerHomeScreenRoute);
          }
          break;
        case UserTypes.recycler:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.recyclerHomeScreenRoute);
          }
          break;
        case UserTypes.retreader:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.retraderHomeScreenRoute);
          }
          break;
        case UserTypes.custom:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.customHomeScreenRoute);
          }
          break;
        default:
          Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
          break;
      }
    }
  }
}
