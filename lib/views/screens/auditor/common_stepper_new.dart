import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_progress_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class CommonStepperScreenNew extends StatelessWidget {
  final CheckUserAndSummaryScreen? checkUser;

  final List<Widget> forms;

  const CommonStepperScreenNew(
      {super.key, this.checkUser, required this.forms});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommonStepperViewModel>(
        onModelReady: (viewModel) {
          HelperFunctions().logger(">>>>>>>>${checkUser?.userType}");
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
            // persistentFooterButtons: [
            //   Container(
            //     color: AppColor().white,
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         if (checkUser?. isSummaryScreen == false)
            //           Flexible(
            //             flex: 1,
            //             child: Padding(
            //               padding: const EdgeInsets.only(
            //                   top: 18, bottom: 18, left: 16, right: 8),
            //               child: CommonButtonWidget(
            //                 onPressed: () {

            //                 },
            //                 label: StringConstants().savedAsDraft,
            //                 borderColor: AppColor().darkGreen,
            //                 color: AppColor().white,
            //                 labelStyle: Theme.of(context)
            //                     .textTheme
            //                     .labelMedium
            //                     ?.copyWith(color: AppColor().darkGreen),
            //               ),
            //             ),
            //           ),
            //         Flexible(
            //           flex: 1,
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //                 top: 18, bottom: 18, left: 8, right: 16),
            //             child: CommonButtonWidget(
            //               label: viewModel.index == viewModel.totalIndex
            //                   ? StringConstants().submitBtnLabel
            //                   : StringConstants().next,
            //               color:  viewModel.index == viewModel.totalIndex &&
            //                     checkUser?.  isSummaryScreen == true
            //                   ? AppColor().black10
            //                   : AppColor().darkGreen,
            //               borderColor:
            //                    viewModel.index == viewModel.totalIndex &&
            //                         checkUser?.  isSummaryScreen == true
            //                       ? AppColor().black10
            //                       : AppColor().darkGreen,
            //               labelStyle: Theme.of(context)
            //                   .textTheme
            //                   .labelMedium
            //                   ?.copyWith(color: AppColor().white),
            //               onPressed:  viewModel.index == viewModel.totalIndex &&
            //                    checkUser?.   isSummaryScreen == true
            //                   ? () {}
            //                   : () {

            //                     },
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   )
            // ],

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
