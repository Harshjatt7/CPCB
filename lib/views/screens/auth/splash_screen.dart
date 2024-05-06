import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/onborading/splash_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        onModelReady: (viewmodel) {
          viewmodel.wait(context);
        },
        viewModel: SplashViewModel(),
        builder: (context, viewmodel, child) {
          return CustomScaffold(
              showAppBar: false,
              body: Container(
                alignment: Alignment.center,
                height: Responsive().screenHeight(context),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      AppColor().primaryGreen,
                      AppColor().primaryGreen1
                    ])),
                child: CommonImageWidget(
                    height: 150,
                    width: 115,
                    bgColor: AppColor().transparent,
                    imageSource: ImageConstants().splashScreenLogo,
                    isNetworkImage: false),
              ));
        });
  }
}
