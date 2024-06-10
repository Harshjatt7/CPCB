import 'package:cpcb_tyre/views/screens/common_screens/profile_screen.dart';
import 'package:cpcb_tyre/views/screens/spcb/spcb_dashboard.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../theme/app_color.dart';
import '../../widgets/components/common_image_widget.dart';

class SpcbHomeScreen extends StatelessWidget {
  const SpcbHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreenWithBottomNavigationBar(bottomNavBarItems: [
      bottomNavigationBarWidget(
        imgSrc: ImageConstants().homeTabIcon,
      ),
      bottomNavigationBarWidget(
        imgSrc: ImageConstants().profileTabIcon,
      ),
    ], screens: [
      SpcbDashboardScreen(),
      ProfileScreen(),
    ]);
  }

  bottomNavigationBarWidget({required String imgSrc}) {
    return BottomNavigationBarItem(
      label: "",
      activeIcon: CommonImageWidget(
        height: 20,
        width: 20,
        imageColor: AppColor().darkGreen,
        imageSource: imgSrc,
        isNetworkImage: false,
      ),
      icon: CommonImageWidget(
        height: 20,
        width: 20,
        imageColor: AppColor().black20,
        imageSource: imgSrc,
        isNetworkImage: false,
      ),
    );
  }
}
