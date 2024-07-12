import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/auditor/auditor_recycler_stepper_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form4.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form5.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_1.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_2.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_form_3.dart';
import 'package:cpcb_tyre/viewmodels/auditor/producer_form/producer_form_1_view_model.dart';

import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_progress_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/request/auditor/produer_form_1_request_model.dart';
import 'producer_form/producer_form_1.dart';
import 'producer_form/producer_form_2.dart';
import 'producer_form/producer_form_3.dart';

class CommonStepperScreen extends StatelessWidget {
  final CheckUserAndSummaryScreen? checkUser;
  final VoidCallback? onNextPressed;
  const CommonStepperScreen({super.key, this.checkUser, this.onNextPressed});

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
            appBar: PreferredSize(
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
                        )),
                  ],
                )),
            body: Form(
              key: viewModel.formKey,
              child: CommonSingleChildScrollView(
                child: checkUser?.userType == "Recycler"
                    ? Column(
                        children: [
                          if (viewModel.index == 1)
                            const AuditorRecyclerForm1(),
                          if (viewModel.index == 2)
                            const AuditorRecyclerForm2(),
                          if (viewModel.index == 3)
                            const AuditorRecyclerForm3(),
                          if (viewModel.index == 4)
                            const AuditorRecyclerForm4(),
                          if (viewModel.index == 5) const AuditorRecyclerForm5()
                          // PlantMachineryWidget()
                        ],
                      )
                    : checkUser?.userType == "Producer"
                        ? Column(
                            children: [
                              if (viewModel.index == 1)
                                ProducerForm1(
                                  isSummaryScreen: checkUser?.isSummaryScreen,
                                ),
                              if (viewModel.index == 2)
                                ProducerForm2(
                                  isSummaryScreen: checkUser?.isSummaryScreen,
                                ),
                              if (viewModel.index == 3)
                                ProducerForm3(
                                  isSummaryScreen: checkUser?.isSummaryScreen,
                                ),
                              // PlantMachineryWidget()
                            ],
                          )
                        : Column(
                            children: [
                              if (viewModel.index == 1)
                                const AuditorRecyclerForm1(),
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
            ),
            persistentFooterButtons: [
              Container(
                color: AppColor().white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (checkUser?.isSummaryScreen == false)
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 18, bottom: 18, left: 16, right: 8),
                          child: CommonButtonWidget(
                            onPressed: () {
                              viewModel.formValidation(
                                  context, checkUser?.userType);
                            },
                            label: StringConstants().savedAsDraft,
                            borderColor: AppColor().darkGreen,
                            color: AppColor().white,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColor().darkGreen),
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
                          color: viewModel.index == viewModel.totalIndex &&
                                  checkUser?.isSummaryScreen == true
                              ? AppColor().black10
                              : AppColor().darkGreen,
                          borderColor:
                              viewModel.index == viewModel.totalIndex &&
                                      checkUser?.isSummaryScreen == true
                                  ? AppColor().black10
                                  : AppColor().darkGreen,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColor().white),
                          onPressed:
                              viewModel.index == viewModel.totalIndex &&
                                      checkUser?.isSummaryScreen == true
                                  ? () {}
                                  : () {
                                      // viewModel.formValidation(
                                      //     context, checkUser?.userType);
                                      viewModel.onNextButton(
                                          context, checkUser?.userType);

                                      var abc =
                                          Provider.of<ProducerForm1ViewModel>(
                                              context,
                                              listen: false);

                                      ProducerForm1RequestModel requestModel =
                                          ProducerForm1RequestModel(
                                        companyDetails: CompanyDetails(
                                            companyNameAddress: CompanyData(
                                                auditConfirmedStatus:
                                                    abc.radioCompanyDetail,
                                                auditRemark:
                                                    abc.companyNameRemark.text),
                                            producerCategory: CompanyData(
                                                auditConfirmedStatus:
                                                    abc.radioCategoryOfProducer,
                                                auditRemark: abc
                                                    .categoryOfProducerRemark
                                                    .text),
                                            companyPan: CompanyData(
                                                auditConfirmedStatus:
                                                    abc.radioPanOfCompany,
                                                auditRemark:
                                                    abc.panController.text),
                                            companyGst: CompanyData(
                                                auditConfirmedStatus:
                                                    abc.radioGst,
                                                auditRemark:
                                                    abc.gstController.text),
                                            companyCin: CompanyData(
                                                auditConfirmedStatus:
                                                    abc.radioCin,
                                                auditRemark: abc.cinController.text),
                                            companyIec: CompanyData(auditConfirmedStatus: abc.radioIec, auditRemark: abc.iecController.text)),
                                      );

                                      HelperFunctions()
                                          .logger("${requestModel.toJson()}");
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
