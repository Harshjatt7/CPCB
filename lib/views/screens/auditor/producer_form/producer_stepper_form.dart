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
                  isSummaryScreen: false,
                  userType: widget.userDetails?.userType,
                  id: widget.userDetails?.id),
              forms: [
                form1(widget.userDetails?.id,viewModel: viewModel),
                form2(widget.userDetails?.id,viewModel: viewModel),
                form3(widget.userDetails?.id,viewModel: viewModel),
              ]);
        },
        onModelReady: (viewModel) async {
          viewModel.initalizeGroupValues();
          viewModel.getProducerForm1Data(id: widget.userDetails?.id);
          viewModel.counter = 0;
          
        },
        viewModel: ProducerFormsViewModel());
  }

  Widget form1(String? id, {required ProducerFormsViewModel viewModel}) {
    return ProducerForm1(id: id,viewModel: viewModel,);
  }

  Widget form2(String? id,{required ProducerFormsViewModel viewModel}) {
    return ProducerForm2(id: id,viewModel: viewModel);
  }

  Widget form3(String? id,{required ProducerFormsViewModel viewModel}) {
    return ProducerForm3(id: id,viewModel: viewModel);
  }
}
