import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/theme/text_style_constants.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerListTile extends StatelessWidget {
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
                style: TextStyleConstants().mediumTextStyle().copyWith(
                    color: AppColor().black4D4D4D,
                    fontWeight: FontWeight.w400))),
        subtitle: CommonTextWidget(subtitle,
            style: TextStyleConstants().largeTextStyle().copyWith(
                color: AppColor().black, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
