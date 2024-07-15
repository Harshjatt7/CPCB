import 'package:cpcb_tyre/viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import 'package:cpcb_tyre/views/screens/auditor/common_stepper_screen.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_3.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:flutter/material.dart';

import '../../../../models/screen_or_widegt_arguments/user_type_and_summary.dart';

class ProducerStepper extends StatefulWidget {
  const ProducerStepper({super.key});

  @override
  State<ProducerStepper> createState() => _ProdcerStepperState();
}

class _ProdcerStepperState extends State<ProducerStepper> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProducerFormsViewModel>(
        builder: (context, model, child) {
          return CommonStepperScreen(
              checkUser: const CheckUserAndSummaryScreen(
                  isSummaryScreen: false, userType: "Producer"),
              forms: [
                form1(),
                form2(),
                form3(),
              ]);
        },
        onModelReady: (viewModel) {
            viewModel.initalizeGroupValues();
        },
        viewModel: ProducerFormsViewModel());
  }

  Widget form1() {
    return const ProducerForm1();
  }

  Widget form2() {
    return const ProducerForm2();
  }

  Widget form3() {
    return const ProducerForm3();
  }
}
