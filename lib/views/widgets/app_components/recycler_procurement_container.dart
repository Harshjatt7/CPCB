import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../constants/string_constant.dart';

class RecyclerProcurementDetailsContainer extends StatelessWidget {
  RecyclerProcurementDetailsContainer(
      {super.key,
      required this.name,
      this.invoiceNumber,
      this.quantityReceived,
      this.typeOfRaw,
      this.date,
      this.year,
      this.tyreSource});
  final String name;
  final String? invoiceNumber;
  final String? typeOfRaw;
  final String? quantityReceived;
  final String? date;
  final String? year;
  final String? tyreSource;
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
              "${stringConstants.invoiceNumberLabel.i18n()} ${invoiceNumber ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.typeOfRawMaterialLabel.i18n()} ${typeOfRaw ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.quantityReceived.i18n()}: ${quantityReceived ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.tyreSourceLabel.i18n()}: ${tyreSource ?? ''}"),
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
                        '${stringConstants.date.i18n()}: ${HelperFunctions().getFormattedDate(dtstr: date ?? "")}'),
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
