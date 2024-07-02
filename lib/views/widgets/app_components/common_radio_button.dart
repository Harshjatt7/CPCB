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
  final void Function(String?)? onChanged1;
  final void Function(String?)? onChanged2;

  const CommonRadioButton(
      {super.key,
      required this.groupValue,
      required this.value1,
      required this.value2,
      required this.label1,
      required this.label2,
      this.title,
      required this.onChanged1,
      required this.onChanged2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          title ?? '',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: RadioListTile(
                  title: CommonTextWidget(
                    label1,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
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
                  onChanged: onChanged1),
            ),
            Flexible(
              child: RadioListTile(
                title: CommonTextWidget(
                  label2,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
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
                onChanged: onChanged2,
              ),
            )
          ],
        )
      ],
    );
  }
}
