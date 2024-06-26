import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../theme/app_color.dart';
import '../../../utils/helper/responsive_helper.dart';
import '../components/common_image_widget.dart';
import '../components/common_text_widget.dart';

class DashboardYearFilter extends StatelessWidget {
  const DashboardYearFilter({
    super.key,
    this.value,
    this.title,
    this.onChanged,
    this.items,
    this.newValue,
  });
  final String? value;
  final String? title;
  final String? newValue;
  final void Function(Object?)? onChanged;
  final List? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive().screenWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border(bottom: BorderSide(color: AppColor().black10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonTextWidget(
            title??"",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor().grey03)),
            child: DropdownButton(
              icon: CommonImageWidget(
                imageSource: ImageConstants().dropdownIcon,
                isNetworkImage: false,
                width: 6,
                height: 7,
              ),
              hint: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CommonTextWidget(
                  value ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColor().black70),
                ),
              ),
              isDense: true,
              padding: const EdgeInsets.all(0),
              iconSize: 0,
              value: newValue,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor().black70),
              onChanged: onChanged,
              
              items: items?.map((label) => DropdownMenuItem(
                        value: label,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CommonTextWidget(label,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColor().black70))),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
