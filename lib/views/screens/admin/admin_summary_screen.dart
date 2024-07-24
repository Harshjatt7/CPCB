import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../constants/enums/state_enums.dart';
import '../../widgets/app_components/admin_summary_card.dart';
import '../../widgets/app_components/dasboard_year_filter.dart';

class AdminSummaryScreen extends StatelessWidget {
  const AdminSummaryScreen({super.key, this.viewModel});

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
              title: viewModel?.stringConstants.dashboard,
              hint: viewModel?.yearDropdownValue,
              items: viewModel?.financialYearList,
              newValue: viewModel?.summaryDropdownValue,
              onChanged: (value) async {
                viewModel?.isDashboard = false;
                viewModel?.changeDropdownValue(value);
                if (value != viewModel?.yearDropdownValue) {
                  await viewModel?.getSummary(context);
                }
              },
            ),
          ],
        ),
      ),
      body: CommonSingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AdminSummaryCard(
                label: StringConstants.producer,
                eprObligations: viewModel
                    ?.summaryData?.producer?.totalEprObligation
                    .toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              AdminSummaryCard(
                label: StringConstants.recycler,
                creditsGenerated:
                    viewModel?.summaryData?.recycler?.earnedCredit.toString(),
                creditsTransferred:
                    viewModel?.summaryData?.recycler?.earnedCredit.toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              AdminSummaryCard(
                label: StringConstants.retreader,
                creditsGenerated:
                    viewModel?.summaryData?.retreader?.totalCredit.toString(),
                creditsTransferred: viewModel
                    ?.summaryData?.retreader?.creditTransfered
                    .toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
