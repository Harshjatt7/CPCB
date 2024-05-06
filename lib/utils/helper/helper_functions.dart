import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
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
}
