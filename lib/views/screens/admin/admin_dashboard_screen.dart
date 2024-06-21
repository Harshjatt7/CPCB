import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/screen_or_widegt_arguments/tab_bar_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_producer_tab.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_recycler_tab.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_retreader_tab.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_tabbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminDashBoardViewmodel>(
        onModelReady: (viewModel) async {
          await viewModel.getAdminDashBoardData(context);
          if (context.mounted) {
            await viewModel.getEprOblications(context);
          }
          if (context.mounted) {
            await viewModel.getCommonEprOblications(context);
          }
        },
        viewModel: AdminDashBoardViewmodel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
              isLoading: viewModel.state == ViewState.busy,
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(115),
                  child: Column(
                    children: [
                      CommonAppBar(
                        isIconBar: true,
                      ),
                      Container(
                        width: Responsive().screenWidth(context),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                bottom: BorderSide(color: AppColor().black10))),
                        child: CommonTextWidget(
                          viewModel.stringConstants.dashboard,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
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
                          adminDashBoardViewmodel: viewModel,
                          producerData: viewModel.producerData,
                          producerEprOblicationsData:
                              viewModel.producerEprOblicationsData,
                        ),
                        label: StringConstants.producer),
                    TabBarModel(
                        tab: AdminRecyclerTab(
                          adminDashBoardViewmodel: viewModel,
                          recyclerData: viewModel.recyclerData,
                          recyclerCommonData:
                              viewModel.recyclerEprOblicationData,
                        ),
                        label: StringConstants.recycler),
                    TabBarModel(
                        tab: AdminRetreaderTab(
                          retreaderData: viewModel.retraderData,
                          retreaderCommonData:
                              viewModel.retreaderEprOblicationData,
                        ),
                        label: StringConstants.retreader)
                  ],
                ),
              ));
        });
  }
}
