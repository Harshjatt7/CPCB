import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/common_viewmodel/dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/screens/common_screens/dashboard_screen.dart';
import 'package:cpcb_tyre/views/screens/common_screens/profile_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/procurement_data_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/retreader_data_screen.dart';
import 'package:cpcb_tyre/views/widgets/components/common_bottom_navigation_bar_screen_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:flutter/material.dart';

class RetraderHomeScreen extends StatelessWidget {
  RetraderHomeScreen({
    super.key,
  });

  final ImageConstants imageConstants = ImageConstants();

  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
        builder: (context, viewModel, child) {
          return homeScreenView(context, viewModel);
        },
        onModelReady: (viewModel) async {
          viewModel.getCurrentUserType(context);
          await viewModel.getDasboardData(context);
        },
        viewModel: DashboardViewModel());
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
      if (viewModel.isRegistered == true) ProcurementDataScreen(),
      if (viewModel.isRegistered == true) RetreaderDataScreen(),
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
