import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class RecyclerDetailsContainer extends StatelessWidget {
  RecyclerDetailsContainer(
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
  final ImageConstants imageConstants = ImageConstants();
  final StringConstants stringConstants = StringConstants();
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
          CommonTextWidget(name,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: appColor.black)),
          const SizedBox(
            height: 6,
          ),
          retraderDetailsCard(context,
              "${stringConstants.qtyProcessedLabel.i18n()} ${qtyProcessed ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.qtyProducedLabel.i18n()} ${qtyProduced ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.qtyWasteLabel.i18n()} ${wasteQty ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.typeOfRawMaterialLabel.i18n()} ${typeOfRaw ?? ''}"),
          Divider(
            color: appColor.black10,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    CommonImageWidget(
                      imageSource: imageConstants.calendarIcon,
                      isNetworkImage: false,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    retraderDetailsCard(context,
                        '${stringConstants.dateLabel.i18n()} ${HelperFunctions().getFormattedDate(dtstr: date ?? "")}'),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    CommonImageWidget(
                      imageSource: imageConstants.calendarIcon,
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

  Widget retraderDetailsCard(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: CommonTextWidget(text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: appColor.black40)),
    );
  }
}
