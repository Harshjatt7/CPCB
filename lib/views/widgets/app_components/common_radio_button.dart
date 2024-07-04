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
  final TextStyle? titleStyle;
  final bool isMandatory;
  final void Function(String?)? onChanged;
  final EdgeInsets? padding;

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
      required this.onChanged,
      this.titleStyle,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: titleStyle ??
                Theme.of(context)
                    .textTheme
                    .displaySmall
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
        if (title != null)
          Padding(
            padding: padding ?? const EdgeInsets.only(bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                      const SizedBox(width: 4),
                      CommonTextWidget(
                        label1,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
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
                      const SizedBox(
                        width: 4,
                      ),
                      CommonTextWidget(
                        label2,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
