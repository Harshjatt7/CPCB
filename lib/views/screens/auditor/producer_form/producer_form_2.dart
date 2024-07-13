import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_data_table.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import '../../../widgets/app_components/auditor_form_tile.dart';
import '../../../widgets/app_components/common_title_widget.dart';

class ProducerForm2 extends StatefulWidget {
  final bool? isSummaryScreen;
  const ProducerForm2({super.key, this.isSummaryScreen});

  @override
  State<ProducerForm2> createState() => _ProducerForm2State();
}

class _ProducerForm2State extends State<ProducerForm2> {
  late ProducerFormsViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<ProducerFormsViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (viewModel) {},
      viewModel: ProducerFormsViewModel(),
      builder: (context, viewModel, child) {
        return widget.isSummaryScreen == true
            ? CommonSingleChildScrollView(
                child: viewReportView(viewModel, context))
            : CommonSingleChildScrollView(
                child: fillFormView(viewModel, context));
      },
    );
  }

  Padding viewReportView(
      ProducerFormsViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: viewModel.stringConstants.verificationA),
          AuditorFormTile(
            title: viewModel.stringConstants.misreporting.i18n(),
            groupValue: viewModel.radioMisreportingP1,
            titleStyle: Theme.of(context).textTheme.labelSmall,
            isRadioField: true,
            radioPadding: const EdgeInsets.symmetric(vertical: 7),
          ),
          const SizedBox(
            height: 7,
          ),
          CommonDataTable(headingList: viewModel.producerHeadingList),
          const SizedBox(
            height: 24,
          ),
          CommonTitleWidget(label: viewModel.stringConstants.verificationB),
          AuditorFormTile(
            title: viewModel.stringConstants.misreporting.i18n(),
            groupValue: viewModel.radioMisreportingP3,
            titleStyle: Theme.of(context).textTheme.labelSmall,
            isRadioField: true,
            radioPadding: const EdgeInsets.symmetric(vertical: 7),
          ),
          const SizedBox(
            height: 7,
          ),
          CommonDataTable(headingList: viewModel.producerHeadingList),
        ],
      ),
    );
  }

  Padding fillFormView(ProducerFormsViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTitleWidget(label: viewModel.stringConstants.verificationA),
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
          CommonTitleWidget(label: viewModel.stringConstants.verificationB),
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
  }
}
