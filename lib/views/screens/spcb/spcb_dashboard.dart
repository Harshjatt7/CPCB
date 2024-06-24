import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/spcb/spcb_producer_tab.dart';
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
                onScrollEnding: () {
                          viewModel.onScrollEnding();
                        },
                tabs: [
                  TabBarModel(
                      tab: SpcbProducerTab(
                        viewModel: viewModel,
                        onScrollEnding: () {
                          viewModel.onScrollEnding();
                        },
                        scrollController: viewModel.scrollController,
                        data: (viewModel.searchController.text.isNotEmpty) ? viewModel.data ?? [] : viewModel.producerData ?? [],
                      ),
                      onTap: () async {
                        viewModel.currentUserType = AdminUserTypes.producer;
                        if (viewModel.searchController.text.isEmpty) {
                          if (viewModel.producerData?.isEmpty == true ||
                              viewModel.producerData == null) {
                            await viewModel.getSPCBData();
                          } else {
                            viewModel.data = viewModel.producerData;
                            

                          }
                        } else {
                          await viewModel
                              .searchSPCB(viewModel.searchController.text);


                          viewModel.getUpdatedList();
                        }
                        viewModel.updateUI();
                      },
                      label: StringConstants.producer),
                  TabBarModel(
                      tab: SpcbProducerTab(
                        viewModel: viewModel,
                        onScrollEnding: () {
                          viewModel.onScrollEnding();
                        },
                        scrollController: viewModel.scrollController,
                        data:(viewModel.searchController.text.isNotEmpty) ? viewModel.data ?? [] : viewModel.recyclerData ?? [],
                      ),
                      onTap: () async {
                        viewModel.currentUserType = AdminUserTypes.recycler;

                        if (viewModel.searchController.text.isEmpty) {
                          if (viewModel.recyclerData?.isEmpty == true ||
                              viewModel.recyclerData == null) {
                            await viewModel.getSPCBData();
                          } else {
                            viewModel.data = viewModel.recyclerData;
                          }
                        } else {
                          await viewModel
                              .searchSPCB(viewModel.searchController.text);

                          viewModel.getUpdatedList();
                        }

                        viewModel.updateUI();
                      },
                      label: StringConstants.recycler),
                  TabBarModel(
                      tab: SpcbProducerTab(
                        viewModel: viewModel,
                        onScrollEnding: () {
                          viewModel.onScrollEnding();
                        },
                        scrollController: viewModel.scrollController,
                        data:(viewModel.searchController.text.isNotEmpty) ? viewModel.data ?? [] : viewModel.retreaderData ?? [],
                      ),
                      onTap: () async {
                        viewModel.currentUserType = AdminUserTypes.retreader;

                        if (viewModel.searchController.text.isEmpty) {
                          if (viewModel.retreaderData?.isEmpty == true ||
                              viewModel.retreaderData == null) {
                            await viewModel.getSPCBData();
                          } else {
                            viewModel.data = viewModel.retreaderData;
                          }
                        } else {
                          await viewModel
                              .searchSPCB(viewModel.searchController.text);
                          viewModel.getUpdatedList();
                        }
                        viewModel.updateUI();
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
