import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../viewmodels/auditor/auditor_producer_viewmodel.dart';
import '../../base_view.dart';

class ProducerForm extends StatelessWidget {
  const ProducerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuditorProducerViewModel>(
        viewModel: AuditorProducerViewModel(),
        onModelReady: (viewModel) {
          viewModel.initialize();
        },
        builder: (context, viewModel, child) {
          return CustomScaffold(
              body: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    "(A). Company details",
                    useLocalization: false,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CommonRadioButton(
                      title: "Company name and address",
                      groupValue: viewModel.companyNameGroupVal,
                      value1: "Unconfirmed",
                      value2: "Confirmed",
                      label1: "Unconfirmed",
                      label2: "Confirmed",
                      isMandatory: true,
                      onChanged1: (val) {
                        viewModel.changeComapnyNameGroupVal(val);
                      },
                      onChanged2: (val) {
                        viewModel.changeComapnyNameGroupVal(val);
                      }),
                  CommonTextFormFieldWidget(
                      hintText: "Company name and address",
                      isMandatory: false,
                      isReadOnly: true,
                      controller: viewModel.companyNameController),
                  SizedBox(
                    height: 16,
                  ),
                  CommonTextFormFieldWidget(
                      hintText: "Remarks",
                      isMandatory: false,
                      controller: viewModel.companyNameController)
                ],
              ),
            ),
          ));
        });
  }
}
