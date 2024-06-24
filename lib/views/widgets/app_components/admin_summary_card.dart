import 'package:cpcb_tyre/views/widgets/app_components/common_type_badge.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../constants/string_constant.dart';
import '../../../theme/app_color.dart';
import '../components/common_text_widget.dart';

class AdminSummaryCard extends StatelessWidget {
  const AdminSummaryCard({
    super.key,
    this.userType,
    this.label,
    this.eprObligations,
    this.creditsGenerated,
    this.creditsTransferred,
  });
  final String? userType;
  final String? label;
  final String? eprObligations;
  final String? creditsGenerated;
  final String? creditsTransferred;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor().black10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTypeBadge(isAdmin: true, text: label.toString().i18n()),
          const SizedBox(
            height: 12,
          ),
          if (userType == StringConstants.producer)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  StringConstants().eprObligations,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                CommonTextWidget(
                  eprObligations ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          if (userType == StringConstants.retreader ||
              userType == StringConstants.recycler)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  StringConstants().creditsGenerated,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                CommonTextWidget(
                  creditsGenerated ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          const SizedBox(
            height: 16,
          ),
          if (userType == StringConstants.retreader ||
              userType == StringConstants.recycler)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  StringConstants().creditsTransferred,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                CommonTextWidget(
                  creditsTransferred ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            )
        ],
      ),
    );
  }
}
