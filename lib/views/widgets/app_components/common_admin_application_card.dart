import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_type_badge.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonAdminApplicationCard extends StatelessWidget {
  CommonAdminApplicationCard({
    super.key,
    this.applicationStatus,
    this.applicationNumber,
    this.applicationTitle,
    this.lastMarked,
    this.markedTo,
    this.date,
    this.year,
    this.onMenuTap,
  });
  final String? applicationStatus;
  final String? applicationNumber;
  final String? applicationTitle;
  final String? lastMarked;
  final String? markedTo;
  final String? date;
  final String? year;
  final Function()? onMenuTap;
  final ImageConstants imageConstants = ImageConstants();
  final StringConstants stringConstants = StringConstants();
  final AppColor appColor = AppColor();

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
                  Flexible(
                    child: Row(
                      children: [
                        CommonTypeBadge(
                          text: applicationStatus ?? "",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: CommonTextWidget(
                            applicationNumber ?? "",
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: appColor.black40),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onMenuTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: CommonImageWidget(
                          imageSource: imageConstants.menuIcon,
                          isNetworkImage: false),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CommonTextWidget(applicationTitle ?? ""),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${stringConstants.lastMarked.i18n()}: $lastMarked"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${stringConstants.markedTo.i18n()}: $markedTo"),
              Divider(
                thickness: 1,
                color: appColor.black10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildRowWidget(context,
                      image: imageConstants.calendarIcon,
                      text: "${stringConstants.dateLabel.i18n()} $date"),
                  buildRowWidget(context,
                      image: imageConstants.calendarIcon, text: year),
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

  Row buildRowWidget(BuildContext context, {String? text, String? image}) {
    return Row(
      children: [
        CommonImageWidget(imageSource: image ?? "", isNetworkImage: false),
        const SizedBox(
          width: 4,
        ),
        CommonTextWidget(
          text ?? "",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: appColor.black40),
        )
      ],
    );
  }
}
