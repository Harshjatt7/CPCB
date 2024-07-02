import 'package:cpcb_tyre/viewmodels/auditor/auditor_list_view_model.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_components/common_end_product.dart';
import '../../widgets/app_components/common_title_bar.dart';
import '../../widgets/app_components/common_total_application_card.dart';
import '../../widgets/components/common_appbar.dart';

class AuditorDashboardScreen extends StatelessWidget {
  const AuditorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuditorListViewModel>(
        onModelReady: (viewModel) {},
        viewModel: AuditorListViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
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
                    totalApplication: "1,000",
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
                        const CommonTextWidget("Application"),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonEndProduct(
                          title: viewModel.stringConstants.totalAudits,
                          generated: "",
                          transferred: "1,000",
                        ),
                        const CommonEndProduct(
                          title: "Audits Start",
                          generated: "",
                          transferred: "1,000",
                        ),
                        const CommonEndProduct(
                          title: "Pending Audits",
                          generated: "",
                          transferred: "1,000",
                        ),
                        const CommonEndProduct(
                          title: "Completed Audits",
                          generated: "",
                          transferred: "1,000",
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
