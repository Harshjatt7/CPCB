import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/views/screens/producer/dashboard_screen.dart';
import 'package:cpcb_tyre/views/screens/producer/profile_screen.dart';
import 'package:cpcb_tyre/views/screens/producer/sales_screen.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class ProducerHomeScreen extends StatefulWidget {
  const ProducerHomeScreen({super.key});

  @override
  State<ProducerHomeScreen> createState() => _ProducerHomePageState();
}

class _ProducerHomePageState extends State<ProducerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScreenWithBottomNavigationBar(bottomNavBarItems: [
      BottomNavigationBarItem(
          label: "",
          activeIcon: CommonImageWidget(
            imageColor: AppColor().darkGreen,
            imageSource: ImageConstants().homeTabIcon,
            isNetworkImage: false,
            height: 20,
            width: 20,
          ),
          icon: CommonImageWidget(
            imageSource: ImageConstants().homeTabIcon,
            isNetworkImage: false,
            imageColor: AppColor().black20,
            height: 20,
            width: 20,
          )),
      BottomNavigationBarItem(
          activeIcon: CommonImageWidget(
            imageColor: AppColor().darkGreen,
            imageSource: ImageConstants().calendarTabIcon,
            isNetworkImage: false,
            height: 20,
            width: 20,
          ),
          label: "",
          icon: CommonImageWidget(
            imageSource: ImageConstants().calendarTabIcon,
            isNetworkImage: false,
            height: 20,
            width: 20,
          )),
      BottomNavigationBarItem(
          label: "",
          activeIcon: CommonImageWidget(
            imageColor: AppColor().darkGreen,
            imageSource: ImageConstants().profileTabIcon,
            isNetworkImage: false,
            height: 20,
            width: 20,
          ),
          icon: CommonImageWidget(
            imageSource: ImageConstants().profileTabIcon,
            isNetworkImage: false,
            height: 20,
            width: 20,
          ))
    ], screens: const [
      DashBoardScreen(),
      SalesScreen(),
      ProfileScreen()
    ]);
  }
}
