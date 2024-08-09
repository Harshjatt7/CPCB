import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form1_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonRecyclerDataRow extends StatefulWidget {
  CommonRecyclerDataRow(
      {super.key,
      required this.nwModel,
      this.onTap,
      required this.isOdd,
      required this.machineController,
      required this.index,
      this.isSummary = false,
      this.validator,
      this.remarkError,
      required this.groupValue});
  final Nw? nwModel;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool isOdd;
  final int index;
  final String? remarkError;
  final TextEditingController machineController;
  String groupValue;
  final bool? isSummary;

  @override
  State<CommonRecyclerDataRow> createState() => _CommonRecyclerDataRowState();
}

class _CommonRecyclerDataRowState extends State<CommonRecyclerDataRow> {
  final StringConstants stringConstants = StringConstants();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.isOdd == true ? AppColor().white : AppColor().grey15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 70, top: 14, bottom: 14),
              child: CommonTextWidget(
                widget.nwModel?.machineryInstalled ?? '',
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
                onTap: widget.onTap,
                child: CommonTextWidget(
                  widget.nwModel?.capacity ?? '',
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
                widget.nwModel?.power ?? '',
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
                  value: stringConstants.radioValue1,
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColor().darkGreen;
                      }
                      return AppColor().black40;
                    },
                  ),
                  groupValue: widget.groupValue,
                  onChanged: (value) {
                    if (widget.isSummary == false) {
                      widget.groupValue = value ?? '';
                      setState(() {});
                    }
                  },
                ),
                CommonTextWidget(
                  stringConstants.notConfirmed,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 40,
                ),
                Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: stringConstants.radioValue2,
                  groupValue: widget.groupValue,
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColor().darkGreen;
                      }
                      return AppColor().black40;
                    },
                  ),
                  onChanged: (value) {
                    if (widget.isSummary == false) {
                      widget.groupValue = value ?? '';
                      setState(() {});
                    }
                  },
                ),
                CommonTextWidget(
                  stringConstants.confirmed,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  child: CommonTextFormFieldWidget(
                      hintText: stringConstants.remarks,
                      isReadOnly: widget.isSummary,
                      isMandatory: false,
                      validator: widget.validator,
                      controller: widget.machineController),
                ),
                if (widget.remarkError?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: showErrorMessage(context, widget.remarkError ?? ''),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget showErrorMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        child: CommonTextWidget(
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColor().red),
        ),
      ),
    );
  }
}
