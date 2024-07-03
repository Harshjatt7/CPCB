import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_progress_bar.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_type_badge.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AuditListCard extends StatelessWidget {
  AuditListCard({
    super.key,
    this.status,
    this.userType,
    this.unitName,
    this.district,
    this.date,
    this.progress,
    this.year,
    this.onTap,
  });
  final String? userType;
  final String? status;
  final String? unitName;
  final String? district;
  final String? year;
  final double? progress;
  final String? date;
  final VoidCallback? onTap;
  final stringConstants = StringConstants();
  final appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: appColor.black10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonTypeBadge(text: status ?? ""),
                  const SizedBox(
                    width: 10,
                  ),
                  CommonTypeBadge(text: userType ?? ""),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: CommonImageWidget(
                  imageSource: ImageConstants().viewEyes,
                  isNetworkImage: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CommonTextWidget(
            unitName ?? "",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          buildUnitDetail(context,
              label: "${stringConstants.district.i18n()}: ", value: district),
          const SizedBox(
            height: 4,
          ),
          buildUnitDetail(context,
              label: "${stringConstants.quarterFinalYear.i18n()}: ",
              value: year),
          const SizedBox(
            height: 10,
          ),
          CommonProgressBar(
            percentage: progress ?? 0,
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            color: appColor.black10,
          ),
          buildUnitDetail(context,
              label: "${stringConstants.date.i18n()}: ",
              value: date,
              valueStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: appColor.black40)),
        ],
      ),
    );
  }

  RichText buildUnitDetail(BuildContext context,
      {String? label, String? value, TextStyle? valueStyle}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: appColor.black40),
        children: [
          TextSpan(
            text: value,
            style: valueStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: appColor.black70),
          ),
        ],
      ),
    );
  }
}
