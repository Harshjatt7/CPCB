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

class RecyclerStepperScreen extends StatelessWidget {
  const RecyclerStepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerStepperViewModel>(
        onModelReady: (viewModel) {},
        viewModel: RecyclerStepperViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
            onWillPop: () async {
              viewModel.onBackButton(context);
              return false;
            },
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Column(
                  children: [
                    CommonAppBar(
                      title: StringConstants().auditFormRecycler,
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
              child: Column(
                children: [
                  if (viewModel.index == 1) AuditorRecyclerForm1(),
                  if (viewModel.index == 2)  AuditorRecyclerForm2(),
                  if (viewModel.index == 3)  AuditorRecyclerForm3(),
                  if (viewModel.index == 4)  AuditorRecyclerForm4(),
                  if (viewModel.index == 5) const AuditorRecyclerForm5()
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
                          label: viewModel.index == 5
                              ? StringConstants().submitBtnLabel
                              : StringConstants().next,
                          color: AppColor().darkGreen,
                          borderColor: AppColor().darkGreen,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColor().white),
                          onPressed: () {
                            viewModel.onNextButton(context);
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
