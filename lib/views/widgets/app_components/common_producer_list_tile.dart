import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerListTile extends StatelessWidget {
  /// [ProducerListTile] will be used as the common producer list tile in this project.
  ///
  /// [title] is required field to use this widget.
  ///
  /// [subtitle] is required field to use this widget.
  /// [image] is optional, and can be used if any other widget if needed, instead it will use a
  /// default info icon.
  /// [color] is optional, it will use a defualt white color.
  ///
  const ProducerListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      this.image,
      this.color,
      this.isBackgroundIcon = false});
  final String title;
  final String subtitle;
  final String? image;
  final Color? color;
  final bool isBackgroundIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? AppColor().white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColor().grey03,
          )),
      child: ListTile(
        minVerticalPadding: 17,
        leading: isBackgroundIcon == true
            ? Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColor().green10,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor().black10),
                ),
                child: CommonImageWidget(
                  imageSource: image ?? ImageConstants().info,
                  isNetworkImage: false,
                  width: 25,
                ),
              )
            : CommonImageWidget(
                imageSource: image ?? ImageConstants().info,
                isNetworkImage: false,
                width: 47,
              ),
        title: Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 5),
            child: CommonTextWidget(title,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: AppColor().black70))),
        subtitle: CommonTextWidget(
          subtitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
