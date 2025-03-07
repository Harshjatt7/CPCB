import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_type_badge.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class ProducerSalesList extends StatelessWidget {
  ProducerSalesList({
    super.key,
    required this.title,
    this.motorcycle,
    this.bus,
    this.scooter,
    this.passengerCar,
    this.truck,
    this.tcv,
    this.tRear,
    this.other,
    required this.year,
    required this.month,
    required this.count,
    required this.producerType,
  });
  final String title;
  final String? motorcycle;
  final String? bus;
  final String? scooter;
  final String? passengerCar;
  final String? truck;
  final String? tcv;
  final String? tRear;
  final String? other;
  final String year;
  final String month;
  final String count;
  final String producerType;
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: appColor.black10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonTextWidget(
                title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                width: 10,
              ),
              CommonTypeBadge(text: producerType),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  saleItemWidget(
                      context, imageConstants.motorcycle, motorcycle ?? ""),
                  const SizedBox(
                    height: 8,
                  ),
                  saleItemWidget(context, imageConstants.bus, bus ?? ""),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  saleItemWidget(
                      context, imageConstants.passengerCar, passengerCar ?? ""),
                  const SizedBox(
                    height: 8,
                  ),
                  saleItemWidget(context, imageConstants.tcv, tcv ?? ""),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  saleItemWidget(
                      context, imageConstants.scooterIcon, scooter ?? "0"),
                  const SizedBox(
                    height: 8,
                  ),
                  saleItemWidget(context, imageConstants.tRear, tRear ?? "0"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  saleItemWidget(
                      context, imageConstants.truckIcon, truck ?? "0"),
                  const SizedBox(
                    height: 8,
                  ),
                  saleItemWidget(context, imageConstants.other, other ?? "0"),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Divider(
            color: appColor.black10,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              saleItemWidget(context, imageConstants.calendarIcon, year,
                  isWeight: true),
              const SizedBox(
                width: 32,
              ),
              saleItemWidget(context, imageConstants.calendarIcon, month,
                  isWeight: true),
              const SizedBox(
                width: 32,
              ),
              saleItemWidget(context, imageConstants.mdiTireIcon, count,
                  isWeight: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget saleItemWidget(BuildContext context, String image, String count,
      {bool? isWeight}) {
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
          isWeight == true ? count : "$count MT",
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: appColor.black40),
        ),
      ],
    );
  }
}
