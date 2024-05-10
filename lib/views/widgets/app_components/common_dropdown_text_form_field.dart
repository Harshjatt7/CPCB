import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonDropdownTextFormField extends StatelessWidget {
  final List dropDownItem;
  final String labelText;
  final void Function(Object?)? onChanged;
  final String? value;
  const CommonDropdownTextFormField(
      {super.key,
      required this.labelText,
      required this.dropDownItem,
      required this.onChanged,
      this.value
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor().greyD3D3D3,
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          children: [
            DropdownButtonFormField(
              
              value: value,
              validator: (value) {
                if(value==null){
                  return "Please select data";
                }else{
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                label: RichText(
                  text: TextSpan(
                    text: labelText,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColor().grey919191),
                    children: [
                      TextSpan(
                        text: " *",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppColor().redFF3333),
                      ),
                    ],
                  ),
                ),
                
                suffixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
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
    );
  }
}
