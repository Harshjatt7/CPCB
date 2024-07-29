import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/onborading/splash_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        onModelReady: (viewmodel) async {
          //await viewmodel.initPlatformState(context);
          await viewmodel.wait(context);
        },
        viewModel: SplashViewModel(),
        builder: (context, viewmodel, child) {
          // TODO: root detection disabled
          // WidgetsBinding.instance.addPostFrameCallback((value) {
          //   if (viewmodel.isJailbroken == true) {
          //     showDialog(
          //         barrierDismissible: false,
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AlertDialog(
          //             scrollable: true,
          //             backgroundColor: AppColor().transparent,
          //             insetPadding: const EdgeInsets.symmetric(
          //               horizontal: 12,
          //             ),
          //             content: SuccessFailedDialog(
          //               giveStaticDialogHeight: false,
          //               description: MessageConstant().rootedDeviceDesc,
          //               title: MessageConstant().rootedDeviceDetected,
          //               buttonText: "OK",
          //               titleStyle: Theme.of(context).textTheme.headlineSmall,
          //               onTap: () {
          //                 // Close the app on okay button
          //                 SystemChannels.platform
          //                     .invokeMethod('SystemNavigator.pop');
          //               },
          //             ),
          //           );
          //         });

          //   }
          // });

          return CustomScaffold(
              showAppBar: false,
              body: Container(
                alignment: Alignment.center,
                height: Responsive().screenHeight(context),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [appColor.primaryGreen, appColor.darkGreen])),
                child: CommonImageWidget(
                    height: 150,
                    width: 115,
                    bgColor: appColor.transparent,
                    imageSource: ImageConstants().splashScreenLogo,
                    isNetworkImage: false),
              ));
        });
  }
}
