import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import 'package:cpcb_tyre/views/screens/auditor/common_stepper_screen.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_3.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:flutter/material.dart';
import '../../../../models/screen_or_widegt_arguments/user_type_and_summary.dart';

class ProducerStepper extends StatefulWidget {
  final CheckUserAndSummaryScreen? userDetails;
  const ProducerStepper({super.key, this.userDetails});

  @override
  State<ProducerStepper> createState() => _ProdcerStepperState();
}

class _ProdcerStepperState extends State<ProducerStepper> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProducerFormsViewModel>(
        builder: (context, viewModel, child) {
          return CommonStepperScreen(
              onLeadingTapped: () async {
                if (viewModel.state != ViewState.busy) {
                  await viewModel.onBackButton(
                      context, widget.userDetails?.id ?? "");
                }
              },
              checkUser: CheckUserAndSummaryScreen(
                isSummaryScreen: widget.userDetails?.isSummaryScreen,
                userType: widget.userDetails?.userType,
                id: widget.userDetails?.id,
                index: viewModel.index,
              ),
              forms: [
                if (viewModel.index == 1)
                  form1(widget.userDetails?.id,
                      widget.userDetails?.isSummaryScreen),
                if (viewModel.index == 2)
                  form2(widget.userDetails?.id,
                      widget.userDetails?.isSummaryScreen),
                if (viewModel.index == 3)
                  form3(widget.userDetails?.id,
                      widget.userDetails?.isSummaryScreen),
              ]);
        },
        onModelReady: (viewModel) async {
          viewModel.getIndex(widget.userDetails?.progress);
          viewModel.initalizeGroupValues();
          _loadInitialData(viewModel);
        },
        viewModel: ProducerFormsViewModel());
  }

  Widget form1(String? id, bool? isSummaryScreen) {
    return ProducerForm1(
      id: id,
      isSummaryScreen: isSummaryScreen,
    );
  }

  Widget form2(String? id, bool? isSummaryScreen) {
    return ProducerForm2(
      id: id,
      isSummaryScreen: isSummaryScreen,
    );
  }

  Widget form3(String? id, bool? isSummaryScreen) {
    return ProducerForm3(
      id: id,
      isSummaryScreen: isSummaryScreen,
    );
  }

  Future<void> _loadInitialData(ProducerFormsViewModel viewModel) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      switch (viewModel.index) {
        case 1:
          await viewModel.getProducerForm1Data(context,
              id: widget.userDetails?.id);
          break;
        case 2:
          await viewModel.getProducerForm2Data(context,
              id: widget.userDetails?.id);
          break;
        case 3:
          await viewModel.getProducerForm3Data(context,
              id: widget.userDetails?.id);
          break;
      }
      viewModel.updateUI();
    });
  }
}
