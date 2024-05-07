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
  const ProducerListTile(
      {super.key, required this.title, required this.subtitle, this.image});
  final String title;
  final String subtitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColor().greyD3D3D3,
          )),
      child: ListTile(
        minVerticalPadding: 17,
        leading: CommonImageWidget(
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
                    ?.copyWith(color: AppColor().black4D4D4D))),
        subtitle: CommonTextWidget(
          subtitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
