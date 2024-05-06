import 'package:flutter/material.dart';
import 'package:cpcb_tyre/theme/text_style_constants.dart';

import '../constants/font_constant.dart';

final _textStyleConstants = TextStyleConstants();
ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      fontFamily: FontConstants().baseFont,
      textTheme: TextTheme(
          displayLarge: _textStyleConstants.largeTextStyle(),
          displayMedium: _textStyleConstants.mediumTextStyle(),
          displaySmall: _textStyleConstants.extraSmallTextStyle()));
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
      fontFamily: FontConstants().baseFont,
      textTheme: TextTheme(
          displayLarge: _textStyleConstants.largeTextStyle(),
          displayMedium: _textStyleConstants.mediumTextStyle(),
          displaySmall: _textStyleConstants.extraSmallTextStyle()));
}
