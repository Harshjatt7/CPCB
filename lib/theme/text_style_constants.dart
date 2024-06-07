import 'package:flutter/material.dart';
import 'package:cpcb_tyre/constants/font_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';

class TextStyleConstants {
  final FontConstants fontConstants=FontConstants();
  final AppColor appColor=AppColor();
  TextStyle extraSmallTextStyle400() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.light,
        fontWeight: FontWeight.w400,
        color: appColor.black);
  }

  TextStyle extraSmallTextStyle600() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.light,
        fontWeight: FontWeight.w600,
        color: appColor.black);
  }

  TextStyle extraSmallTextStyle700() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.light,
        fontWeight: FontWeight.w700,
        color: appColor.black);
  }

  TextStyle smallTextStyle400() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.small,
        fontWeight: FontWeight.w400,
        color: appColor.black);
  }

  TextStyle smallTextStyle600() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.small,
        fontWeight: FontWeight.w600,
        color: appColor.black);
  }

  TextStyle smallTextStyle700() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.small,
        fontWeight: FontWeight.w700,
        color: appColor.black);
  }

  TextStyle mediumTextStyle400() {
    return TextStyle(
      fontFamily: fontConstants.baseFont,
      fontSize: fontConstants.medium,
      fontWeight: FontWeight.w400,
      color: appColor.black,
    );
  }

  TextStyle mediumTextStyle600() {
    return TextStyle(
      fontFamily: fontConstants.baseFont,
      fontSize: fontConstants.medium,
      fontWeight: FontWeight.w600,
      color: appColor.black,
    );
  }

  TextStyle mediumTextStyle700() {
    return TextStyle(
      fontFamily: fontConstants.baseFont,
      fontSize: fontConstants.medium,
      fontWeight: FontWeight.w700,
      color: appColor.black,
    );
  }

  TextStyle largeTextStyle600() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.large,
        fontWeight: FontWeight.w600,
        color: appColor.black);
  }

  TextStyle largeTextStyle700() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.large,
        fontWeight: FontWeight.w700,
        color: appColor.black);
  }

  TextStyle extraLargeTextStyle() {
    return TextStyle(
        fontFamily: fontConstants.baseFont,
        fontSize: fontConstants.large,
        color: appColor.black);
  }
}
