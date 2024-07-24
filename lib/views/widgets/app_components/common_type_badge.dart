import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonTypeBadge extends StatelessWidget {
  const CommonTypeBadge(
      {super.key,
      required this.text,
      this.backgroundColor,
      this.textColor,
      this.isAdmin,
      this.textStyle});
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? isAdmin;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final AppColor appColor = AppColor();
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? appColor.green10,
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: CommonTextWidget(
          text,
          style: textStyle ?? (isAdmin == true
              ? Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: textColor ?? appColor.green)
              : Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: textColor ?? appColor.green)),
        ),
      ),
    );
  }
}
