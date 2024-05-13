import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerErpTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const ProducerErpTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 22, bottom: 22),
      width: Responsive().givenWidth,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor().blackUltraLight, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Row(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: AppColor().blackUltraLight, width: 1)),
              child: CommonImageWidget(
                  fit: BoxFit.cover, imageSource: image, isNetworkImage: false),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CommonTextWidget(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColor().darkGrey,
                     ),
                ),
              ),
              CommonTextWidget(subTitle,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColor().blackMedium,
                      fontWeight: FontWeight.w700,
                      fontSize: 24)),
            ],
          )
        ],
      ),
    );
  }
}
