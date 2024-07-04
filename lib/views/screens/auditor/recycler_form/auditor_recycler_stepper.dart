import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/auditor_recycler_form4.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/auditor_recycler_form5.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/auditor_recycler_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/auditor_recycler_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/auditor_recycler_form_3.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_progress_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../producer_form/producer_form_1.dart';
import '../producer_form/producer_form_2.dart';
import '../producer_form/producer_form_3.dart';

class CommonStepperScreen extends StatelessWidget {
  final String? userType;
  const CommonStepperScreen({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommonStepperViewModel>(
        onModelReady: (viewModel) {
          viewModel.getUser(userType);
        },
        viewModel: CommonStepperViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
            onWillPop: () async {
              viewModel.onBackButton(context);
              return false;
            },
            backgroundColor: AppColor().offWhite,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Column(
                  children: [
                    CommonAppBar(
                      title: "Audit Form - $userType",
                      onLeadingTapped: () {
                        viewModel.onBackButton(context);
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: AppColor().black20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: CommonProgressBar(
                          percentage:
                              ((viewModel.index - 1) / viewModel.totalIndex) *
                                  100,
                        ),
                      ),
                    )
                  ],
                )),
            body: CommonSingleChildScrollView(
              child: userType == "Recycler"
                  ? Column(
                      children: [
                        if (viewModel.index == 1) AuditorRecyclerForm1(),
                        if (viewModel.index == 2) const AuditorRecyclerForm2(),
                        if (viewModel.index == 3) const AuditorRecyclerForm3(),
                        if (viewModel.index == 4) const AuditorRecyclerForm4(),
                        if (viewModel.index == 5) const AuditorRecyclerForm5()
                        // PlantMachineryWidget()
                      ],
                    )
                  : userType == "Producer"
                      ? Column(
                          children: [
                            if (viewModel.index == 1) const ProducerForm1(),
                            if (viewModel.index == 2) const ProducerForm2(),
                            if (viewModel.index == 3) const ProducerForm3(),
                            // PlantMachineryWidget()
                          ],
                        )
                      : Column(
                          children: [
                            if (viewModel.index == 1) AuditorRecyclerForm1(),
                            if (viewModel.index == 2)
                              const AuditorRecyclerForm2(),
                            if (viewModel.index == 3)
                              const AuditorRecyclerForm3(),
                            if (viewModel.index == 4)
                              const AuditorRecyclerForm4(),
                            if (viewModel.index == 5)
                              const AuditorRecyclerForm5()
                            // PlantMachineryWidget()
                          ],
                        ),
            ),
            persistentFooterButtons: [
              Container(
                color: AppColor().white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18, bottom: 18, left: 16, right: 8),
                        child: CommonButtonWidget(
                          label: StringConstants().savedAsDraft,
                          borderColor: AppColor().darkGreen,
                          color: AppColor().white,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColor().darkGreen),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18, bottom: 18, left: 8, right: 16),
                        child: CommonButtonWidget(
                          label: viewModel.index == viewModel.totalIndex
                              ? StringConstants().submitBtnLabel
                              : StringConstants().next,
                          color: AppColor().darkGreen,
                          borderColor: AppColor().darkGreen,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColor().white),
                          onPressed: () {
                            viewModel.onNextButton(context, userType);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}
