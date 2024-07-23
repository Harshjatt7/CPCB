import 'package:cpcb_tyre/constants/enums/state_enums.dart';
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
  final CheckUserAndSummaryScreen? userDetails;
  const RecyclerStepper({super.key, this.userDetails});

  @override
  State<RecyclerStepper> createState() => _ProdcerStepperState();
}

class _ProdcerStepperState extends State<RecyclerStepper> {
  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerFormViewModel>(
        builder: (context, viewModel, child) {
          return CommonStepperScreen(
              isLoading: viewModel.state == ViewState.busy,
              checkUser:  CheckUserAndSummaryScreen(
                  isSummaryScreen: false,
                  userType: widget.userDetails?.userType,
                  id: widget.userDetails?.id),
              forms: [
                const AuditorRecyclerForm1(),
                AuditorRecyclerForm2(
                  id: widget.userDetails?.id,
                  isRetreader: true,
                ),
                AuditorRecyclerForm3(id: widget.userDetails?.id),
                AuditorRecyclerForm4(
                  id: widget.userDetails?.id,
                ),
                const AuditorRecyclerForm5()
              ]);
        },
        onModelReady: (viewModel) async {
          viewModel.initalizeGroupValues();
          viewModel.addController();
          viewModel.textForm2Listener();
          viewModel.textForm3Listener();
          await viewModel.getCurrentLocation();
          // if (context.mounted) {
          //   await viewModel.getRecycler1Data(context);
          // }
          if (context.mounted) {
            await viewModel.getRecycler2Data(
              context,
            );
          }
          if (context.mounted) {
            await viewModel.getRecycler3Data(
              context,
            );
          }
          if (context.mounted) {
            await viewModel.getRecycler1Data(context);
          }
        
        },
        viewModel: RecyclerFormViewModel());
  }
}
