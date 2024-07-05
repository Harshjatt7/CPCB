import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import '../../../constants/string_constant.dart';
import '../components/common_button_widget.dart';
import '../components/common_text_widget.dart';
import 'common_progress_bar.dart';
import 'common_type_badge.dart';

class AuditorBottomSheet extends StatelessWidget {
  AuditorBottomSheet(
      {super.key,
      this.status,
      this.unitName,
      this.unitGstin,
      this.unitRegisteration,
      this.unitType,
      this.unitAddress,
      this.district,
      this.state,
      this.currentStatus,
      this.createdOn,
      this.endDate,
      this.startDate,
      this.progress,
      this.onPressed});
  final appColor = AppColor();
  final String? status;
  final String? unitName;
  final String? unitGstin;
  final String? unitRegisteration;
  final String? unitType;
  final String? unitAddress;
  final String? district;
  final String? state;
  final String? currentStatus;
  final String? createdOn;
  final String? startDate;
  final String? endDate;
  final double? progress;
  final VoidCallback? onPressed;
  final stringConstants = StringConstants();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: CommonSingleChildScrollView(
        child: Container(
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
                  stringConstants.viewDetail,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CommonProgressBar(
                percentage: progress ?? 0,
              ),
              const SizedBox(
                height: 30,
              ),
              detailCard(context,
                  firstLabel: stringConstants.unitName,
                  secondLabel: stringConstants.unitRegisteration,
                  thirdLabel: stringConstants.unitGstin,
                  fourthLabel: stringConstants.unitType,
                  firstValue: unitName,
                  secondValue: unitGstin,
                  thirdValue: unitRegisteration,
                  fourthValue: unitType,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: appColor.black)),
              buildDivider(),
              buildMiddleCard(context),
              buildDivider(),
              detailCard(
                context,
                isTypeBadge: true,
                firstLabel: stringConstants.currentStatus,
                secondLabel: stringConstants.auditorStartDate,
                thirdLabel: stringConstants.createdOn,
                fourthLabel: stringConstants.auditorEndDate,
                firstValue: currentStatus,
                secondValue: createdOn,
                thirdValue: startDate,
                fourthValue: endDate,
              ),
              buildDivider(),
              CommonButtonWidget(
                label: status ?? "",
                color: appColor.darkGreen,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
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
              child: addUnitData(context,
                  label: stringConstants.unitAddress, data: unitAddress ?? ""),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: addUnitData(context,
                  label: stringConstants.district, data: district),
            ),
            Expanded(
                flex: 3,
                child: addUnitData(context,
                    label: stringConstants.state, data: state)),
          ],
        )
      ],
    );
  }

  Widget detailCard(BuildContext context,
      {bool? isTypeBadge,
      bool? isUnitAddress,
      String? firstLabel,
      String? secondLabel,
      String? thirdLabel,
      String? fourthLabel,
      String? firstValue,
      String? secondValue,
      String? thirdValue,
      String? fourthValue,
      TextStyle? labelStyle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addUnitData(context,
                  label: firstLabel,
                  data: firstValue,
                  isTypeBadge: isTypeBadge,
                  labelStyle: labelStyle),
              const SizedBox(
                height: 16,
              ),
              addUnitData(context, label: secondLabel, data: secondValue),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addUnitData(context, label: thirdLabel, data: thirdValue),
              SizedBox(
                height: isTypeBadge == true ? 28 : 16,
              ),
              addUnitData(context, label: fourthLabel, data: fourthValue),
            ],
          ),
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
            ? CommonTypeBadge(
                text: data ?? "",
                textStyle: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: appColor.black70))
            : CommonTextWidget(
                data ?? "-",
                useLocalization: false,
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
