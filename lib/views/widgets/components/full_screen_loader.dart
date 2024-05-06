import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import '../../../utils/helper/responsive_helper.dart';
import 'common_text_widget.dart';

class FullScreenLoader extends StatelessWidget {
  final double? height;
  final Alignment? alignment;
  final Color? color;
  final Color? bgColor;
  final String? loaderText;
  final double? placeLoaderAfterHeight;
  const FullScreenLoader(
      {super.key,
      this.height,
      this.alignment,
      this.color,
      this.bgColor,
      this.loaderText,
      this.placeLoaderAfterHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? AppColor().white.withOpacity(0.4),
      height: height ?? Responsive().screenHeight(context),
      alignment: alignment ?? Alignment.center,
      child: Column(
        mainAxisAlignment: placeLoaderAfterHeight != null
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (placeLoaderAfterHeight != null)
            SizedBox(
              height: placeLoaderAfterHeight,
            ),
          if (loaderText != null)
            CommonTextWidget(
              loaderText ?? "",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColor().black),
            ),
          if (loaderText != null)
            const SizedBox(
              height: 10,
            ),
          CircularProgressIndicator(
            color: color ?? AppColor().black,
          ),
        ],
      ),
    );
  }
}
