import 'package:cpcb_tyre/viewmodels/auditor/producer_form/producer_form_3._view_model.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_components/common_multiline_text_form_field.dart';

class ProducerForm3 extends StatelessWidget {
  const ProducerForm3({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (viewModel) {},
      viewModel: ProducerForm3ViewModel(),
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRadioButton(
                context,
                viewModel: viewModel,
              ),
              CommonTextFormFieldWidget(
                  hintText: viewModel.stringConstants.deviation,
                  isMandatory: false,
                  controller: viewModel.deviationController),
              const SizedBox(
                height: 24,
              ),
              CommonRadioButton(
                  title: viewModel.stringConstants.information,
                  titleStyle: Theme.of(context).textTheme.labelSmall,
                  groupValue: viewModel.groupValue,
                  value1: "yes",
                  value2: "no",
                  label1: "Yes",
                  label2: "No",
                  onChanged: (value) {
                    viewModel.groupValue = value ?? "";
                    viewModel.updateUI();
                  },
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              CommonMultilineTextFormField(
                label: viewModel.stringConstants.remarks,
              ),
              const SizedBox(
                height: 16,
              ),
              CommonMultilineTextFormField(
                label: viewModel.stringConstants.summary,
              ),
            ],
          ),
        );
      },
    );
  }

  CommonRadioButton buildRadioButton(
    BuildContext context, {
    ProducerForm3ViewModel? viewModel,
  }) {
    return CommonRadioButton(
      title: viewModel?.stringConstants.misreporting,
      titleStyle: Theme.of(context).textTheme.labelSmall,
      groupValue: viewModel?.groupValue ?? "",
      value1: "yes",
      value2: "no",
      label1: viewModel?.stringConstants.yes ?? "",
      label2: viewModel?.stringConstants.no ?? "",
      onChanged: (value) {
        viewModel?.groupValue = value ?? "";
        viewModel?.updateUI();
      },
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
