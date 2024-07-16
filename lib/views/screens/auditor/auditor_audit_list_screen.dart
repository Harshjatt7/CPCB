import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:flutter/material.dart';
import '../../../constants/image_constants.dart';
import '../../../models/screen_or_widegt_arguments/user_type_and_summary.dart';
import '../../../viewmodels/auditor/auditor_list_view_model.dart';
import '../../widgets/app_components/audit_list_card.dart';
import '../../widgets/app_components/auditor_bottom_sheet.dart';
import '../../widgets/app_components/common_search_bar.dart';
import '../../widgets/components/common_appbar.dart';
import '../../widgets/components/common_single_child_scrollview.dart';
import '../../widgets/components/custom_scaffold.dart';
import '../base_view.dart';

class AuditorListScreen extends StatelessWidget {
  const AuditorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuditorListViewModel>(
        onModelReady: (viewModel) async {
          await viewModel.getAuditPlanList(context);
          // if (context.mounted) {
          //
          // }
        },
        viewModel: AuditorListViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
            isLoading: viewModel.state == ViewState.busy,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  (viewModel.searchController.text.isNotEmpty ||
                          viewModel.isSearchExpanded == true)
                      ? 146
                      : 125),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonAppBar(
                      isIconBar: true,
                      showNotificationIcon: false,
                      image: ImageConstants().avatar,
                      name: viewModel.stringConstants.name,
                      designation: viewModel.stringConstants.userType,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: viewModel.appColor.black10,
                      ))),
                      child: CommonSearchBarWidget(
                        showFilter: true,
                        title: viewModel.stringConstants.auditList,
                        isSearchExpanded: viewModel.isSearchExpanded,
                        controller: viewModel.searchController,
                        hintText: viewModel.stringConstants.searchHere,
                        onChanged: (value) async {
                          viewModel.isSearchExpanded = true;
                          // viewModel.searchRetreader(value, userType ?? "");
                          if (viewModel.searchController.text.isEmpty) {
                            //viewModel.getUpdatedList();
                          }
                        },
                        onSuffixTap: () {
                          if (viewModel.searchController.text.isEmpty) {
                            viewModel.isSearchExpanded =
                                !viewModel.isSearchExpanded;
                            viewModel.updateUI();
                            //viewModel.getUpdatedList();
                          } else {
                            viewModel.isSearchExpanded = false;
                            viewModel.updateUI();
                            //viewModel.getUpdatedList();
                          }
                        },
                        onFilterTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: CommonSingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: List<Widget>.generate(
                    viewModel.auditPlanListdata?.length ?? 0, (index) {
                  final auditPlanList = viewModel.auditPlanListdata?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: AuditListCard(
                      userType: auditPlanList?.legalName,
                      unitName: auditPlanList?.unitName,
                      status: auditPlanList?.status,
                      district: auditPlanList?.district,
                      year: auditPlanList?.financialYear,
                      date: auditPlanList?.endDate.toString(),
                      progress: auditPlanList?.statusPercentage?.toDouble(),
                      onTap: () async {
                        if (context.mounted) {
                          await viewModel.getAuditPlanDetail(context,
                              id: auditPlanList?.id);
                        }
                        viewModel.getStatus(
                            auditPlanList?.status.toString() ?? "assigned");
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          builder: (context) {
                            final auditPlanDetail =
                                viewModel.auditPlanDetaildata?[index];
                            return AuditorBottomSheet(
                              progress:
                                  auditPlanDetail?.statusPercentage?.toDouble(),
                              status: viewModel.applicationStatus,
                              unitName: auditPlanDetail?.unitName,
                              unitRegisteration: auditPlanDetail?.regNum,
                              unitGstin: auditPlanDetail?.gstin,
                              unitType: auditPlanDetail?.legalName,
                              unitAddress: auditPlanDetail?.address,
                              district: auditPlanDetail?.district,
                              state: auditPlanDetail?.state,
                              currentStatus: auditPlanDetail?.status,
                              createdOn: auditPlanDetail?.quarter,
                              startDate: auditPlanDetail?.startDate,
                              endDate: auditPlanDetail?.endDate,
                              onPressed: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   AppRoutes.auditorRecyclerViewDataScreen,
                                // );
                                Navigator.pushNamed(
                                    context, AppRoutes.auditorProducerStepperScreen,
                                    arguments: const CheckUserAndSummaryScreen(
                                        userType: "Producer",
                                        isSummaryScreen: false));
                                // Navigator.pushNamed(context,
                                //     AppRoutes.auditorRecyclerStepperScreen,
                                //     arguments: const CheckUserAndSummaryScreen(
                                //         userType: "Recycler",
                                //         isSummaryScreen: false));
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            )),
          );
        });
  }
}
