import 'package:cpcb_tyre/models/response/filter/checkbox_filter_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonFilterViewHeading extends StatelessWidget {
  final CheckboxFilterModel checkboxFilterModel;
  final Function(bool?) updateState;
  final bool isBorder;

  const CommonFilterViewHeading(
      {super.key,
      required this.checkboxFilterModel,
      required this.updateState,
      this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              isBorder == true ? Border.all(color: AppColor().black20) : null),
      padding: isBorder == true
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: checkboxFilterModel.isChecked,
                tristate: checkboxFilterModel.isChecked == null ? true : false,
                activeColor: AppColor().green,
                onChanged: updateState,
              ),
              CommonTextWidget(
                checkboxFilterModel.title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColor().black01),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
