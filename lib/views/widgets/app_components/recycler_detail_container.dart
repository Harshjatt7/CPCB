import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecyclerDetailsContainer extends StatelessWidget {
  const RecyclerDetailsContainer(
      {super.key,
      required this.name,
      this.contactDetails,
      this.address,
      this.gstNumber,
      this.qtyProcessed,
      this.qtyProduced,
      this.wasteQty,
      this.typeOfRaw,
      this.date,
      this.year,
      this.isRetraderContainer = false});
  final String name;
  final String? contactDetails;
  final String? address;

  final String? gstNumber;
  final String? typeOfRaw;
  final String? qtyProcessed;
  final String? qtyProduced;
  final String? wasteQty;
  final String? date;
  final String? year;
  final bool? isRetraderContainer;
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
          retraderDetailsCard(
              context, "Quantity processed (in tonnes): ${qtyProcessed ?? ''}"),
          retraderDetailsCard(
              context, "Quantity produced (in tonnes): ${qtyProduced ?? ''}"),
          retraderDetailsCard(context,
              "Quantity of waste generated (in tonnes): ${wasteQty ?? ''}"),
          retraderDetailsCard(
              context, "Type of raw material: ${typeOfRaw ?? ''}"),
          Divider(
            color: AppColor().black10,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    CommonImageWidget(
                      imageSource: ImageConstants().calendarIcon,
                      isNetworkImage: false,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    retraderDetailsCard(context,
                        'Date: ${HelperFunctions().getFormattedDate(dtstr: date ?? "")}'),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
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
                ),
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
