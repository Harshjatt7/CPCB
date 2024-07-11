import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/financial_number.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/common_screens/registration_screen.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_environment_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_erp_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_list_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../viewmodels/common_viewmodel/dashboard_viewmodel.dart';
import '../../widgets/app_components/producer_annual_return_widget.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      onModelReady: (viewModel) async {
        viewModel.getCurrentUserType(context);
        await viewModel.getDasboardData(context);
        if (context.mounted) {
          // viewModel.testPopUp(context);
        }
      },
      viewModel: DashboardViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
            isLoading: viewModel.state == ViewState.busy,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(125),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonAppBar(
                      isIconBar: true,
                      showNotificationIcon: false,
                    ),
                    CommonTitleBar(title: viewModel.stringConstants.dashboard)
                  ],
                ),
              ),
            ),
            body: viewModel.data?.currentStatus == "Approved"
                ? CommonSingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: appColor.black05,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                    color: appColor.black30,
                                    width: 1,
                                  )),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ProducerListTile(
                                        title:
                                            viewModel.stringConstants.userType,
                                        subtitle:
                                            viewModel.data?.userType ?? ""),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ProducerListTile(
                                        title: viewModel
                                            .stringConstants.currentStatus,
                                        subtitle:
                                            viewModel.data?.currentStatus ??
                                                ""),
                                  ),
                                  if (viewModel.currentUser ==
                                          UserTypes.retreader ||
                                      viewModel.currentUser ==
                                          UserTypes.recycler)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: ProducerListTile(
                                          title: viewModel.stringConstants
                                              .dateOfApplication,
                                          subtitle: viewModel
                                                  .data?.dateOfApplication ??
                                              ""),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ProducerListTile(
                                        title: viewModel
                                            .stringConstants.applicationNumber,
                                        subtitle: viewModel.data
                                                ?.uniqueRegistrationNumber ??
                                            ""),
                                  ),
                                  if (viewModel.currentUser ==
                                          UserTypes.retreader ||
                                      viewModel.currentUser ==
                                          UserTypes.recycler)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: ProducerListTile(
                                          title: viewModel.stringConstants
                                              .dateOfRegistration,
                                          subtitle: viewModel
                                                  .data?.dateOfRegistration ??
                                              ""),
                                    ),
                                  if (viewModel.currentUser ==
                                          UserTypes.retreader ||
                                      viewModel.currentUser ==
                                          UserTypes.recycler)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: ProducerListTile(
                                          title: viewModel.stringConstants
                                              .registrationExpiryDate,
                                          subtitle: viewModel.data
                                                  ?.registrationExpiryDate ??
                                              ""),
                                    ),
                                  if (viewModel.data?.downloadApplication ==
                                      true)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: CommonButtonWidget(
                                        onPressed: () async {
                                          await viewModel
                                              .getDownloadApplication(context);
                                        },
                                        label: viewModel.stringConstants
                                            .downloadApplication,
                                        color: appColor.darkGreen,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: appColor.white),
                                      ),
                                    ),
                                  if (viewModel.data?.downloadInvoice == true)
                                    CommonButtonWidget(
                                      onPressed: () async {
                                        await viewModel
                                            .getDownloadPaymentReceipt(context);
                                      },
                                      label: viewModel.stringConstants
                                          .downloadPaymentReciptBtnLabel,
                                      color: appColor.white,
                                      borderColor: appColor.darkGreen,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: appColor.darkGreen),
                                    ),
                                  if (viewModel.currentUser ==
                                      UserTypes.recycler)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: CommonButtonWidget(
                                        onPressed: () async {
                                          await viewModel
                                              .getDownloadCertificate(context);
                                        },
                                        label: viewModel.stringConstants
                                            .downloadCertificate,
                                        color: appColor.darkGreen,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: appColor.white),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (viewModel.currentUser == UserTypes.producer)
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonTextWidget(
                                viewModel.stringConstants.eprComplianceTitle,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: appColor.black90),
                              ),
                            ),
                          Column(
                            children: [
                              if (viewModel.currentUser == UserTypes.producer)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ProducerErpTile(
                                    image: imageConstants.contactPage,
                                    title: viewModel
                                        .stringConstants.totalEprObligations,
                                    subTitle:
                                        "${viewModel.data?.eprCompliance?.eprObligation.toString().formatToFinancial() ?? 0}",
                                  ),
                                ),
                              if (viewModel.currentUser == UserTypes.producer)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ProducerErpTile(
                                    image: imageConstants.contactPage,
                                    title: viewModel
                                        .stringConstants.totalEprFullFilled,
                                    subTitle:
                                        "${viewModel.data?.eprCompliance?.eprFulfilled.toString().formatToFinancial() ?? 0}",
                                  ),
                                ),
                              if (viewModel.currentUser == UserTypes.producer)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ProducerErpTile(
                                    image: imageConstants.contactPage,
                                    title: viewModel
                                        .stringConstants.remainingEprObligation,
                                    subTitle:
                                        "${viewModel.data?.eprCompliance?.eprObligationRemaining.toString().formatToFinancial() ?? 0}",
                                  ),
                                ),
                            ],
                          ),
                          if (viewModel.currentUser == UserTypes.retreader)
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonTextWidget(
                                viewModel.stringConstants.eprCredits,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: appColor.black90),
                              ),
                            ),
                          if (viewModel.currentUser == UserTypes.retreader)
                            Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title: viewModel
                                      .stringConstants.creditsGenerated,
                                  subTitle:
                                      "${viewModel.data?.eprCredits?.creditsGenerated.toString().formatToFinancial() ?? 0}",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title: viewModel
                                      .stringConstants.creditsTransferred,
                                  subTitle:
                                      "${viewModel.data?.eprCredits?.creditsTransferred.toString().formatToFinancial() ?? 0}",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title: viewModel
                                      .stringConstants.creditsAvailable,
                                  subTitle:
                                      "${viewModel.data?.eprCredits?.creditsAvailable.toString().formatToFinancial() ?? 0}",
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
                                viewModel.stringConstants.procurementStockData,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: appColor.black90),
                              ),
                            ),
                          if (viewModel.currentUser == UserTypes.retreader)
                            Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title: viewModel
                                      .stringConstants.totalProcurement,
                                  subTitle:
                                      "${viewModel.data?.procurementData?.totalProcurement.toString().formatToFinancial() ?? 0}",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title:
                                      viewModel.stringConstants.totalProcessed,
                                  subTitle:
                                      "${viewModel.data?.procurementData?.totalProcurementProcessed.toString().formatToFinancial() ?? 0}",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title:
                                      viewModel.stringConstants.availableStock,
                                  subTitle:
                                      "${viewModel.data?.procurementData?.availableStock.toString().formatToFinancial() ?? 0}",
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
                                viewModel.stringConstants.processedData,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: appColor.black90),
                              ),
                            ),
                          if (viewModel.currentUser == UserTypes.retreader)
                            Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title:
                                      viewModel.stringConstants.totalProcessed,
                                  subTitle:
                                      "${viewModel.data?.processedStock?.totalProduced?.toString().formatToFinancial() ?? 0}",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title: viewModel.stringConstants.totalSold,
                                  subTitle:
                                      "${viewModel.data?.processedStock?.totalSold.toString().formatToFinancial() ?? 0}",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ProducerErpTile(
                                  image: imageConstants.contactPage,
                                  title:
                                      viewModel.stringConstants.availableStock,
                                  subTitle:
                                      "${viewModel.data?.processedStock?.availableProcessedStock.toString().formatToFinancial() ?? 0}",
                                ),
                              ),
                            ]),
                          const SizedBox(
                            height: 8,
                          ),
                          if (viewModel.currentUser == UserTypes.retreader)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ProducerAnnualReturnWidget(
                                  title: "Annual Returns",
                                  date: viewModel.data?.annualReturn?.dueDate ??
                                      "",
                                  status: viewModel
                                          .data?.annualReturn?.currentStatus ??
                                      "",
                                  fillingDate: viewModel.data?.annualReturn
                                          ?.dateOfAnnualReturnFiling ??
                                      ""),
                            ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: appColor.black10),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    child: CommonTextWidget(
                                      viewModel.stringConstants
                                          .environmentCompensationTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    child: Divider(
                                      height: 1,
                                      color: appColor.black10,
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
                                                    title: viewModel
                                                        .stringConstants
                                                        .dateOfEc,
                                                    subtitle: HelperFunctions()
                                                        .getFormattedDate(
                                                            dtstr: viewModel
                                                                    .data
                                                                    ?.environmentCompensation
                                                                    ?.dateOfEc ??
                                                                ""),
                                                    image: imageConstants
                                                        .calendar),
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, bottom: 8),
                                                child: ProducerEnvironmentTile(
                                                    title: viewModel
                                                        .stringConstants
                                                        .currentStatus,
                                                    subtitle: viewModel
                                                            .data
                                                            ?.environmentCompensation
                                                            ?.currentStatus ??
                                                        "",
                                                    subtitleColor:
                                                        appColor.green,
                                                    image:
                                                        imageConstants.infoEnv),
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
                                                    title: viewModel
                                                        .stringConstants.type,
                                                    subtitle: viewModel
                                                            .data
                                                            ?.environmentCompensation
                                                            ?.type ??
                                                        "",
                                                    image:
                                                        imageConstants.infoEnv),
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 8),
                                                child: ProducerEnvironmentTile(
                                                    title: viewModel
                                                        .stringConstants.amount,
                                                    subtitle: viewModel
                                                            .data
                                                            ?.environmentCompensation
                                                            ?.amount ??
                                                        "",
                                                    image:
                                                        imageConstants.dollar),
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
                                              viewModel.stringConstants
                                                  .descripsionTitle,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color: appColor.black40),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: CommonTextWidget(
                                            viewModel
                                                    .data
                                                    ?.environmentCompensation
                                                    ?.description ??
                                                "",
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
                  )
                : CommonSingleChildScrollView(child: RegistrationScreen()));
      },
    );
  }
}
