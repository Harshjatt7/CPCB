import 'package:cpcb_tyre/views/widgets/app_components/common_data_table.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../../../constants/enums/state_enums.dart';
import '../../../../models/response/auditor/producer/producer_form_2_response_model.dart';
import '../../../../viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import '../../../widgets/app_components/auditor_form_tile.dart';
import '../../../widgets/app_components/common_title_widget.dart';
import '../../../widgets/forms/stepper_button.dart';

// ignore: must_be_immutable
class ProducerForm2 extends StatelessWidget {
  final bool? isSummaryScreen;
  final String? id;
  ProducerFormsViewModel viewModel;
  ProducerForm2({super.key, this.isSummaryScreen, this.id,required this.viewModel});

  @override
  Widget build(BuildContext context) {

    return Consumer<ProducerFormsViewModel>(
      builder: (context, value, child) {
        return Stack(
          children: [
            Opacity(
              opacity: viewModel.state == ViewState.busy ? 0.5 : 1.0,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        isSummaryScreen == true
                            ? CommonSingleChildScrollView(
                                child: viewReportView(viewModel, context))
                            : CommonSingleChildScrollView(
                                child: fillFormView(viewModel, context)),
                        Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: StepperButton(
                              isLastStep: false,
                              isSummaryScreen: false,
                              onNextOrSubmit: () async {
                                await viewModel.postForm2Data(context, id: id);
                              },
                              onSavedDraft: () async {
                                await viewModel.postForm2Data(context, id: id);
                              },
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (viewModel.state == ViewState.busy)
              Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(
                    color: viewModel.appColor.black,
                  ),
                ),
              ),
          ],
        );
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
        children: [
          if (viewModel.producerForm2Data?.p1?.isNotEmpty == true)
            buildProducerSalesData(
              context,
              title:
                  "${viewModel.getTitle(viewModel.counter++)}Verification of Sales data for producers P1",
              radioTitle: viewModel.stringConstants.misreporting.i18n(),
              groupValue: viewModel.radioMisreportingP1,
              onRadioChanged: (value) {
                viewModel.radioMisreportingP1 = value ?? "";
                viewModel.updateUI();
              },
              list: viewModel.producerForm2Data?.p1,
            ),
          if (viewModel.producerForm2Data?.p2?.isNotEmpty == true)
            buildProducerSalesData(
              context,
              title:
                  "${viewModel.getTitle(viewModel.counter++)}Verification of Sales data for producers P2",
              radioTitle: viewModel.stringConstants.misreporting.i18n(),
              groupValue: viewModel.radioMisreportingP2,
              onRadioChanged: (value) {
                viewModel.radioMisreportingP2 = value ?? "";
                viewModel.updateUI();
              },
              list: viewModel.producerForm2Data?.p2,
            ),
          if (viewModel.producerForm2Data?.p3?.isNotEmpty == true)
            buildProducerSalesData(
              context,
              title:
                  "${viewModel.getTitle(viewModel.counter++)}Verification of Sales data for producers P3",
              radioTitle: viewModel.stringConstants.misreporting.i18n(),
              groupValue: viewModel.radioMisreportingP3,
              onRadioChanged: (value) {
                viewModel.radioMisreportingP3 = value ?? "";
                viewModel.updateUI();
              },
              list: viewModel.producerForm2Data?.p3,
            ),
          if (viewModel.producerForm2Data?.p4?.isNotEmpty == true)
            buildProducerSalesData(
              context,
              title:
                  "${viewModel.getTitle(viewModel.counter++)}Verification of Sales data for producers P4",
              radioTitle: viewModel.stringConstants.misreporting.i18n(),
              groupValue: viewModel.radioMisreportingP4,
              onRadioChanged: (value) {
                viewModel.radioMisreportingP4 = value ?? "";
                viewModel.updateUI();
              },
              list: viewModel.producerForm2Data?.p4,
            ),
          if (viewModel.producerForm2Data?.p5?.isNotEmpty == true)
            buildProducerSalesData(
              context,
              title:
                  "${viewModel.getTitle(viewModel.counter++)}Verification of Sales data for producers P5",
              radioTitle: viewModel.stringConstants.misreporting.i18n(),
              groupValue: viewModel.radioMisreportingP5,
              onRadioChanged: (value) {
                viewModel.radioMisreportingP5 = value ?? "";
                viewModel.updateUI();
              },
              list: viewModel.producerForm2Data?.p5,
            ),
          if (viewModel.producerForm2Data?.p6?.isNotEmpty == true)
            buildProducerSalesData(
              context,
              title:
                  "${viewModel.getTitle(viewModel.counter++)}Verification of Sales data for producers P6",
              radioTitle: viewModel.stringConstants.misreporting.i18n(),
              groupValue: viewModel.radioMisreportingP6,
              onRadioChanged: (value) {
                viewModel.radioMisreportingP6 = value ?? "";
                viewModel.updateUI();
              },
              list: viewModel.producerForm2Data?.p6,
            ),
        ],
      ),
    );
  }

  Column buildProducerSalesData(
    BuildContext context, {
    String? title,
    String? radioTitle,
    String? groupValue,
    Function(String?)? onRadioChanged,
    List<P1>? list,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTitleWidget(
          label: title ?? "",
          useLocalization: false,
        ),
        AuditorFormTile(
          title: radioTitle,
          groupValue: groupValue,
          titleStyle: Theme.of(context).textTheme.labelSmall,
          isRadioField: true,
          radioPadding: const EdgeInsets.symmetric(vertical: 7),
          onChanged: onRadioChanged,
        ),
        const SizedBox(
          height: 7,
        ),
        CommonDataTable(headingList: viewModel.producerHeadingList, list: list),
      ],
    );
  }
}
