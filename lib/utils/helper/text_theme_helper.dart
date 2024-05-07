import 'package:flutter/material.dart';

extension TextThemeHelper on BuildContext {
  /// returns text theme from ThemeData.
  TextTheme get textThemeHelper {
    return Theme.of(this).textTheme;
  }
}
