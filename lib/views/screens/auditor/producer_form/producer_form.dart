import 'package:cpcb_tyre/viewmodels/auditor/producer_form/producer_forms_view_model.dart';
import 'package:cpcb_tyre/views/screens/auditor/common_stepper_new.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_form_3.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:flutter/material.dart';

import '../../../../models/screen_or_widegt_arguments/user_type_and_summary.dart';

class ProdcerStepper extends StatefulWidget {
  const ProdcerStepper({super.key});

  @override
  State<ProdcerStepper> createState() => _ProdcerStepperState();
}

class _ProdcerStepperState extends State<ProdcerStepper> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProducerFormsViewModel>(
        builder: (context, model, child) {
          return CommonStepperScreenNew(
              checkUser: const CheckUserAndSummaryScreen(
                  isSummaryScreen: false, userType: "Producer"),
              forms: [
                form1(),
                form2(),
                form3(),
              ]);
        },
        onModelReady: (model) {},
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
