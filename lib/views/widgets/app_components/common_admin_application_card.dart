import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_type_badge.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

class CommonAdminApplicationCard extends StatelessWidget {
  const CommonAdminApplicationCard({
    super.key,
    this.applicationStatus,
    this.applicationNumber,
    this.applicationTitle,
    this.lastMarked,
    this.markedTo,
    this.total,
    this.date,
    this.year,
    this.onMenuTap,
  });
  final String? applicationStatus;
  final String? applicationNumber;
  final String? applicationTitle;
  final String? lastMarked;
  final String? markedTo;
  final String? total;
  final String? date;
  final String? year;
  final Function()? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor().black10),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CommonTypeBadge(
                        text: applicationStatus ?? "",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CommonTextWidget(
                        applicationNumber ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColor().black40),
                      ),
                    ],
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onMenuTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
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
              CommonTextWidget(applicationTitle ?? ""),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${StringConstants().lastMarked.i18n()}: $lastMarked"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${StringConstants().markedTo.i18n()}: $markedTo"),
              Divider(
                thickness: 1,
                color: AppColor().black10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildRowWidget(context,
                      image: ImageConstants().verified, text: total),
                  buildRowWidget(context,
                      image: ImageConstants().calendarIcon,
                      text: "${StringConstants().dateLabel.i18n()} $date"),
                  buildRowWidget(context,
                      image: ImageConstants().calendarIcon, text: year),
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
            ?.copyWith(color: AppColor().black40));
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
              ?.copyWith(color: AppColor().black40),
        )
      ],
    );
  }
}
