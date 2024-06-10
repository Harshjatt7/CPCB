import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonSpcbCard extends StatelessWidget {
   CommonSpcbCard({
    super.key,
    this.companyName,
    this.address,
    this.date,
    this.state,
    this.onMenuTap,
    this.applicationNumber,
  });
  final String? companyName;
  final String? address;
  final String? date;
  final String? state;
  final Function()? onMenuTap;
  final String? applicationNumber;
  final AppColor appColor=AppColor();
  final StringConstants stringConstants=StringConstants();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: appColor.black10),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget(
                    applicationNumber ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: appColor.black40),
                  ),
                  GestureDetector(
                    onTap: onMenuTap,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: CommonImageWidget(
                          imageSource: ImageConstants().menuIcon,
                          isNetworkImage: false),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CommonTextWidget(
                companyName ?? "",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: appColor.black),
              ),
              const SizedBox(
                height: 10,
              ),
              buildCustomTextWidget(context,
                  text: "${stringConstants.address.i18n()}: $address"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${stringConstants.state.i18n()}: $state"),
              Divider(
                color: appColor.black10,
              ),
              Row(
                children: [
                  CommonImageWidget(
                      imageSource: ImageConstants().calendarIcon,
                      isNetworkImage: false),
                  const SizedBox(
                    width: 4,
                  ),
                  CommonTextWidget(
                    "${stringConstants.date.i18n()}: $date",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: appColor.black40),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  CommonTextWidget buildCustomTextWidget(BuildContext context, {String? text}) {
    return CommonTextWidget(text ?? "",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: appColor.black40));
  }
}
