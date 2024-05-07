import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/utils/helper/text_theme_helper.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppBar: false,
      backgroundColor: AppColor().white,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CommonImageWidget(
                //imageColor: AppColor().black,
                //bgColor: AppColor().black,
                width: Responsive().screenWidth(context),
                height: Responsive().screenHeight(context),
                imageSource: ImageConstants().backgroundWatermark,
                isNetworkImage: false),
            Positioned(
              top: 86,
              left: 16,
              right: 16,
              child: Form(
                  child: Column(
                children: [
                  logoWidget(),
                  const SizedBox(
                    height: 36,
                  ),
                  // TODO: To be used when common text field is created
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   width: Responsive().screenWidth(context),
                  //   decoration: BoxDecoration(
                  //       color: AppColor().white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(
                  //           color: AppColor().borderColor, width: 1.5)),
                  //   child: Column(
                  //     children: [
                  //       const SizedBox(
                  //         height: 24,
                  //       ),
                  //       CommonTextWidget(
                  //         "Login to your account",
                  //         style: context.textThemeHelper.displayMedium
                  //             ?.copyWith(fontWeight: FontWeight.w600),
                  //       ),
                  //       const SizedBox(
                  //         height: 4,
                  //       ),
                  //       CommonTextWidget(
                  //         "Enter Email and password to sign in.",
                  //         style: context.textThemeHelper.displayMedium
                  //             ?.copyWith(
                  //                 color: AppColor().deepGreyTextColor,
                  //                 fontWeight: FontWeight.w400),
                  //       ),
                  //       const SizedBox(
                  //         height: 16,
                  //       ),
                  //       textFormField(),
                  //       const SizedBox(
                  //         height: 16,
                  //       ),
                  //       textFormField(),
                  //       const SizedBox(
                  //         height: 16,
                  //       ),
                  //       textFormField(),
                  //       const SizedBox(
                  //         height: 16,
                  //       ),
                  //       textFormField(),
                  //       const SizedBox(
                  //         height: 16,
                  //       ),
                  //       Container(
                  //         height: 50,
                  //         width: double.infinity,
                  //         color: AppColor().black,
                  //       ),
                  //       const SizedBox(
                  //         height: 12,
                  //       ),
                  //       CommonTextWidget(
                  //         "I forgot my password",
                  //         style: context.textThemeHelper.displayMedium
                  //             ?.copyWith(
                  //                 color: AppColor().textGreen,
                  //                 fontWeight: FontWeight.w600),
                  //       ),
                  //       const SizedBox(
                  //         height: 24,
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  TextFormField textFormField() {
    return TextFormField(
      cursorColor: AppColor().primaryGreen,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: AppColor().borderColor, width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: AppColor().borderColor, width: 1.5)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor().borderColor))),
    );
  }

  Container logoWidget() {
    return Container(
      height: 106,
      width: 106,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColor().white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColor().primaryGreen, width: 0.8)),
      child: CommonImageWidget(
          borderRadius: BorderRadius.zero,
          height: 72,
          width: 56,
          bgColor: AppColor().transparent,
          imageSource: ImageConstants().blueLogo,
          isNetworkImage: false),
    );
  }
}
