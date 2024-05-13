import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class CommonScreenWithBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> bottomNavBarItems;
  final List<Widget> screens;
  const CommonScreenWithBottomNavigationBar(
      {super.key, required this.bottomNavBarItems, required this.screens});

  @override
  State<CommonScreenWithBottomNavigationBar> createState() =>
      _CommonScreenWithBottomNavigationBarState();
}

class _CommonScreenWithBottomNavigationBarState
    extends State<CommonScreenWithBottomNavigationBar> {
  int pageIndex = 0;

  int _selectedIndex = 0;
  void onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showAppBar: false,
        bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            onTap: onItemTapped,
            currentIndex: _selectedIndex,
            items: widget.bottomNavBarItems),
        body: IndexedStack(
          index: _selectedIndex,
          children: widget.screens,
        ));
  }
}
