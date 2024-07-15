import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/auditor/common_stepper_screen.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form4.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form5.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_3.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:flutter/material.dart';

import '../../../../models/screen_or_widegt_arguments/user_type_and_summary.dart';

class RecyclerStepper extends StatefulWidget {
  const RecyclerStepper({super.key});

  @override
  State<RecyclerStepper> createState() => _ProdcerStepperState();
}

class _ProdcerStepperState extends State<RecyclerStepper> {
  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerFormViewModel>(
        builder: (context, viewModel, child) {
          return const CommonStepperScreen(
              checkUser: CheckUserAndSummaryScreen(
                  isSummaryScreen: false, userType: "Recycler"),
              forms: [
                AuditorRecyclerForm1(),
                AuditorRecyclerForm2(),
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
