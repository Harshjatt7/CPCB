import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_components/admin_summary_card.dart';
import '../../widgets/app_components/dasboard_year_filter.dart';
class AdminSummaryScreen extends StatelessWidget {
  const AdminSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminDashBoardViewmodel>(
        builder: (context, viewModel, child) {
          return CustomScaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Column(
                  children: [
                    CommonAppBar(
                      isIconBar: true,
                    ),
                       DashboardYearFilter(viewModel: viewModel,value: viewModel.financialYearList.first,),
                  ],
                ),
              ),
              body: const CommonSingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AdminSummaryCard(
                        label: "Producer",
                        userType:StringConstants.producer,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AdminSummaryCard(
                        label: "Recycler",
                        userType: StringConstants.recycler,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AdminSummaryCard(
                        label: "Retreader",
                        userType: StringConstants.retreader,
                      ),
                    ],
                  ),
                ),
              ));
        },
        onModelReady: (viewModel) {},
        viewModel: AdminDashBoardViewmodel());
  }
}

