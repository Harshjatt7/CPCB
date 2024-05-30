// ignore_for_file: use_build_context_synchronously

import 'package:cpcb_tyre/store/secure_storage.dart';
import 'package:cpcb_tyre/utils/helper/global_provider_helper.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/enums.dart';
import '../../constants/routes_constant.dart';
import '../material_app_viewmodel.dart';

class SplashViewModel extends BaseViewModel {
  Future wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    await SecureStorage.instance.storeSensitiveInfo("isFirstInstall", true);

    await HelperFunctions().getLoginStatus(context);

    if (context.globalProvider.isLogin == false) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
    } else {
      await HelperFunctions().getUserType(context);
      switch (MaterialAppViewModel.userTypeEnum ?? UserTypes.custom) {
        case UserTypes.admin:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.producerHomeScreenRoute);
          }
          break;
        case UserTypes.auditor:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.producerHomeScreenRoute);
          }
          break;
        case UserTypes.spcb:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.producerHomeScreenRoute);
          }
          break;
        case UserTypes.inspection:
          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.producerHomeScreenRoute);
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
                context, AppRoutes.producerHomeScreenRoute);
          }
          break;
        default:
          Navigator.pushReplacementNamed(
              context, AppRoutes.producerHomeScreenRoute);
          break;
      }
    }
  }
}
