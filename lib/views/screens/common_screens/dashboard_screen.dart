import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/producer/dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_environment_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_erp_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_list_tile.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
        onModelReady: (viewModel) async {
          viewModel.getCurrentUserType(context);

          await viewModel.getDasboardData();
        },
        viewModel: DashboardViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              isLoading: viewModel.state == ViewState.busy,
              appBar: CommonAppBar(
                isProfileBar: true,
                image: ImageConstants().avatar,
                name: StringConstants().name,
                designation: StringConstants.producer,
              ),
              body: CommonSingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColor().black05,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: AppColor().black30,
                                width: 1,
                              )),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ProducerListTile(
                                    title: StringConstants().userType,
                                    subtitle: viewModel.data?.userType ?? ""),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ProducerListTile(
                                    title: StringConstants().currentStatus,
                                    subtitle:
                                        viewModel.data?.currentStatus ?? ""),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ProducerListTile(
                                    title: StringConstants().applicationNumber,
                                    subtitle: viewModel
                                            .data?.uniqueRegistrationNumber ??
                                        ""),
                              ),
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   itemCount: viewModel.dashboardResponseModel?.,
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   itemBuilder: (context, index) {
                              //     return Padding(
                              //       padding: const EdgeInsets.only(bottom: 12),
                              //       child: ProducerListTile(
                              //           title: StringConstants().userType,
                              //           subtitle: StringConstants.producer),
                              //     );
                              //   },
                              // ),
                              // CommonNote(
                              //     note:
                              //         MessageConstant().producerDashBoardNote),
                              if (viewModel.data?.downloadApplication == true)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: CommonButtonWidget(
                                    label:
                                        StringConstants().downloadApplication,
                                    color: AppColor().darkGreen,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: AppColor().white),
                                  ),
                                ),
                              if (viewModel.data?.downloadInvoice == true)
                                CommonButtonWidget(
                                  label: StringConstants()
                                      .downloadPaymentReciptBtnLabel,
                                  color: AppColor().white,
                                  borderColor: AppColor().darkGreen,
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: AppColor().darkGreen),
                                )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CommonTextWidget(
                          StringConstants().eprComplianceTitle,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColor().black90),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProducerErpTile(
                              image: ImageConstants().contactPage,
                              title: StringConstants().totalEprObligations,
                              subTitle:
                                  "${viewModel.data?.eprCompliance?.eprObligation ?? 0}",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProducerErpTile(
                              image: ImageConstants().contactPage,
                              title: StringConstants().totalEprFullFilled,
                              subTitle:
                                  "${viewModel.data?.eprCompliance?.eprFulfilled ?? 0}",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProducerErpTile(
                              image: ImageConstants().contactPage,
                              title: StringConstants().totalEprObligations,
                              subTitle:
                                  "${viewModel.data?.eprCompliance?.eprObligationRemaining ?? 0}",
                            ),
                          ),
                        ],
                      ),
                      if (viewModel.currentUser == UserTypes.retreader)
                        Align(
                          alignment: Alignment.topLeft,
                          child: CommonTextWidget(
                            StringConstants().eprCredits,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColor().black90),
                          ),
                        ),
                      if (viewModel.currentUser == UserTypes.retreader)
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProducerErpTile(
                              image: ImageConstants().contactPage,
                              title: StringConstants().totalEprObligations,
                              subTitle: StringConstants().erpTileCount,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProducerErpTile(
                              image: ImageConstants().contactPage,
                              title: StringConstants().totalEprFullFilled,
                              subTitle: StringConstants().erpTileCount,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ProducerErpTile(
                              image: ImageConstants().contactPage,
                              title: StringConstants().remainingEprObligation,
                              subTitle: StringConstants().erpTileCount,
                            ),
                          ),
                        ]),
                      const SizedBox(
                        height: 8,
                      ),
                      if (viewModel.currentUser == UserTypes.retreader)
                        Align(
                          alignment: Alignment.topLeft,
                          child: CommonTextWidget(
                            StringConstants().procurementStockData,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColor().black90),
                          ),
                        ),
                      if (viewModel.currentUser == UserTypes.retreader)
                        Align(
                          alignment: Alignment.topLeft,
                          child: CommonTextWidget(
                            StringConstants().procurementStockDesc,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: AppColor().black),
                          ),
                        ),
                      if (viewModel.currentUser == UserTypes.retreader)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ProducerErpTile(
                                image: ImageConstants().contactPage,
                                title: StringConstants().totalProcurement,
                                subTitle: StringConstants().erpTileCount,
                              ),
                            );
                          },
                        ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (viewModel.currentUser == UserTypes.retreader)
                        Align(
                          alignment: Alignment.topLeft,
                          child: CommonTextWidget(
                            StringConstants().processedData,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColor().black90),
                          ),
                        ),
                      if (viewModel.currentUser == UserTypes.retreader)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ProducerErpTile(
                                image: ImageConstants().contactPage,
                                title: StringConstants().totalProcurement,
                                subTitle: StringConstants().erpTileCount,
                              ),
                            );
                          },
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 8),
                      //   child: ProducerAnnualReturnWidget(
                      //       title: StringConstants().annualReturns,
                      //       date: StringConstants().demoDate,
                      //       status: StringConstants().delayed,
                      //       fillingDate: StringConstants().demoDate),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor().black10),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: CommonTextWidget(
                                  StringConstants()
                                      .environmentCompensationTitle,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: Divider(
                                  height: 1,
                                  color: AppColor().black10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8, bottom: 8),
                                            child: ProducerEnvironmentTile(
                                                title:
                                                    StringConstants().dateOfEc,
                                                subtitle:
                                                    "${viewModel.data?.environmentCompensation?.dateOfEc}",
                                                image:
                                                    ImageConstants().calendar),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, bottom: 8),
                                            child: ProducerEnvironmentTile(
                                                title: StringConstants()
                                                    .currentStatus,
                                                subtitle:
                                                    "${viewModel.data?.environmentCompensation?.currentStatus}",
                                                subtitleColor: AppColor().green,
                                                image:
                                                    ImageConstants().infoEnv),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, right: 8),
                                            child: ProducerEnvironmentTile(
                                                title: StringConstants().type,
                                                subtitle:
                                                    "${viewModel.data?.environmentCompensation?.type}",
                                                image:
                                                    ImageConstants().infoEnv),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, top: 8),
                                            child: ProducerEnvironmentTile(
                                                title: StringConstants().amount,
                                                subtitle:
                                                    "${viewModel.data?.environmentCompensation?.amount}",
                                                image: ImageConstants().dollar),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, bottom: 10),
                                        child: CommonTextWidget(
                                          StringConstants().descripsionTitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: AppColor().black40),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: CommonTextWidget(
                                        MessageConstant().environmentText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
