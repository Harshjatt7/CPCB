import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

import '../components/common_button_widget.dart';

class AcknowledgePopUp extends StatelessWidget {
  const AcknowledgePopUp(
      {super.key,
      required this.startDate,
      required this.endDate,
      this.onSubmit});
  final TextEditingController startDate;
  final TextEditingController endDate;
  final VoidCallback? onSubmit;
  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    final appColor = AppColor();
    return Container(
      decoration: BoxDecoration(
          color: appColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.5, color: appColor.black10)),
      child: Column(
        children: [
          const CommonTextWidget("Acknowledge"),
          CommonTextFormFieldWidget(
            hintText: "Start Date",
            isMandatory: true,
            controller: startDate,
            icon: ImageConstants().calendarToday,
          ),
          CommonTextFormFieldWidget(
            hintText: "End Date",
            isMandatory: true,
            controller: endDate,
            icon: ImageConstants().calendarToday,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Flexible(flex: 3, child: SizedBox()),
                Flexible(
                  flex: 2,
                  child: CommonButtonWidget(
                    label: stringConstants.cancel,
                    color: appColor.white,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
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
    );
  }
}
