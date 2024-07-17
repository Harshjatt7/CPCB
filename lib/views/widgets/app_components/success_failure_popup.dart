// ignore_for_file: must_be_immutable

import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';
import '../../../utils/helper/responsive_helper.dart';
import '../components/common_image_widget.dart';
import '../components/common_text_widget.dart';

class SuccessFailedDialog extends StatefulWidget {
  String? title;
  TextStyle? titleStyle;
  Color? topContainerBgColor;
  String buttonText;
  String? thumbImage;
  String? requestNumber;
  String? imageDone;
  double? dialogHeight;
  double? height;
  double? width;
  String? description;
  String? shortDescription;
  VoidCallback? onTap;
  bool? giveStaticDialogHeight;

  SuccessFailedDialog(
      {this.title,
      this.titleStyle,
      this.topContainerBgColor,
      required this.buttonText,
      this.thumbImage,
      this.description,
      this.shortDescription,
      this.dialogHeight,
      this.onTap,
      this.requestNumber,
      this.imageDone,
      this.height,
      this.width,
      this.giveStaticDialogHeight = true,
      super.key});

  @override
  State<SuccessFailedDialog> createState() => _SuccessFailedDialogState();
}

class _SuccessFailedDialogState extends State<SuccessFailedDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.giveStaticDialogHeight == true
          ? widget.dialogHeight ?? 220
          : null,
      width: Responsive().screenWidth(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColor().white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.thumbImage != null
              ? CommonImageWidget(
                  imageSource: widget.thumbImage!,
                  isNetworkImage: false,
                  height: widget.height,
                  bgColor: AppColor().transparent,
                  width: widget.width,
                )
              : Container(
                  height: 62,
                  decoration: BoxDecoration(
                    color: widget.topContainerBgColor ?? AppColor().transparent,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.imageDone != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CommonImageWidget(
                                isNetworkImage: false,
                                imageSource: widget.imageDone!,
                                height: widget.height,
                                width: widget.width,
                                bgColor: AppColor().transparent,
                              ))
                          : const SizedBox(),
                      CommonTextWidget(
                        widget.title ?? "",
                        style: widget.titleStyle ??
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 20,
                                color: AppColor().white,
                                letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 12,
          ),
          if (widget.shortDescription != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonTextWidget(
                    widget.shortDescription ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  CommonTextWidget(
                    widget.requestNumber ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CommonTextWidget(
              widget.description ?? "",
              useLocalization: false,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CommonButtonWidget(
              onPressed: widget.onTap,
              label: widget.buttonText,
              radius: 8,
              borderColor: AppColor().black,
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
