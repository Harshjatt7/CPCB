import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/auditor/common_stepper_screen.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form4.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form5.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_3.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              onLeadingTapped: () {
                viewModel.onBackButton(context);
              },
              isLoading: viewModel.state == ViewState.busy,
              checkUser: CheckUserAndSummaryScreen(
                isSummaryScreen: false,
                userType: widget.userDetails?.userType,
                id: widget.userDetails?.id,
                index: viewModel.index,
              ),
              forms: [
                if (viewModel.index == 1)
                  form1(widget.userDetails?.id, widget.userDetails?.userType,
                      widget.userDetails?.isSummaryScreen),
                if (viewModel.index == 2)
                  form2(widget.userDetails?.id, widget.userDetails?.userType,
                      widget.userDetails?.isSummaryScreen),
                if (viewModel.index == 3)
                  form3(widget.userDetails?.id, widget.userDetails?.userType,
                      widget.userDetails?.isSummaryScreen),
                if (viewModel.index == 4)
                  form4(widget.userDetails?.id, widget.userDetails?.userType,
                      widget.userDetails?.isSummaryScreen),
                if (viewModel.index == 5)
                  form5(widget.userDetails?.id, widget.userDetails?.userType,
                      widget.userDetails?.isSummaryScreen),
              ]);
        },
        onModelReady: (viewModel) async {
          viewModel.getIndex(widget.userDetails?.progress);
          viewModel.initalizeGroupValues();
          viewModel.addController();
          viewModel.textForm2Listener();
          viewModel.textForm3Listener();
          await viewModel.getCurrentLocation();
          // if (context.mounted) {
          //   await viewModel.getRecycler1Data(context,
          //       userId: widget.userDetails?.id ?? "",
          //       isRetreader: widget.userDetails?.userType == "Retreader");
          // }
          // if (context.mounted) {
          //   await viewModel.getRecycler2Data(context,
          //       userId: widget.userDetails?.id ?? "",
          //       isRetreader: widget.userDetails?.userType == "Retreader");
          // }
          // if (context.mounted) {
          //   await viewModel.getRecycler3Data(context,
          //       userId: widget.userDetails?.id ?? "",
          //       isRetreader: widget.userDetails?.userType == "Retreader");
          // }
          // if (context.mounted) {
          //   await viewModel.getRecycler4Data(context,
          //       userId: widget.userDetails?.id ?? "",
          //       isRetreader: widget.userDetails?.userType == "Retreader");
          // }
          // if (context.mounted) {
          //   await viewModel.getRecycler5Data(context,
          //       userId: widget.userDetails?.id ?? "",
          //       isRetreader: widget.userDetails?.userType == "Retreader");
          // }
        },
        viewModel: RecyclerFormViewModel());
  }

  Widget form1(String? id, String? userType, bool? isSummaryScreen) {
    return AuditorRecyclerForm1(
      id: id,
      userType: userType,
      isSummaryScreen: isSummaryScreen,
    );
  }

  Widget form2(String? id, String? userType, bool? isSummaryScreen) {
    return AuditorRecyclerForm2(
      id: id,
      userType: userType,
      isSummaryScreen: isSummaryScreen,
    );
  }

  Widget form3(String? id, String? userType, bool? isSummaryScreen) {
    return AuditorRecyclerForm3(
      id: id,
      userType: userType,
      isSummaryScreen: isSummaryScreen,
    );
  }

  Widget form4(String? id, String? userType, bool? isSummaryScreen) {
    return AuditorRecyclerForm4(
      id: id,
      userType: userType,
      isSummaryScreen: isSummaryScreen,
    );
  }

  Widget form5(String? id, String? userType, bool? isSummaryScreen) {
    return AuditorRecyclerForm5(
      id: id,
      userType: userType,
      isSummaryScreen: isSummaryScreen,
    );
  }
}
