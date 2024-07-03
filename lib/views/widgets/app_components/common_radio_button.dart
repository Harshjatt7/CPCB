import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonRadioButton extends StatelessWidget {
  final String groupValue;
  final String value1;
  final String value2;
  final String label1;
  final String label2;
  final String? title;
  final bool isMandatory;
  final void Function(String?)? onChanged;

  final AppColor appColor = AppColor();

  CommonRadioButton(
      {super.key,
      required this.groupValue,
      required this.value1,
      required this.value2,
      required this.label1,
      required this.label2,
      this.title,
      this.isMandatory = false,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: RichText(
              text: TextSpan(
                text: title,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: appColor.black30),
                children: [
                  TextSpan(
                    text: isMandatory == true ? " *" : "",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: appColor.red),
                  ),
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            children: [
              Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: value1,
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColor().darkGreen;
                      }
                      return AppColor().black40;
                    },
                  ),
                  groupValue: groupValue,
                  onChanged: onChanged),
              CommonTextWidget(
                label1,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 40,
              ),
              Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: value2,
                groupValue: groupValue,
                fillColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppColor().darkGreen;
                    }
                    return AppColor().black40;
                  },
                ),
                onChanged: onChanged,
              ),
              CommonTextWidget(
                label2,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}
