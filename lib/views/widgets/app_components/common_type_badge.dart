import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonTypeBadge extends StatelessWidget {
  const CommonTypeBadge(
      {super.key, required this.text, this.backgroundColor, this.textColor});
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColor().green10,
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: CommonTextWidget(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: textColor ?? AppColor().green),
        ),
      ),
    );
  }
}
