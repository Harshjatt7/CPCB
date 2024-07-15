import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/auditor/common_stepper_new.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form4.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form5.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_3.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:flutter/material.dart';

class RetreaderStepper extends StatefulWidget {
  const RetreaderStepper({super.key});

  @override
  State<RetreaderStepper> createState() => _ProdcerStepperState();
}

class _ProdcerStepperState extends State<RetreaderStepper> {
  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerFormViewModel>(
        builder: (context, viewModel, child) {
          return const CommonStepperScreenNew(
              checkUser: CheckUserAndSummaryScreen(
                  isSummaryScreen: false, userType: "Retreader"),
              forms: [
                AuditorRecyclerForm1(),
                AuditorRecyclerForm2(
                  isRetreader: true,
                ),
                AuditorRecyclerForm3(),
                AuditorRecyclerForm4(),
                AuditorRecyclerForm5()
              ]);
        },
        onModelReady: (viewModel) async {
          viewModel.initalizeGroupValues();
          viewModel.addController();
          viewModel.textForm2Listener();
          viewModel.textForm3Listener();
          await viewModel.getCurrentLocation();
        },
        viewModel: RecyclerFormViewModel());
  }
}
