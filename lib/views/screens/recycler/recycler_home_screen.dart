import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/common_viewmodel/dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/common_screens/dashboard_screen.dart';
import 'package:cpcb_tyre/views/screens/common_screens/profile_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/procurement_data_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/recycler_data_screen.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:flutter/material.dart';

class RecyclerHomeScreen extends StatelessWidget {
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();
  RecyclerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      onModelReady: (viewModel) async {
        viewModel.getCurrentUserType(context);
        await viewModel.getDasboardData(context);
      },
      viewModel: DashboardViewModel(),
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
          imgSrc: imageConstants.dbIcon,
        ),
      if (viewModel.isRegistered == true)
        bottomNavigationBarWidget(
          imgSrc: imageConstants.refreshIcon,
        ),
      bottomNavigationBarWidget(
        imgSrc: imageConstants.profileTabIcon,
      )
    ], screens: [
      const DashBoardScreen(),
      if (viewModel.isRegistered == true) RecyclerProcurementDataScreen(),
      if (viewModel.isRegistered == true) RecyclerDataScreen(),
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
