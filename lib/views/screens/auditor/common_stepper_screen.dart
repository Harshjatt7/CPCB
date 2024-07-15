import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_progress_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../models/screen_or_widegt_arguments/user_type_and_summary.dart';

class CommonStepperScreen extends StatelessWidget {
  final CheckUserAndSummaryScreen? checkUser;

  final List<Widget> forms;

  const CommonStepperScreen(
      {super.key, this.checkUser, required this.forms});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommonStepperViewModel>(
        onModelReady: (viewModel) {
          viewModel.getUser(checkUser?.userType.toString());
        },
        viewModel: CommonStepperViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
            resizeToBottomInset: true,
            onWillPop: () async {
              viewModel.onBackButton(context);
              return false;
            },
            appBar: appBar(viewModel, context),
            body: Form(
              key: viewModel.formKey,
              child: forms[viewModel.index - 1],
            ),
          );
        });
  }

  PreferredSize appBar(CommonStepperViewModel viewModel, BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          children: [
            CommonAppBar(
              title: "Audit Form - ${checkUser?.userType}",
              onLeadingTapped: () {
                viewModel.onBackButton(context);
              },
            ),
            Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: AppColor().black20))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: CommonProgressBar(
                    percentage:
                        ((viewModel.index - 1) / viewModel.totalIndex) * 100,
                  ),
                )),
          ],
        ));
  }
}
