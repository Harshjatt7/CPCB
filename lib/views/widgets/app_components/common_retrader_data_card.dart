import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../constants/string_constant.dart';

class CommonRetraderDataCard extends StatelessWidget {
  CommonRetraderDataCard(
      {super.key,
      required this.name,
      this.contactDetails,
      this.address,
      this.invoiceNumber,
      this.gstNumber,
      this.typeOfRaw,
      this.total,
      this.date,
      this.year,
      this.isRetraderContainer = false});
  final String name;
  final String? contactDetails;
  final String? address;
  final String? invoiceNumber;
  final String? gstNumber;
  final String? typeOfRaw;
  final String? total;
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
              "${stringConstants.contactDetailLabel.i18n()} ${contactDetails ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.addressOfBuyerLabel.i18n()} ${address ?? ''}"),
          if (isRetraderContainer == false)
            retraderDetailsCard(context,
                "${stringConstants.invoiceNumberLabel.i18n()} ${invoiceNumber ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.gstNumberLabel.i18n()} ${gstNumber ?? ''}"),
          retraderDetailsCard(context,
              "${stringConstants.typeOfRawMaterialLabel.i18n()} ${typeOfRaw ?? ''}"),
          Divider(
            color: appColor.black10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonImageWidget(
                    imageSource: imageConstants.verified,
                    isNetworkImage: false,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  retraderDetailsCard(context, total ?? "")
                ],
              ),
          
              Row(
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
              Row(
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
