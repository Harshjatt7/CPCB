import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';
import '../components/common_button_widget.dart';
import '../components/common_text_widget.dart';
import 'common_type_badge.dart';

class AuditorBottomSheet extends StatelessWidget {
  AuditorBottomSheet({
    super.key,
  });
  final appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: appColor.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: appColor.black20),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CommonTextWidget(
              "View Detail",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 15,
            child: Row(
              children: [
                CommonTextWidget(
                  '${(0.4 * 100).toInt()}%',
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: Stack(
                    children: [
                      Container(
                        height: 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: appColor.black10),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.4, //progress number
                        child: Container(
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: appColor.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          detailCard(context,
              labelStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: appColor.black)),
          buildDivider(),
          buildMiddleCard(context),
          buildDivider(),
          detailCard(context, isTypeBadge: true),
          buildDivider(),
          CommonButtonWidget(
            label: "Acknowledge",
            color: appColor.darkGreen,
          ),
        ],
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(
        color: appColor.black10,
      ),
    );
  }

  Column buildMiddleCard(BuildContext context,
      {bool? isTypeBadge, bool? isUnitAddress, TextStyle? labelStyle}) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: addUnitData(
                context,
                label: "Unit Address",
                data:
                    "12/D Ayurveda Nagar, Opp Ansal Plaza, South Delhi, New Delhi-110049",
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addUnitData(context, label: "Unit GSTIN", data: "FHR5478D"),
            const SizedBox(
              width: 80,
            ),
            addUnitData(context, label: "Unit Type", data: "Producer"),
          ],
        )
      ],
    );
  }

  Row detailCard(BuildContext context,
      {bool? isTypeBadge, bool? isUnitAddress, TextStyle? labelStyle}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addUnitData(context,
                label: "Unit Address",
                data: "ABC-XYZ Unit",
                isTypeBadge: isTypeBadge,
                labelStyle: labelStyle),
            const SizedBox(
              height: 16,
            ),
            addUnitData(context,
                label: "Unit Registration No.", data: "FHR5478D"),
          ],
        ),
        const SizedBox(
          width: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addUnitData(context, label: "Unit GSTIN", data: "FHR5478D"),
            const SizedBox(
              height: 16,
            ),
            addUnitData(context, label: "Unit Type", data: null),
          ],
        )
      ],
    );
  }

  Column addUnitData(BuildContext context,
      {String? label, String? data, bool? isTypeBadge, TextStyle? labelStyle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          label ?? "",
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: appColor.black50),
        ),
        const SizedBox(
          height: 4,
        ),
        isTypeBadge == true
            ? CommonTypeBadge(text: data ?? "")
            : CommonTextWidget(
                data ?? "-",
                style: labelStyle ??
                    Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: appColor.black70),
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }
}
