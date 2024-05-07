import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final Color? fontColor;
  final String label;
  final double? radius;
  final FontWeight? fontWeight;
  final Color? borderColor;

  const CommonButtonWidget(
      {super.key,
      required this.onPressed,
      required this.label,
      this.radius,
      required this.color,
      required this.fontColor,
       this.fontWeight,
      this.borderColor});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive().screenWidth(context),
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: borderColor ?? AppColor().transparent, width: 2),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 5)))),
          child: CommonTextWidget(
            label,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: fontColor, fontWeight: fontWeight ?? FontWeight.w600),
          )),
    );
  }
}
