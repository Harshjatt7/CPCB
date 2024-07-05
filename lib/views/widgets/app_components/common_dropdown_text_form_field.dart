import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonDropdownTextFormField extends StatelessWidget {
  final List dropDownItem;
  final String labelText;
  final void Function(Object?)? onChanged;
  final void Function()? onTap;
  final String? value;
  final String? error;
  final bool? isMandatory;
  final Color? bgColor;
  final AppColor appColor = AppColor();
  CommonDropdownTextFormField(
      {super.key,
      required this.labelText,
      required this.dropDownItem,
      required this.onChanged,
      this.onTap,
      this.value,
      this.bgColor,
      this.error,
      this.isMandatory = false});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            color: bgColor ?? appColor.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: error == null ? appColor.grey03 : appColor.red,
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              DropdownButtonFormField(
                isExpanded: true,
                onTap: onTap,
                value: value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  label: RichText(
                    text: TextSpan(
                      text: labelText.i18n(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: appColor.grey01),
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 17),
                    child: CommonImageWidget(
                      imageSource: ImageConstants().dropdownIcon,
                      isNetworkImage: false,
                    ),
                  ),
                ),
                icon: const SizedBox.shrink(),
                items: dropDownItem
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 2,
                            ),
                            child: CommonTextWidget(
                              label.toString(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
      if (error != null)
        Align(
          alignment: Alignment.topLeft,
          child: CommonTextWidget(
            error.toString(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: appColor.red),
          ),
        ),
    ]);
  }
}
