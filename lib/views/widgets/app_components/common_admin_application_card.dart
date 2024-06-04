import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_type_badge.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonAdminApplicationCard extends StatelessWidget {
  const CommonAdminApplicationCard({
    super.key,
    this.applicationName,
    this.applicationNumber,
    this.applicationTitle,
    this.lastMarked,
    this.markedTo,
    this.total,
    this.date,
    this.year,
    this.onMenuTap,
  });
  final String? applicationName;
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
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
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
                          text: applicationName ?? "",
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
                CommonTextWidget(applicationTitle ?? ""),
                const SizedBox(
                  height: 6,
                ),
                buildCustomTextWidget(context,
                    text:
                        "${StringConstants().lastMarked.i18n()}: $lastMarked"),
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
                        text: "${StringConstants().dateLabel.i18n()}: $date"),
                    buildRowWidget(context,
                        image: ImageConstants().calendarIcon, text: year),
                  ],
                ),
              ],
            ),
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
