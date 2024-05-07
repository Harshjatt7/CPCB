import 'package:flutter/material.dart';
import 'package:cpcb_tyre/constants/font_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';

class TextStyleConstants {
  TextStyle extraSmallTextStyle400() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().light,
        fontWeight: FontWeight.w400,
        color: AppColor().black);
  }

  TextStyle extraSmallTextStyle600() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().light,
        fontWeight: FontWeight.w600,
        color: AppColor().black);
  }

  TextStyle extraSmallTextStyle700() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().light,
        fontWeight: FontWeight.w700,
        color: AppColor().black);
  }

  TextStyle smallTextStyle400() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().small,
        fontWeight: FontWeight.w400,
        color: AppColor().black);
  }

  TextStyle smallTextStyle600() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().small,
        fontWeight: FontWeight.w600,
        color: AppColor().black);
  }

  TextStyle smallTextStyle700() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().small,
        fontWeight: FontWeight.w700,
        color: AppColor().black);
  }

  TextStyle mediumTextStyle400() {
    return TextStyle(
      fontFamily: FontConstants().baseFont,
      fontSize: FontConstants().medium,
      fontWeight: FontWeight.w400,
      color: AppColor().black,
    );
  }

  TextStyle mediumTextStyle600() {
    return TextStyle(
      fontFamily: FontConstants().baseFont,
      fontSize: FontConstants().medium,
      fontWeight: FontWeight.w600,
      color: AppColor().black,
    );
  }

  TextStyle mediumTextStyle700() {
    return TextStyle(
      fontFamily: FontConstants().baseFont,
      fontSize: FontConstants().medium,
      fontWeight: FontWeight.w700,
      color: AppColor().black,
    );
  }

  TextStyle largeTextStyle600() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().large,
        fontWeight: FontWeight.w600,
        color: AppColor().black);
  }

  TextStyle largeTextStyle700() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().large,
        fontWeight: FontWeight.w700,
        color: AppColor().black);
  }

  TextStyle extraLargeTextStyle() {
    return TextStyle(
        fontFamily: FontConstants().baseFont,
        fontSize: FontConstants().large,
        color: AppColor().black);
  }
}
