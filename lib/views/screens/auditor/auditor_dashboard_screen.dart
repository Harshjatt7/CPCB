import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../viewmodels/auditor/auditor_dashboard_view_model.dart';
import '../../widgets/app_components/common_end_product.dart';
import '../../widgets/app_components/common_title_bar.dart';
import '../../widgets/app_components/common_total_application_card.dart';
import '../../widgets/components/common_appbar.dart';

class AuditorDashboardScreen extends StatelessWidget {
  AuditorDashboardScreen({super.key});
  final StringConstants stringConstants = StringConstants();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuditorDashboardViewModel>(
        onModelReady: (viewModel) async {
          await viewModel.getDasboardData(context);
        },
        viewModel: AuditorDashboardViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
            isLoading: viewModel.state == ViewState.busy,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(125),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonAppBar(
                      isIconBar: true,
                      showNotificationIcon: false,
                    ),
                    CommonTitleBar(title: viewModel.stringConstants.dashboard)
                  ],
                ),
              ),
            ),
            body: CommonSingleChildScrollView(
              child: Column(
                children: [
                  CommonTotalApplicationCard(
                    totalApplication: '${viewModel.data?.total ?? ''}',
                    isAuditor: true,
                    onTap: () {
                      CommonScreenWithBottomNavigationBar.of(context)
                          ?.onItemTapped(1);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(stringConstants.application),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonEndProduct(
                          title: viewModel.stringConstants.totalAudits,
                          generated: "",
                          transferred: "${viewModel.data?.total ?? ''}",
                        ),
                        CommonEndProduct(
                          title: stringConstants.auditsStart,
                          generated: "",
                          transferred: "${viewModel.data?.started ?? ''}",
                        ),
                        CommonEndProduct(
                          title: stringConstants.pendingAudits,
                          generated: "",
                          transferred: "${viewModel.data?.pending ?? ''}",
                        ),
                        CommonEndProduct(
                          title: stringConstants.completedAudits,
                          generated: "",
                          transferred: "${viewModel.data?.completed ?? ''}",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
