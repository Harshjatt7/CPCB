import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/viewmodels/common_viewmodel/dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/common_screens/dashboard_screen.dart';
import 'package:cpcb_tyre/views/screens/common_screens/profile_screen.dart';
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
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      viewModel: DashboardViewModel(),
      onModelReady: (viewModel) async {
        viewModel.getCurrentUserType(context);
        await viewModel.getDasboardData(context);
      },
      builder: (context, viewModel, child) {
        return homeScreenView(context, viewModel);
      },
    );
  }

  CommonScreenWithBottomNavigationBar homeScreenView(
      BuildContext context, DashboardViewModel viewModel) {
    return CommonScreenWithBottomNavigationBar(bottomNavBarItems: [
      bottomNavigationBarWidget(
        imgSrc: imageConstants.homeTabIcon,
      ),
      if (viewModel.isRegistered == true)
        bottomNavigationBarWidget(
          imgSrc: imageConstants.addSlaesDataIcon,
        ),
      bottomNavigationBarWidget(
        imgSrc: imageConstants.profileTabIcon,
      )
    ], screens: [
      const DashBoardScreen(),
      if (viewModel.isRegistered == true) SalesScreen(),
      ProfileScreen()
    ]);
  }

  BottomNavigationBarItem bottomNavigationBarWidget({
    required String imgSrc,
  }) =>
      BottomNavigationBarItem(
          label: "",
          activeIcon: CommonImageWidget(
              height: 20,
              width: 20,
              imageColor: appColor.darkGreen,
              imageSource: imgSrc,
              isNetworkImage: false),
          icon: CommonImageWidget(
              height: 20,
              width: 20,
              imageColor: appColor.black20,
              imageSource: imgSrc,
              isNetworkImage: false));
}
