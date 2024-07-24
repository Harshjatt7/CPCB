import 'package:flutter/material.dart';

import '../../../constants/string_constant.dart';
import '../../../theme/app_color.dart';
import '../components/common_button_widget.dart';

class StepperButton extends StatelessWidget {
  final bool? isLastStep;
  final bool? isSummaryScreen;
  final VoidCallback? onNextOrSubmit;
  final VoidCallback? onSavedDraft;

  const StepperButton(
      {super.key,
      this.isLastStep,
      this.isSummaryScreen,
      this.onNextOrSubmit,
      this.onSavedDraft});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor().white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSummaryScreen == false)
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 18, bottom: 18, left: 16, right: 8),
                child: CommonButtonWidget(
                  onPressed: onSavedDraft,
                  label: StringConstants().savedAsDraft,
                  borderColor: AppColor().darkGreen,
                  color: AppColor().white,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColor().darkGreen),
                ),
              ),
            ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18, bottom: 18, left: 8, right: 16),
              child: CommonButtonWidget(
                label: isLastStep == true
                    ? StringConstants().submitBtnLabel
                    : StringConstants().next,
                color: isLastStep == true && isSummaryScreen == true
                    ? AppColor().black10
                    : AppColor().darkGreen,
                borderColor: isLastStep == true && isSummaryScreen == true
                    ? AppColor().black10
                    : AppColor().darkGreen,
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColor().white),
                onPressed: (isLastStep == true || isSummaryScreen == true)
                    ? null
                    : onNextOrSubmit,
              ),
            ),
          )
        ],
      ),
    );
  }
}
