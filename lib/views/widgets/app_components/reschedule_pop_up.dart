import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../constants/string_constant.dart';
import '../../../theme/app_color.dart';
import '../components/common_button_widget.dart';
import '../components/common_text_form_field_widget.dart';
import '../components/common_text_widget.dart';

class ReschedulePopUp extends StatelessWidget {
  const ReschedulePopUp({
    super.key,
    required this.startDate,
    required this.endDate,
    this.onSubmit,
    required this.previousEndDate,
    required this.previousStartDate,
  });
  final TextEditingController startDate;
  final TextEditingController endDate;
  final TextEditingController previousStartDate;
  final TextEditingController previousEndDate;
  final VoidCallback? onSubmit;
  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    final appColor = AppColor();
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: appColor.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
            color: appColor.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: appColor.black10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextWidget(
              stringConstants.reschedule,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 24,
            ),
            CommonTextFormFieldWidget(
              hintText: stringConstants.previouslySelectedStartDate,
              isMandatory: true,
              controller: previousStartDate,
              icon: ImageConstants().calendarToday,
              iconColor: appColor.black70,
              isReadOnly: true,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextFormFieldWidget(
              hintText: stringConstants.previouslySelectedEndDate,
              isMandatory: true,
              controller: previousEndDate,
              icon: ImageConstants().calendarToday,
              iconColor: appColor.black70,
              isReadOnly: true,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextFormFieldWidget(
              hintText: stringConstants.startDate,
              isMandatory: true,
              controller: endDate,
              icon: ImageConstants().calendarToday,
              onSuffixTap: () {
                showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.utc(2050));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextFormFieldWidget(
              hintText: stringConstants.endDate,
              isMandatory: true,
              controller: endDate,
              icon: ImageConstants().calendarToday,
              disabledBgColor: appColor.black50,
              onSuffixTap: () {
                showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.utc(2050));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: CommonButtonWidget(
                      label: stringConstants.close,
                      color: appColor.white,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: appColor.darkGreen),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 2,
                    child: CommonButtonWidget(
                      label: stringConstants.submitBtnLabel,
                      color: appColor.darkGreen,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: appColor.white),
                      onPressed: onSubmit,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
