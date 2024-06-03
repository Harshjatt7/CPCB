import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/screen_or_widegt_arguments/tab_bar_model.dart';

class AdminTabBar extends StatefulWidget {
  final List<TabBarModel> tabs;

  /// [AdminTabBar] is a widget that will be used for using tabs in the app.
  /// [tabs] will be a list of [TabBarModel] which will be used to show the list of
  /// tabs.
  const AdminTabBar({super.key, required this.tabs});

  @override
  State<AdminTabBar> createState() => _AdminTabBarState();
}

class _AdminTabBarState extends State<AdminTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: widget.tabs.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(widget.tabs.length, (index) {
              return Flexible(
                  flex: 1,
                  child: tabContainer(index, widget.tabs[index].label));
            })),
        // Tab widget to be shown here
        widget.tabs[tabController.index].tab
      ],
    );
  }

  Widget tabContainer(int index, String label) {
    return InkWell(
      onTap: () {
        tabController.index = index;
        setState(() {});
      },
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
        decoration: BoxDecoration(
            color: tabController.index == index
                ? AppColor().primaryGreen.withOpacity(0.3)
                : AppColor().white,
            border: Border.all(
                width: 1,
                color: tabController.index == index
                    ? AppColor().darkGreen
                    : AppColor().grey03),
            borderRadius: BorderRadius.circular(5)),
        child: CommonTextWidget(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: tabController.index == index
                  ? AppColor().darkGreen
                  : AppColor().black01),
        ),
      ),
    );
  }
}
