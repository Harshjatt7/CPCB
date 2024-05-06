import 'package:flutter/material.dart';

class Responsive {
  double givenHeight = 812;
  double givenWidth = 375;

  static Size screenSizes = const Size(0, 0);

  Size getScreenSize(BuildContext context) {
    screenSizes = MediaQuery.of(context).size;
    return screenSizes;
  }

  double screenWidth(BuildContext context) {
    return screenSizes.width == 0
        ? getScreenSize(context).width
        : screenSizes.width;
  }

  double screenHeight(BuildContext context) {
    return screenSizes.height == 0
        ? getScreenSize(context).height
        : screenSizes.height;
  }

  bool isTablet(BuildContext context) {
    final data = screenSizes.width == 0
        ? getScreenSize(context).width
        : screenSizes.width;

    return data < 600 ? false : true;
  }
}
