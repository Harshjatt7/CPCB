import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/theme/text_style_constants.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProducerEnvironmentTile extends StatelessWidget {
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor().greenEAF4EA,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor().blackE5E5E5),
              ),
              child: CommonImageWidget(
                fit: BoxFit.fitWidth,
                imageSource: ImageConstants().calender,
                isNetworkImage: false,
                imageColor: AppColor().black,
              )),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                
                title,
                  style: TextStyleConstants().mediumTextStyle().copyWith(
                      color: AppColor().black999999,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 8.0),
              CommonTextWidget(
                subtitle,
                style: TextStyleConstants().largeTextStyle().copyWith(
                    fontWeight: FontWeight.w600,
                    color: subtitleColor ?? AppColor().black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
