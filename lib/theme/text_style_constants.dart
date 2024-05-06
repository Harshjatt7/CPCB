import 'package:flutter/material.dart';
import 'package:cpcb_tyre/constants/font_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';

class TextStyleConstants {
  TextStyle extraSmallTextStyle() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().light,
        color: AppColor().black);
  }

  TextStyle smallTextStyle() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().small,
        color: AppColor().black);
  }

  TextStyle mediumTextStyle() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().medium,
        color: AppColor().black);
  }

  TextStyle largeTextStyle() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().large,
        color: AppColor().black);
  }

  TextStyle extraLargeTextStyle() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().extraLarge,
        color: AppColor().black);
  }
}
