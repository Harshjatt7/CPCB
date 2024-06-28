import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/screen_or_widegt_arguments/tab_bar_model.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_producer_tab.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_recycler_tab.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_retreader_tab.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_tabbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_components/dasboard_year_filter.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key, this.viewModel});
  final AdminDashBoardViewmodel? viewModel;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isLoading: viewModel?.state == ViewState.busy,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              CommonAppBar(
                isIconBar: true,
              ),
              DashboardYearFilter(
                hint: viewModel?.financialYearList.last,
                items: viewModel?.financialYearList,
                newValue: viewModel?.dashboardDropdownValue,
                title: viewModel?.stringConstants.dashboard,
                onChanged: (value) async {
                  viewModel?.isDashboard = true;
                  viewModel?.changeDropdownValue(value);
                  if (viewModel?.isDashboard == true) {
                    if (value != viewModel?.yearDropdownValue) {
                      await viewModel?.getEprOblications(context);
                      if (context.mounted) {
                        await viewModel?.getSummary(context);
                      }
                      if (context.mounted) {
                        await viewModel?.getCommonEprOblications(context);
                      }
                    }
                  } else {
                    await viewModel?.getSummary(context);
                  }
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CommonTabBar(
            tabs: [
              TabBarModel(
                  tab: AdminProducerTab(
                    adminDashBoardViewmodel:
                        viewModel ?? AdminDashBoardViewmodel(),
                    producerData: viewModel?.producerData,
                    producerEprOblicationsData:
                        viewModel?.producerEprOblicationsData,
                  ),
                  label: StringConstants.producer),
              TabBarModel(
                  tab: AdminRecyclerTab(
                    adminDashBoardViewmodel:
                        viewModel ?? AdminDashBoardViewmodel(),
                    recyclerData: viewModel?.recyclerData,
                    recyclerCommonData: viewModel?.recyclerEprOblicationData,
                  ),
                  label: StringConstants.recycler),
              TabBarModel(
                  tab: AdminRetreaderTab(
                    retreaderData: viewModel?.retraderData,
                    retreaderCommonData: viewModel?.retreaderEprOblicationData,
                  ),
                  label: StringConstants.retreader)
            ],
          ),
        ));
  }
}
