import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonDocumentField extends StatelessWidget {
  final VoidCallback? onTap;
  final String? fileName;
  final String label;
  final String? error;
  final AppColor appColor = AppColor();
  CommonDocumentField(
      {super.key,
      required this.onTap,
      this.fileName,
      required this.label,
      this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: appColor.grey03)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: CommonTextWidget(fileName ?? label,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: fileName != null
                                      ? appColor.blue100
                                      : appColor.grey01)),
                    ),
                    WidgetSpan(
                      child: CommonTextWidget(fileName == null ? " *" : "",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: appColor.red)),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onTap,
                child: CommonImageWidget(
                  imageSource: ImageConstants().fileUpload,
                  isNetworkImage: false,
                ),
              ),
            ],
          ),
        ),
        if (error != null)
          Align(
            alignment: Alignment.topLeft,
            child: CommonTextWidget(
              error.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: appColor.red),
            ),
          ),
      ],
    );
  }
}
