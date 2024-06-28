import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/spcb/spcb_tab.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_search_bar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../constants/string_constant.dart';
import '../../../models/screen_or_widegt_arguments/tab_bar_model.dart';
import '../../../theme/app_color.dart';
import '../../../viewmodels/spcb/spcb_dashboard_view_model.dart';
import '../../widgets/app_components/common_tabbar.dart';

class SpcbDashboardScreen extends StatelessWidget {
  final StringConstants stringConstants = StringConstants();
  SpcbDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    final appColor = AppColor();
    return BaseView<SpcbDashboardViewModel>(
        builder: (context, viewModel, child) {
          return CustomScaffold(
            isLoading: viewModel.state == ViewState.busy,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  viewModel.isSearchExpanded == true ? 146 : 125),
              child: SafeArea(
                child: Column(
                  children: [
                    CommonAppBar(
                      isIconBar: true,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: appColor.black10,
                          ),
                        ),
                      ),
                      child: CommonSearchBarWidget(
                        isSearchExpanded: viewModel.isSearchExpanded,
                        controller: viewModel.searchController,
                        hintText: stringConstants.searchHere,
                        onChanged: (value) {
                          viewModel.isSearchExpanded = true;
                          viewModel.searchSPCB(value);
                          if (viewModel.searchController.text.isEmpty) {
                            viewModel.getUpdatedList();
                          }
                        },
                        title: stringConstants.spcbDashboard,
                        onSuffixTap: () {
                          viewModel.resetCurrentUserPage(isSearch: true);
                          if (viewModel.searchController.text.isEmpty) {
                            viewModel.isSearchExpanded =
                                !viewModel.isSearchExpanded;
                            viewModel.getUpdatedList();

                            viewModel.updateUI();
                          } else {
                            viewModel.isSearchExpanded = false;
                            viewModel.getUpdatedList();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonTabBar(
                scrollController: viewModel.scrollController,
                onScrollEnding: () {
                  viewModel.onScrollEnding();
                },
                tabs: [
                  TabBarModel(
                      tab: SpcbCommonTab(
                        viewModel: viewModel,
                        showNoMatchingText: viewModel.producerData == null,
                        data: (viewModel.searchController.text.isNotEmpty)
                            ? viewModel.state == ViewState.busy
                                ? []
                                : viewModel.data ?? []
                            : viewModel.producerData ?? [],
                      ),
                      onTap: () async {
                        await viewModel.onProducerTab();
                      },
                      label: StringConstants.producer),
                  TabBarModel(
                      tab: SpcbCommonTab(
                        viewModel: viewModel,
                        showNoMatchingText: viewModel.recyclerData == null,
                        data: (viewModel.searchController.text.isNotEmpty)
                            ? viewModel.state == ViewState.busy
                                ? []
                                : viewModel.data ?? []
                            : viewModel.recyclerData ?? [],
                      ),
                      onTap: () async {
                        await viewModel.onRecyclerTab();
                      },
                      label: StringConstants.recycler),
                  TabBarModel(
                      tab: SpcbCommonTab(
                        viewModel: viewModel,
                        showNoMatchingText: viewModel.retreaderData == null,
                        data: (viewModel.searchController.text.isNotEmpty)
                            ? viewModel.state == ViewState.busy
                                ? []
                                : viewModel.data ?? []
                            : viewModel.retreaderData ?? [],
                      ),
                      onTap: () async {
                        await viewModel.onRetreaderTab();
                      },
                      label: StringConstants.retreader)
                ],
              ),
            ),
          );
        },
        onModelReady: (viewModel) async {
          await viewModel.getSPCBData();
        },
        viewModel: SpcbDashboardViewModel());
  }
}
