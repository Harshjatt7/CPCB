import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final String label;
  final double? radius;
  final Color? borderColor;
  final TextStyle? labelStyle;
  final double? height;
  final String? imageSrc;
  final AppColor appColor=AppColor();

   CommonButtonWidget(
      {super.key,
      this.onPressed,
      required this.label,
      this.radius,
      this.color,
      this.labelStyle,
      this.height = 50,
      this.borderColor,
      this.imageSrc});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: Responsive().screenWidth(context),
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor: color ?? appColor.black,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: borderColor ?? appColor.transparent, width: 1),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 5)))),
          child: Row(
            mainAxisAlignment: imageSrc == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (imageSrc != null)
                const SizedBox(
                  width: 27,
                ),
              if (imageSrc != null)
                CommonImageWidget(
                    imageSource: imageSrc!,
                    imageColor: appColor.white,
                    isNetworkImage: false),
              if (imageSrc != null)
                const SizedBox(
                  width: 10,
                ),
              CommonTextWidget(
                label,
                style: labelStyle ??
                    Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: appColor.white, fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }
}
