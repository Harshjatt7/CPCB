import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerSalesList extends StatelessWidget {
  const ProducerSalesList({
    super.key,
    required this.title,
    this.car,
    this.train,
    this.scooter,
    this.deliveryTruck,
    this.truck,
    this.tyre,
    required this.year,
    required this.month,
    required this.count,
  });
  final String title;
  final String? car;
  final String? train;
  final String? scooter;
  final String? deliveryTruck;
  final String? truck;
  final String? tyre;
  final String year;
  final String month;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor().blackDisabledButton),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  saleItemWidget(context, ImageConstants().carIcon, car ?? ""),
                  const SizedBox(
                    height: 8,
                  ),
                  saleItemWidget(
                      context, ImageConstants().trainIcon, train ?? ""),
                ],
              ),
              const SizedBox(
                width: 44,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  saleItemWidget(
                      context, ImageConstants().scooterIcon, scooter ?? ""),
                  const SizedBox(
                    height: 8,
                  ),
                  saleItemWidget(context, ImageConstants().deliveryTruck,
                      deliveryTruck ?? ""),
                ],
              ),
              const SizedBox(
                width: 44,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  saleItemWidget(
                      context, ImageConstants().truckIcon, truck ?? ""),
                  const SizedBox(
                    height: 8,
                  ),
                  saleItemWidget(
                      context, ImageConstants().tyreIcon, tyre ?? ""),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Divider(
            color: AppColor().blackDisabledButton,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              saleItemWidget(context, ImageConstants().calendarIcon, year),
              const SizedBox(
                width: 32,
              ),
              saleItemWidget(context, ImageConstants().calendarIcon, month),
              const SizedBox(
                width: 32,
              ),
              saleItemWidget(context, ImageConstants().mdiTireIcon, count),
            ],
          ),
        ],
      ),
    );
  }
}

Widget saleItemWidget(BuildContext context, String image, String count) {
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
