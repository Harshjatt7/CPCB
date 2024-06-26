import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_components/admin_summary_card.dart';
import '../../widgets/app_components/dasboard_year_filter.dart';

class AdminSummaryScreen extends StatelessWidget {
  
 AdminSummaryScreen({super.key});

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminDashBoardViewmodel>(
      onModelReady: (viewModel)async {
        
        viewModel.addYear();
await Future.delayed(Duration(seconds: 2));
isLoading = true;
viewModel.updateUI();
await Future.delayed(Duration(seconds: 2));
isLoading = false;
viewModel.updateUI();


      },
      viewModel: AdminDashBoardViewmodel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          isLoading: isLoading,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: Column(
                children: [
                  CommonAppBar(
                    isIconBar: true,
                  ),
                  DashboardYearFilter(
                    title: viewModel.stringConstants.dashboard,
                    value: viewModel.financialYearList[0],
                    items: viewModel.financialYearList,
                    newValue: viewModel.changeDropdown,
                    onChanged: (value) async {
                      viewModel.changeDropdownValue(value);
                      if (value != viewModel.yearDropdownValue) {
                        await viewModel.getEprOblications(context);
                        if (context.mounted) {
                          await viewModel.getCommonEprOblications(context);
                        }
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AdminSummaryCard(
                      label: StringConstants.recycler,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AdminSummaryCard(
                      label: StringConstants.retreader,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
