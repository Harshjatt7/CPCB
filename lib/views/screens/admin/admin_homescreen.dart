import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/views/screens/common_screens/profile_screen.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';
import '../../widgets/components/common_image_widget.dart';
import 'admin_dashboard_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreenWithBottomNavigationBar(
      bottomNavBarItems: [
        bottomNavigationBarWidget(imgSrc: ImageConstants().homeTabIcon),
        bottomNavigationBarWidget(imgSrc: ImageConstants().profileTabIcon)
      ],
      screens: [
        const AdminDashboardScreen(),
        ProfileScreen(
          isAdmin: true,
        )
      ],
    );
  }

  BottomNavigationBarItem bottomNavigationBarWidget({
    required String imgSrc,
  }) =>
      BottomNavigationBarItem(
          label: "",
          activeIcon: CommonImageWidget(
              height: 20,
              width: 20,
              imageColor: AppColor().darkGreen,
              imageSource: imgSrc,
              isNetworkImage: false),
          icon: CommonImageWidget(
              height: 20,
              width: 20,
              imageColor: AppColor().black20,
              imageSource: imgSrc,
              isNetworkImage: false));
}
