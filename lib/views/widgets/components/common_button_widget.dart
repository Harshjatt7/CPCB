import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final String label;
  final double? radius;
  final Color? borderColor;
  final TextStyle? labelStyle;

  const CommonButtonWidget(
      {super.key,
      this.onPressed,
      required this.label,
      this.radius,
      this.color,
      this.labelStyle,
      this.borderColor});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive().screenWidth(context),
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: color ?? AppColor().black,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: borderColor ?? AppColor().transparent, width: 2),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 5)))),
          child: CommonTextWidget(
            label,
            style: labelStyle ??
                Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor().white, fontWeight: FontWeight.w600),
          )),
    );
  }
}
