import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
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
    return CustomScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List<Widget>.generate(widget.tabs.length, (index) {
                  return Flexible(
                      flex: 1,
                      child: Padding(
                        padding: index == (widget.tabs.length - 1)
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(right: 8),
                        child: tabContainer(index, widget.tabs[index].label, onTapped: widget.tabs[index].onTap),
                      ));
                })),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      body: CommonSingleChildScrollView(
        child: Column(
          children: [
            widget.tabs[tabController.index].tab,
          ],
        ),
      ),
    );
  }

  Widget tabContainer(int index, String label, {VoidCallback? onTapped}) {
    return InkWell(
      onTap: () {
        tabController.index = index;
         if (onTapped != null) {
          onTapped();
        }
        setState(() {});
       
      },
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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
