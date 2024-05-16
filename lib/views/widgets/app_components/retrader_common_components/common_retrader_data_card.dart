import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonRetraderDataCard extends StatelessWidget {
  const CommonRetraderDataCard({
    super.key,
    required this.name,
    this.contactDetails,
    this.address,
    this.invoiceNumber,
    this.gstNumber,
    this.typeOfRaw,
    this.total,
    this.date,
    this.year,
  });
  final String name;
  final String? contactDetails;
  final String? address;
  final String? invoiceNumber;
  final String? gstNumber;
  final String? typeOfRaw;
  final String? total;
  final String? date;
  final String? year;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor().black10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(name,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: AppColor().black)),
          const SizedBox(
            height: 6,
          ),
          retraderDetailsCard(
              context, "Contact details: ${contactDetails ?? ''}"),
          retraderDetailsCard(context, "Address of buyer: ${address ?? ''}"),
          retraderDetailsCard(
              context, "Invoice number: ${invoiceNumber ?? ''}"),
          retraderDetailsCard(context, "GST number: ${gstNumber ?? ''}"),
          retraderDetailsCard(
              context, "Type of raw material: ${typeOfRaw ?? ''}"),
          Divider(
            color: AppColor().black10,
          ),
          Row(
            children: [
              Row(
                children: [
                  CommonImageWidget(
                    imageSource: ImageConstants().verified,
                    isNetworkImage: false,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  retraderDetailsCard(context, total ?? "")
                ],
              ),
              const SizedBox(width: 32),
              Row(
                children: [
                  CommonImageWidget(
                    imageSource: ImageConstants().calendarIcon,
                    isNetworkImage: false,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  retraderDetailsCard(context, date ?? ""),
                ],
              ),
              const SizedBox(width: 32),
              Row(
                children: [
                  CommonImageWidget(
                    imageSource: ImageConstants().calendarIcon,
                    isNetworkImage: false,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  retraderDetailsCard(context, year ?? ""),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget retraderDetailsCard(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: CommonTextWidget(text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColor().black40)),
  );
}
