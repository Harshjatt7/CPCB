import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/screens/producer/profile_screen.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:flutter/material.dart';

class RetraderHomePage extends StatelessWidget {
  const RetraderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreenWithBottomNavigationBar(bottomNavBarItems: [
      bottomNavigationBarWidget(
          imgColor: AppColor().darkGreen,
          imgSrc: ImageConstants().homeTabIcon,
          inactiveColor: AppColor().black20),
      bottomNavigationBarWidget(
          imgColor: AppColor().darkGreen,
          imgSrc: ImageConstants().calendarTabIcon,
          inactiveColor: AppColor().black20),
      bottomNavigationBarWidget(
          imgColor: AppColor().darkGreen,
          imgSrc: ImageConstants().notificationTabIcon,
          inactiveColor: AppColor().black20),
      bottomNavigationBarWidget(
          imgColor: AppColor().darkGreen,
          imgSrc: ImageConstants().profileTabIcon,
          inactiveColor: AppColor().black20)
    ], screens: [
      Container(),
      Container(),
      Container(),
      const ProfileScreen()
    ]);
  }

  BottomNavigationBarItem bottomNavigationBarWidget(
          {required String imgSrc,
          required Color imgColor,
          required Color inactiveColor}) =>
      BottomNavigationBarItem(
          label: "",
          activeIcon: CommonImageWidget(
              height: 20,
              width: 20,
              imageColor: imgColor,
              imageSource: imgSrc,
              isNetworkImage: false),
          icon: CommonImageWidget(
              height: 20,
              width: 20,
              imageColor: inactiveColor,
              imageSource: imgSrc,
              isNetworkImage: false));
}
