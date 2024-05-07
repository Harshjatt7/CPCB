import 'package:flutter/material.dart';
import 'package:cpcb_tyre/theme/text_style_constants.dart';

import '../constants/font_constant.dart';

final _textStyleConstants = TextStyleConstants();
ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      fontFamily: FontConstants().baseFont,
      textTheme: TextTheme(
        bodySmall: _textStyleConstants.extraSmallTextStyle400(),
        bodyMedium: _textStyleConstants.extraSmallTextStyle600(),
        bodyLarge: _textStyleConstants.extraSmallTextStyle700(),
        displaySmall: _textStyleConstants.smallTextStyle400(),
        displayMedium: _textStyleConstants.smallTextStyle600(),
        displayLarge: _textStyleConstants.smallTextStyle700(),
        labelSmall: _textStyleConstants.mediumTextStyle400(),
        labelMedium: _textStyleConstants.mediumTextStyle600(),
        labelLarge: _textStyleConstants.mediumTextStyle700(),
        titleMedium: _textStyleConstants.largeTextStyle600(),
        titleLarge: _textStyleConstants.largeTextStyle700(),
      ));
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
      fontFamily: FontConstants().baseFont,
      textTheme: TextTheme(
           bodySmall: _textStyleConstants.extraSmallTextStyle400(),
        bodyMedium: _textStyleConstants.extraSmallTextStyle600(),
        bodyLarge: _textStyleConstants.extraSmallTextStyle700(),
        displaySmall: _textStyleConstants.smallTextStyle400(),
        displayMedium: _textStyleConstants.smallTextStyle600(),
        displayLarge: _textStyleConstants.smallTextStyle700(),
        labelSmall: _textStyleConstants.mediumTextStyle400(),
        labelMedium: _textStyleConstants.mediumTextStyle600(),
        labelLarge: _textStyleConstants.mediumTextStyle700(),
        titleMedium: _textStyleConstants.largeTextStyle600(),
        titleLarge: _textStyleConstants.largeTextStyle700(),));
}
