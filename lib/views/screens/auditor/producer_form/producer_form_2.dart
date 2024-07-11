import 'package:cpcb_tyre/viewmodels/auditor/producer_form/producer_form_2_view_model.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_data_table.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../widgets/app_components/auditor_form_tile.dart';
import '../../../widgets/app_components/common_title_widget.dart';

class ProducerForm2 extends StatelessWidget {
  const ProducerForm2({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (viewModel) {},
      viewModel: ProducerForm2ViewModel(),
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTitleWidget(
                  label: viewModel.stringConstants.verificationA),
              AuditorFormTile(
                title: viewModel.stringConstants.misreporting.i18n(),
                groupValue: viewModel.radioMisreportingP1,
                titleStyle: Theme.of(context).textTheme.labelSmall,
                isRadioField: true,
                radioPadding: const EdgeInsets.symmetric(vertical: 7),
                onChanged: (value) {
                  viewModel.radioMisreportingP1 = value ?? "";
                  viewModel.updateUI();
                },
              ),
              const SizedBox(
                height: 7,
              ),
              CommonDataTable(headingList: viewModel.producerHeadingList),
              const SizedBox(
                height: 24,
              ),
              CommonTitleWidget(
                  label: viewModel.stringConstants.verificationB),
              AuditorFormTile(
                title: viewModel.stringConstants.misreporting.i18n(),
                groupValue: viewModel.radioMisreportingP3,
                titleStyle: Theme.of(context).textTheme.labelSmall,
                isRadioField: true,
                radioPadding: const EdgeInsets.symmetric(vertical: 7),
                onChanged: (value) {
                  viewModel.radioMisreportingP3 = value ?? "";
                  viewModel.updateUI();
                },
              ),
              const SizedBox(
                height: 7,
              ),
              CommonDataTable(headingList: viewModel.producerHeadingList),
            ],
          ),
        );
      },
    );
  }
}
