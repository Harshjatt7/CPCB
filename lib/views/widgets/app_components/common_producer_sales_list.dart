import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerSalesList extends StatelessWidget {
  const ProducerSalesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor().blackE5E5E5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonTextWidget("BiasPly"),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              saleItemWidget(context, ImageConstants().carIcon, "2"),
              const SizedBox(
                width: 48,
              ),
              saleItemWidget(context, ImageConstants().scooterIcon, "2"),
              const SizedBox(
                width: 44,
              ),
              saleItemWidget(context, ImageConstants().truckIcon, "2"),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              saleItemWidget(context, ImageConstants().trainIcon, "2"),
              const SizedBox(
                width: 44,
              ),
              saleItemWidget(context, ImageConstants().bigTruckIcon, "2"),
              const SizedBox(
                width: 44,
              ),
              saleItemWidget(context, ImageConstants().tyreIcon, "2"),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Divider(
            color: AppColor().blackE5E5E5,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              saleItemWidget(
                  context, ImageConstants().calendarIcon, "2022-2023"),
              const SizedBox(
                width: 32,
              ),
              saleItemWidget(context, ImageConstants().calendarIcon, "January"),
              const SizedBox(
                width: 32,
              ),
              saleItemWidget(context, ImageConstants().mdiTireIcon, "19"),
            ],
          ),
        ],
      ),
    );
  }
}

saleItemWidget(BuildContext context, String image, String count) {
  return Row(
    children: [
      CommonImageWidget(
        imageSource: image,
        isNetworkImage: false,
      ),
      const SizedBox(
        width: 8,
      ),
      CommonTextWidget(
        count,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColor().black999999),
      ),
    ],
  );
}
