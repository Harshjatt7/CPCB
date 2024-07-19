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
              checkUser: CheckUserAndSummaryScreen(
                isSummaryScreen: true,
                userType: widget.userDetails?.userType,
                id: widget.userDetails?.id,
              ),
              forms: widget.userDetails?.progress == 0
                  ? [
                      form1(widget.userDetails?.id),
                      form2(widget.userDetails?.id),
                      form3(widget.userDetails?.id),
                    ]
                  : widget.userDetails?.progress == 33
                      ? [
                          form2(widget.userDetails?.id),
                          form3(widget.userDetails?.id),
                        ]
                      : [
                          form3(widget.userDetails?.id),
                        ]);
        },
        onModelReady: (viewModel) async {
          // viewModel.initalizeGroupValues();
          if (widget.userDetails?.progress == 0) {
            await viewModel.getProducerForm1Data(id: widget.userDetails?.id);
          }
          if (widget.userDetails?.progress == 33) {
            await viewModel.getProducerForm2Data(id: widget.userDetails?.id);
          }
          if (widget.userDetails?.progress == 66) {
            await viewModel.getProducerForm3Data(id: widget.userDetails?.id);
          }
          viewModel.counter = 0;
        },
        viewModel: ProducerFormsViewModel());
  }

  Widget form1(
    String? id,
  ) {
    return ProducerForm1(
      id: id,
    );
  }

  Widget form2(String? id) {
    return ProducerForm2(id: id);
  }

  Widget form3(String? id) {
    return ProducerForm3(id: id);
  }
}
