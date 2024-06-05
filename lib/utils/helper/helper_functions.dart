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
import 'package:intl/intl.dart';

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

  /// [commonCommonSnackBar] will be used to shows a common snackbar which consists of blue color.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      commonCommonSnackBar(
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

  /// [commonInformationalSnackBar] will be used to shows an Informational snackbar which consists of blue color.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      commonInformationalSnackBar(
    BuildContext context,
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColor().snackbarBlueBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor().snackbarBlueBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColor().snackbarBlueOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor().snackbarBlueInnerBorder,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: AppColor().snackbarBlueIconColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColor().snackbarBlueContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor: AppColor().snackbarBlueContentColor,
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
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColor().snackbarRedBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor().snackbarRedBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColor().snackbarRedOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor().snackbarRedInnerBorder,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: AppColor().snackbarRedContentColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColor().snackbarRedContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor: AppColor().snackbarRedContentColor,
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
      commonWarningSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColor().snackbarYellowBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor().snackbarYellowBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColor().snackbarYellowOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor().snackbarYellowInnerBorder,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: AppColor().snackbarYellowIconColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColor().snackbarYellowContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor: AppColor().snackbarYellowRemoveIcon,
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
      commonSuccessSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColor().snackbarGreenBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor().snackbarGreenBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColor().snackbarGreenOuterBorder,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor().snackbarGreenBackground,
                shape: BoxShape.circle,
              ),
              child: CommonImageWidget(
                imageColor: AppColor().snackbarGreenContentColor,
                imageSource: ImageConstants().informationalIcon,
                isNetworkImage: false,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: CommonTextWidget(message,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColor().snackbarGreenContentColor)),
          ),
          const Spacer(),
          IconButton(
            icon: CommonImageWidget(
              imageSource: ImageConstants().closeX,
              isNetworkImage: false,
              imageColor: AppColor().snackbarGreenContentColor,
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
        case StringConstants.auditor:
          MaterialAppViewModel.userTypeEnum = UserTypes.auditor;
          break;
        case StringConstants.spcb:
          MaterialAppViewModel.userTypeEnum = UserTypes.spcb;
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

  /// [setLoginStatus] is a method to set login status in keychain
  Future<void> setLoginStatus(BuildContext context, bool value) async {
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().isLogin, value);

    if (context.mounted) {
      context.globalProvider.isLogin = value;
    }
  }

  /// [getLoginStatus] is a method to get login status from keychain
  Future<void> getLoginStatus(BuildContext context) async {
    bool isLogin = await SecureStorage.instance
            .getSensitiveInfo(StoreKeyConstants().isLogin) ??
        false;

    if (context.mounted) {
      context.globalProvider.isLogin = isLogin;
    }
  }

  /// [getUserType] is a method to store user type in keychain
  Future<void> getUserType(BuildContext context) async {
    String userType = await SecureStorage.instance
            .getSensitiveInfo(StoreKeyConstants().userType) ??
        "";

    if (context.mounted) {
      context.globalProvider.userType = userType;
      switch (userType) {
        case StringConstants.admin:
          MaterialAppViewModel.userTypeEnum = UserTypes.admin;
          break;
        case StringConstants.auditor:
          MaterialAppViewModel.userTypeEnum = UserTypes.auditor;
          break;
        case StringConstants.spcb:
          MaterialAppViewModel.userTypeEnum = UserTypes.spcb;
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

    if (context.mounted) {
      context.globalProvider.userType = userType;
    }
  }

  /// [storeToken] is a method to store login token.
  Future<void> storeToken(String value) async {
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().token, value);

    MaterialAppViewModel.token = value;
  }

  /// [storeRefreshToken] is a method to store login token.
  Future<void> storeRefreshToken(String value) async {
    await SecureStorage.instance
        .storeSensitiveInfo(StoreKeyConstants().refreshToken, value);

    MaterialAppViewModel.refreshToken = value;
  }

  /// [getToken] is a method to store login token.
  Future<void> getToken() async {
    String value = await SecureStorage.instance
        .getSensitiveInfo(StoreKeyConstants().token);

    MaterialAppViewModel.token = value;
  }

  /// [getRefreshToken] is a method to store login token.
  Future<void> getRefreshToken() async {
    String value = await SecureStorage.instance
        .getSensitiveInfo(StoreKeyConstants().refreshToken);

    MaterialAppViewModel.refreshToken = value;
  }

  /// [getFormattedDate] is a method to change Date format.
  String getFormattedDate({DateTime? date, String? dtstr}) {
    String formattedDate = "";
    DateTime? dateTime;
    if (date != null) {
      dateTime = date;
    } else if (dtstr != null && dtstr != 'N/A') {
      if (dtstr.contains('/')) {
        dateTime = DateFormat('dd/MM/yyyy').parse(dtstr);
      } else {
        dateTime = DateTime.tryParse(dtstr);
      }
    } else if (dtstr != null && dtstr == 'N/A') {
      return dtstr;
    }
    try {
      if (dateTime != null) {
        formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      }
      // "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";

      return formattedDate;
    } catch (err) {
      return formattedDate;
    }
  }

  ///[datePicker] Common Date Picker
  Future<DateTime?> datePicker(BuildContext context, DateTime firstDate) {
    return showDatePicker(
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    onPrimary: AppColor().white, // selected text color
                    onSurface: AppColor().darkGreen, // default text color
                    primary: AppColor().darkGreen // circle color
                    ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: AppColor().darkGreen,
                        textStyle: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor()
                                    .white), // color of button's letters

                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppColor().transparent,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)))),
                dialogTheme: DialogTheme(
                    backgroundColor: AppColor().white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
              child: child!);
        },
        context: context,
        firstDate: firstDate,
        lastDate: DateTime.now());
  }

  ///[precisionFormat] Common Date Picker
  String precisionFormat(num? value) {
    return value == null ? '' : value.toStringAsFixed(2);
  }
}
