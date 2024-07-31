import 'dart:collection';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:flutter/material.dart';
import '../../../constants/enums/filter_enums.dart';
import '../../../constants/image_constants.dart';
import '../../../constants/message_constant.dart';
import '../../../viewmodels/auditor/auditor_list_view_model.dart';
import '../../widgets/app_components/audit_list_card.dart';
import '../../widgets/app_components/common_expansion_tile.dart';
import '../../widgets/app_components/common_search_bar.dart';
import '../../widgets/components/common_appbar.dart';
import '../../widgets/components/common_single_child_scrollview.dart';
import '../../widgets/components/common_text_widget.dart';
import '../../widgets/components/custom_scaffold.dart';
import '../../widgets/components/filter_bottom_sheet.dart';
import '../base_view.dart';

final GlobalKey<ScaffoldState> _modelScaffoldKey = GlobalKey<ScaffoldState>();

class AuditorListScreen extends StatelessWidget {
  const AuditorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuditorListViewModel>(
        onModelReady: (viewModel) async {
          await viewModel.getAuditPlanList(context);
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
                    buildSeachAndFilterBar(viewModel, context),
                  ],
                ),
              ),
            ),
            body: buildAuditListView(viewModel, context),
          );
        });
  }

  NotificationListener<ScrollNotification> buildAuditListView(
      AuditorListViewModel viewModel, BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
          viewModel.onScrollEnding(context);
        }
        return false;
      },
      child: CommonSingleChildScrollView(
          controller: viewModel.scrollController,
          child: Column(
            children: [
              Stack(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: (viewModel.auditPlanListdata?.isEmpty ??
                          true && viewModel.state == ViewState.idle)
                      ? Center(
                          child: CommonTextWidget(
                              MessageConstant().noMatchingResultsFound))
                      : Column(
                          children: List<Widget>.generate(
                              viewModel.auditPlanListdata?.length ?? 0,
                              (index) {
                            final auditPlanList =
                                viewModel.auditPlanListdata?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: AuditListCard(
                                  userType: auditPlanList?.legalName,
                                  unitName: auditPlanList?.unitName,
                                  status: auditPlanList?.status,
                                  district: auditPlanList?.district,
                                  year: auditPlanList?.financialYear,
                                  date: auditPlanList?.endDate.toString(),
                                  progress: auditPlanList?.statusPercentage
                                      ?.toDouble(),
                                  onTap: () async {
                                    await viewModel.getAuditPlanDetail(context,
                                        id: auditPlanList?.id);
                                    final auditPlanListDetail =
                                        viewModel.auditPlanDetaildata?[0];
                                    if (context.mounted) {
                                      viewModel.viewBottomSheet(context,
                                          auditPlanDetail: auditPlanListDetail);
                                    }
                                  }),
                            );
                          }),
                        ),
                ),
                if (viewModel.state == ViewState.parallelBusy)
                  const Positioned(
                    bottom: 15,
                    left: 16,
                    right: 16,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ]),
            ],
          )),
    );
  }

  Container buildSeachAndFilterBar(
      AuditorListViewModel viewModel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: viewModel.appColor.black10,
      ))),
      child: CommonSearchBarWidget(
        title: viewModel.stringConstants.auditList,
        isSearchExpanded: viewModel.isSearchExpanded,
        controller: viewModel.searchController,
        hintText: viewModel.stringConstants.searchHere,
        onChanged: (value) async {
          viewModel.isSearchExpanded = true;
          viewModel.searchAuditorPlanList(value: value);
          if (viewModel.searchController.text.isEmpty) {
            viewModel.getUpdatedList();
          }
        },
        onSuffixTap: () {
          if (viewModel.searchController.text.isEmpty) {
            viewModel.isSearchExpanded = !viewModel.isSearchExpanded;
            viewModel.updateUI();
            viewModel.getUpdatedList();
          } else {
            viewModel.isSearchExpanded = false;
            viewModel.updateUI();
            viewModel.getUpdatedList();
          }
        },
        showFilter: true,
        onFilterTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext ctx) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .32,
                child: Scaffold(
                    key: _modelScaffoldKey,
                    resizeToAvoidBottomInset: true,
                    body: FilterBottomSheet(
                        onApply: () async {
                          Navigator.pop(ctx);
                          await viewModel.onApplyClicked(context);
                        },
                        onClose: () async {
                          Navigator.pop(ctx);
                          await viewModel.onCloseClicked();
                        },
                        filterTiles: [
                          CommonExpansionTile(
                            tempSelectedList:
                                viewModel.tempSelectedUnitTypeList,
                            title: "Unit Type",
                            listCallBack: (value) {
                              viewModel.tempSelectedUnitTypeList.clear();
                              viewModel.tempSelectedUnitTypeList.addAll(value);
                              viewModel.tempSelectedUnitTypeList =
                                  LinkedHashSet<String>.from(
                                          viewModel.tempSelectedUnitTypeList)
                                      .toList();
                            },
                            isChecked: viewModel.isUnitTypeChecked,
                            isShowHide: viewModel.isUnitTypeShowHide,
                            checkBoxList: viewModel.unitTypeList,
                            selectedList: viewModel.selectedUnitTypeList,
                            type: FilterTypes.unitType,
                          ),
                          CommonExpansionTile(
                              tempSelectedList:
                                  viewModel.tempSelectedCurrentStatusList,
                              title: "Current Status",
                              isChecked: viewModel.isCurrentStatusChecked,
                              isShowHide: viewModel.isCurrentStatusShowHide,
                              checkBoxList: viewModel.currentStatusList,
                              selectedList: viewModel.selectedCurrentStatusList,
                              listCallBack: (value) {
                                viewModel.tempSelectedCurrentStatusList.clear();
                                viewModel.tempSelectedCurrentStatusList
                                    .addAll(value);
                                viewModel.tempSelectedCurrentStatusList =
                                    LinkedHashSet<String>.from(viewModel
                                            .tempSelectedCurrentStatusList)
                                        .toList();
                              },
                              type: FilterTypes.currentStatus),
                        ])),
              );
            },
          ).whenComplete(() {
            viewModel.tempSelectedCurrentStatusList.clear();
            viewModel.tempSelectedUnitTypeList.clear();
          });
        },
      ),
    );
  }
}
