import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class CommonScreenWithBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> bottomNavBarItems;
  final List<Widget> screens;
  
  const CommonScreenWithBottomNavigationBar(
      {super.key, required this.bottomNavBarItems, required this.screens});

  @override
  State<CommonScreenWithBottomNavigationBar> createState() =>
      CommonScreenWithBottomNavigationBarState();
      static CommonScreenWithBottomNavigationBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<CommonScreenWithBottomNavigationBarState>();


}



class CommonScreenWithBottomNavigationBarState
    extends State<CommonScreenWithBottomNavigationBar> {

      @override
      void initState() {
    selectedIndex = MaterialAppViewModel.selectedPageIndex;
    super.initState();
  }
 int pageIndex = 0;

  int? selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showAppBar: false,
        bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            onTap: onItemTapped,
            currentIndex: selectedIndex ?? 0,
            items: widget.bottomNavBarItems),
        body: IndexedStack(
          index: selectedIndex,
          children: widget.screens,
        ));
  }
}
