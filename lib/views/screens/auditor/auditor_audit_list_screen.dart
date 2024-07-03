import 'package:flutter/material.dart';
import '../../../constants/image_constants.dart';
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
        onModelReady: (viewModel) {
          viewModel.progressStatus(0.9);
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
                children: List<Widget>.generate(10, (index) {
                  return AuditListCard(
                    userType: "Producer",
                    unitName: "ABC-XYZ Unit",
                    status: "Open",
                    district: "South Delhi",
                    year: "Apr-Jul, 2023-24",
                    date: "30/08/2023",
                    progress: viewModel.progress,
                    widthFactor: 0.9,
                    onTap: () {
                      viewModel.getStatus("In Progress");
                      showModalBottomSheet(
                        
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        builder: (context) {
                          return AuditorBottomSheet(
                            widthFactor: 0.9,
                            progress: viewModel.progress,
                            status: viewModel.applicationStatus,
                            unitName: "ABC-XYZ Unit",
                            unitRegisteration: "24753942FH",
                            unitGstin: "FHR5478D",
                            unitType: "Producer",
                            unitAddress:
                                "12/D Ayurveda Nagar, Opp. Ansal Plaza, South Delhi, New Delhi-110049",
                            district: "South District",
                            state: "New Delhi",
                            currentStatus: "In progress",
                            createdOn: "12-Mar-2024",
                            startDate: "15-Mar-2024",
                            endDate: "-",
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            )),
          );
        });
  }
}
