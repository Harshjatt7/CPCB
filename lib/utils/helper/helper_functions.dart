import 'dart:developer';

import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/store_key_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/utils/helper/global_provider_helper.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../store/secure_storage.dart';
import '../../theme/app_color.dart';
import '../../viewmodels/material_app_viewmodel.dart';

class HelperFunctions {
  /// [logger] method will be used to log anything in console in debug mode.
  void logger(String message) {
    if (kDebugMode) {
      log(message);
    }
  }

  /// [commonInformationalSnackBar] will be used to shows an Informational snackbar which consists of blue color.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      commonInformationalSnackBar(
    BuildContext context,
    String message, [
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? closeIconColor,
    Color? outerBorderColor,
    Color? innerBorderColor,
  ]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? AppColor().snackbarBlueBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? AppColor().snackbarBlueBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: outerBorderColor ?? AppColor().snackbarBlueOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: innerBorderColor ?? AppColor().snackbarBlueInnerBorder,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: iconColor ?? AppColor().snackbarBlueIconColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: textColor ?? AppColor().snackbarBlueContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor: closeIconColor ?? AppColor().snackbarBlueContentColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ));
  }

  /// [commonErrorSnackBar] will be used to shows an Error snackbar which consists of red color.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> commonErrorSnackBar(
    BuildContext context,
    String message, [
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? closeIconColor,
    Color? outerBorderColor,
    Color? innerBorderColor,
  ]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? AppColor().snackbarRedBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? AppColor().snackbarRedBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: outerBorderColor ?? AppColor().snackbarRedOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: innerBorderColor ?? AppColor().snackbarRedInnerBorder,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: iconColor ?? AppColor().snackbarRedContentColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: textColor ?? AppColor().snackbarRedContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor: closeIconColor ?? AppColor().snackbarRedContentColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ));
  }

  /// [commonWarningSnackBar] will be used to shows a warning snackbar which consists of yellow color.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      commonWarningSnackBar(
    BuildContext context,
    String message, {
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? closeIconColor,
    Color? outerBorderColor,
    Color? innerBorderColor,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? AppColor().snackbarYellowBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? AppColor().snackbarYellowBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: outerBorderColor ?? AppColor().snackbarYellowOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: innerBorderColor ?? AppColor().snackbarYellowInnerBorder,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: iconColor ?? AppColor().snackbarYellowIconColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: textColor ?? AppColor().snackbarYellowContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor: closeIconColor ?? AppColor().snackbarYellowRemoveIcon,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ));
  }

  /// [commonSuccessSnackBar] will be used to shows a success snackbar which consists of green color.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      commonSuccessSnackBar(
    BuildContext context,
    String message, {
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
    Color? closeIconColor,
    Color? outerBorderColor,
    Color? innerBorderColor,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? AppColor().snackbarGreenBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? AppColor().snackbarGreenBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: outerBorderColor ?? AppColor().snackbarGreenOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: innerBorderColor ?? AppColor().snackbarGreenBackground,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: iconColor ?? AppColor().snackbarGreenContentColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: textColor ?? AppColor().snackbarGreenContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor:
                  closeIconColor ?? AppColor().snackbarGreenContentColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ));
  }

  /// [setUserType] is a method to store user type in keychain
  Future<void> setUserType(String userType, BuildContext context) async {
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().userType, userType);
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
    String userType = await SecureStorage.instance
        .getSensitiveInfo(StoreKeyConstants().userType);
    if (context.mounted) {
      context.globalProvider.userType = userType;
    }
  }

  /// [storeToken] is a method to store login token.
  Future<void> storeToken(BuildContext context, String value) async {
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().token, value);

    if (context.mounted) {
      MaterialAppViewModel.token = value;
    }
  }

  /// [storeRefreshToken] is a method to store login token.
  Future<void> storeRefreshToken(BuildContext context, String value) async {
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().refreshToken, value);

    if (context.mounted) {
      MaterialAppViewModel.refreshToken = value;
    }
  }

  /// [getToken] is a method to store login token.
  Future<void> getToken() async {
    String value = await SecureStorage.instance
        .getSensitiveInfo(StoreKeyConstants().token);

    MaterialAppViewModel.token = value;
  }

  /// [getRefreshToken] is a method to store login token.
  Future<void> getRefreshToken(BuildContext context, String value) async {
    String value = await SecureStorage.instance
        .getSensitiveInfo(StoreKeyConstants().refreshToken);

    if (context.mounted) {
      MaterialAppViewModel.refreshToken = value;
    }
  }

  /// [getFormattedDate] is a method to change Date format.
  String getFormattedDate(String dtStr) {
    var dt = DateTime.parse(dtStr);

    return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
  }

}
