import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerEnvironmentTile extends StatelessWidget {
  /// [ProducerEnvironmentTile] will be used as the common producer Environment list in this project.
  ///
  /// [title] is required field to use this widget.
  ///
  /// [subtitle] is required field to use this widget.
  ///
  /// [image] is optional, it will use a default info icon.
  ///
  /// [subtitleColor]is optional, it will will use a default subtitle color.
  const ProducerEnvironmentTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.subtitleColor,
  });

  final String title;
  final String image;
  final String subtitle;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor().green10,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor().black10),
              ),
              child: CommonImageWidget(
                imageSource: image,
                isNetworkImage: false,
                imageColor: AppColor().black,
              )),
        ),
        const SizedBox(
          width: 14,
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: AppColor().black40),
              ),
              const SizedBox(height: 8.0),
              CommonTextWidget(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: subtitleColor ?? AppColor().black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
