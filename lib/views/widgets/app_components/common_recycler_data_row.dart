import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonRecyclerDataRow extends StatelessWidget {
  CommonRecyclerDataRow(
      {super.key, required this.demoModel, this.onTap, required this.isOdd});
  final DemoModel2 demoModel;
  final void Function()? onTap;
  final bool isOdd;
  String groupValue = "confirmed";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isOdd == true ? AppColor().white : AppColor().grey15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 70,top: 14,bottom: 14),
              child: CommonTextWidget(
                demoModel.name ?? '',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: GestureDetector(
                onTap: onTap,
                child: CommonTextWidget(
                  demoModel.capacity ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColor().black02,
                      ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 310,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CommonTextWidget(
                demoModel.power ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor().black02),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: "not confirmed",
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColor().darkGreen;
                      }
                      return AppColor().black40;
                    },
                  ),
                  groupValue: groupValue,
                  onChanged: (value) {
                    groupValue = value ?? '';
                  },
                ),
                CommonTextWidget(
                  "Not Confirmed",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 40,
                ),
                Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: "confirmed",
                  groupValue: groupValue,
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColor().darkGreen;
                      }
                      return AppColor().black40;
                    },
                  ),
                  onChanged: (value) {
                    groupValue = value ?? '';
                  },
                ),
                CommonTextWidget(
                  "Confirmed",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 30
              ),
              child: CommonTextFormFieldWidget(
                  hintText: "Remarks",
                  isMandatory: false,
                  controller: TextEditingController()),
            ),
          )
        ],
      ),
    );
  }
}

class DemoModel2 {
  String? name;
  String? capacity;
  String? power;
  String? action;
  String? remarks;

  DemoModel2({
    this.name,
    this.capacity,
    this.power,
    this.action,
    this.remarks,
  });
}

List<DemoModel2> list2 = [
  DemoModel2(
      name: "one",
      capacity: "21",
      power: "42",
      action: "confirm",
      remarks: "anything"),
  DemoModel2(
      name: "two",
      capacity: "21",
      power: "42",
      action: "confirm",
      remarks: "anything"),
  DemoModel2(
      name: "three",
      capacity: "21",
      power: "42",
      action: "confirm",
      remarks: "anything"),
];
