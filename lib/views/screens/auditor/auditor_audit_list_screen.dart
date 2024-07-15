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
          if (context.mounted) {
            await viewModel.getAuditPlanDetail(context);
          }
        },
        viewModel: AuditorListViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
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
                    viewModel.auditPlanDetaildata?.length ?? 0, (index) {
                  final auditPlanDetail = viewModel.auditPlanDetaildata?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: AuditListCard(
                      userType: auditPlanDetail?.legalName,
                      unitName: auditPlanDetail?.unitName,
                      status: auditPlanDetail?.status,
                      district: auditPlanDetail?.district,
                      year: auditPlanDetail?.financialYear,
                      date: auditPlanDetail?.endDate.toString(),
                      progress: auditPlanDetail?.statusPercentage?.toDouble(),
                      onTap: () {
                        viewModel.getStatus(
                            auditPlanDetail?.status.toString() ?? "Open");
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          builder: (context) {
                            final auditPlanList =
                                viewModel.auditPlanListdata?[index];
                            return AuditorBottomSheet(
                              progress: auditPlanList?.statusPercentage?.toDouble(),
                              status: viewModel.applicationStatus,
                              unitName: auditPlanList?.unitName,
                              unitRegisteration: auditPlanList?.regNum,
                              unitGstin: auditPlanList?.gstin,
                              unitType: auditPlanList?.legalName,
                              unitAddress:
                                  auditPlanList?.address,
                              district: auditPlanList?.district,
                              state: auditPlanList?.state,
                              currentStatus: auditPlanList?.status,
                              createdOn: "",
                              startDate: auditPlanList?.startDate,
                              endDate: auditPlanList?.endDate.toString(),
                              onPressed: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   AppRoutes.auditorRecyclerViewDataScreen,
                                // );
                                // Navigator.pushNamed(
                                //     context, AppRoutes.auditorProducerStepperScreen,
                                //     arguments: const CheckUserAndSummaryScreen(
                                //         userType: "Producer",
                                //         isSummaryScreen: false));
                                   Navigator.pushNamed(
                                    context, AppRoutes.auditorRecyclerStepperScreen,
                                    arguments: const CheckUserAndSummaryScreen(
                                        userType: "Recycler",
                                        isSummaryScreen: false));
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
