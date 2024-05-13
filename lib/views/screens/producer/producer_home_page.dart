import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/views/screens/producer/dashboard_page.dart';
import 'package:cpcb_tyre/views/screens/producer/profile_screen.dart';
import 'package:cpcb_tyre/views/screens/producer/sales_screen.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class ProducerHomePage extends StatefulWidget {
  const ProducerHomePage({super.key});

  @override
  State<ProducerHomePage> createState() => _ProducerHomePageState();
}

class _ProducerHomePageState extends State<ProducerHomePage> {
  @override
  Widget build(BuildContext context) {
    return CommonScreenWithBottomNavigationBar(bottomNavBarItems: [
      BottomNavigationBarItem(
          label: "",
          activeIcon: CommonImageWidget(
            imageColor: AppColor().green2E9331,
            imageSource: ImageConstants().homeTabIcon,
            isNetworkImage: false,
            height: 20,
            width: 20,
          ),
          icon: CommonImageWidget(
            imageSource: ImageConstants().homeTabIcon,
            isNetworkImage: false,
            imageColor: AppColor().greyLight,
            height: 20,
            width: 20,
          )),
      BottomNavigationBarItem(
          activeIcon: CommonImageWidget(
            imageColor: AppColor().green2E9331,
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
            imageColor: AppColor().green2E9331,
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
      DashBoardPage(),
      SalesScreen(),
      ProfileScreen()
    ]);
  }
}
