import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/spcb/spcb_producer_tab.dart';
import 'package:cpcb_tyre/views/screens/spcb/spcb_recycler_tab.dart';
import 'package:cpcb_tyre/views/screens/spcb/spcb_retreader_tab.dart';
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
                          // viewModel.searchProcurement(value);
                          if (viewModel.searchController.text.isEmpty) {
                            // viewModel.getUpdatedList();
                          }
                        },
                        title: stringConstants.spcbDashboard,
                        onSuffixTap: () {
                          if (viewModel.searchController.text.isEmpty) {
                            viewModel.isSearchExpanded =
                                !viewModel.isSearchExpanded;
                            // viewModel.getUpdatedList();
                            viewModel.updateUI();
                          } else {
                            viewModel.isSearchExpanded = false;
                            // viewModel.getUpdatedList();
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
                tabs: [
                  TabBarModel(
                      tab: SpcbProducerTab(
                        spcbViewModel: viewModel,
                      ), label: StringConstants.producer
                      ),
                  TabBarModel(
                      tab: SpcbRecyclerTab(
                         spcbViewModel: viewModel,
                      ),
                      label: StringConstants.recycler),
                  TabBarModel(
                      tab: SpcbRetreaderTab(
                         spcbViewModel: viewModel,
                      ),
                      label: StringConstants.retreader)
                ],
              ),
            ),
          );
        },
        onModelReady: (viewModel) {
          
        },
        viewModel: SpcbDashboardViewModel());
  }
}
