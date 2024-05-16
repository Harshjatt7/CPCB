import 'dart:developer';

import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/utils/helper/global_provider_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../store/secure_storage.dart';
import '../../theme/app_color.dart';
import '../../viewmodels/material_app_viewmodel.dart';
import '../../views/widgets/components/common_text_widget.dart';

class HelperFunctions {
  /// [logger] method will be used to log anything in console in debug mode.
  void logger(String message) {
    if (kDebugMode) {
      log(message);
    }
  }

  /// [showErrorSnackBar] will be used to show a snackbar.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
      BuildContext context, String errorMsg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: AppColor().black,
        content: CommonTextWidget(
          errorMsg.toString(),
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: AppColor().white, fontWeight: FontWeight.bold),
        )));
  }

  /// [setUserType] is a method to store user type in keychain
  Future<void> setUserType(String userType, BuildContext context) async {
    await SecureStorage.instance.storeSensitiveInfo("userType", userType);
    if (context.mounted) {
      context.globalProvider.userType = userType;
      switch (userType) {
        case StringConstants.admin:
          MaterialAppViewModel.userTypeEnum = UserTypes.admin;
          break;
        case StringConstants.other:
          MaterialAppViewModel.userTypeEnum = UserTypes.other;
          break;
        case StringConstants.inspection:
          MaterialAppViewModel.userTypeEnum = UserTypes.inspection;
          break;
        case StringConstants.producer:
          MaterialAppViewModel.userTypeEnum = UserTypes.producer;
          break;
        case StringConstants.recycler:
          MaterialAppViewModel.userTypeEnum = UserTypes.recycler;
          break;
        case StringConstants.retreader:
          MaterialAppViewModel.userTypeEnum = UserTypes.retreader;
          break;
        case StringConstants.custom:
          MaterialAppViewModel.userTypeEnum = UserTypes.custom;
          break;
      }
    }
  }

  /// [getUserType] is a method to store user type in keychain
  Future<void> getUserType(BuildContext context) async {
    String userType = await SecureStorage.instance.getSensitiveInfo("userType");
    if (context.mounted) {
      context.globalProvider.userType = userType;
    }
  }
}
