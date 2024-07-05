import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_5_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:flutter/material.dart';

class AuditorRecyclerForm5 extends StatelessWidget {
  const AuditorRecyclerForm5({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm5ViewModel>(
        onModelReady: (value) {},
        viewModel: RecyclerForm5ViewModel(),
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonMandatoryTitle(
                    title: "Whether ETP is installed & operational"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: CommonDropdownTextFormField(
                    labelText: "Select",
                    dropDownItem: const [],
                    onChanged: null),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CommonTextFormFieldWidget(
                    hintText: "Remarks",
                    isMandatory: false,
                    controller: TextEditingController()),
              ),
              formRadioButton(groupValue: "confirmed"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonMandatoryTitle(title: "ETP Capacity (KLD)"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: CommonTextFormFieldWidget(
                    hintText: "Enter",
                    isMandatory: false,
                    controller: TextEditingController()),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: CommonTextFormFieldWidget(
                    hintText: "Remarks",
                    isMandatory: false,
                    controller: TextEditingController()),
              ),
              formRadioButton(groupValue: "confirmed"),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CommonTitleWidget(
                    label: "Summary of Audit (Max 500 words)"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonMandatoryTitle(
                  title: "Summary of Audit",
                  isMandatory: true,
                ),
              ),
              //TODO
            ],
          );
        });
  }

  CommonRadioButton formRadioButton({String? groupValue}) {
    return CommonRadioButton(
      groupValue: groupValue ?? '',
      value1: 'not confirmed',
      value2: 'confirmed',
      label1: "Not Confirmed",
      label2: "Confirmed",
      onChanged: (value) {
        groupValue = value ?? '';
      },
    );
  }
}
