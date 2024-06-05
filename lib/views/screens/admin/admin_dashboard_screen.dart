import 'package:cpcb_tyre/views/screens/admin/admin_producer_tab.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:cpcb_tyre/views/widgets/components/download_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../constants/string_constant.dart';
import '../../../models/screen_or_widegt_arguments/tab_bar_model.dart';
import '../../../theme/app_color.dart';
import '../../../utils/helper/responsive_helper.dart';
import '../../widgets/app_components/admin_tabbar.dart';
import '../../widgets/components/common_appbar.dart';
import '../../widgets/components/common_text_widget.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(115),
            child: Column(
              children: [
                const CommonAppBar(
                  isIconBar: true,
                ),
                Container(
                  width: Responsive().screenWidth(context),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border(
                          bottom: BorderSide(color: AppColor().black10))),
                  child: CommonTextWidget(
                    StringConstants().dashboard,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AdminTabBar(
            tabs: [
              TabBarModel(
                  tab: const AdminProducerTab(),
                  label: StringConstants.producer),
              TabBarModel(
                  tab: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0)),
                            ),
                            constraints: BoxConstraints(
                                minWidth: Responsive().screenWidth(context)),
                            builder: (context) {
                              return const DownloadBottomSheet();
                            });
                      },
                      child: demoWidgetToBeChanged(AppColor().red)),
                  label: StringConstants.recycler),
              TabBarModel(
                  tab: demoWidgetToBeChanged(AppColor().black),
                  label: StringConstants.retreader)
            ],
          ),
        ));
  }

  Container demoWidgetToBeChanged(Color color) {
    return Container(
      height: 100,
      width: double.infinity,
      color: color,
    );
  }
}
