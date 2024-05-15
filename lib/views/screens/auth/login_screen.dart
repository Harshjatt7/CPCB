import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/utils/helper/text_theme_helper.dart';
import 'package:cpcb_tyre/viewmodels/auth_viewmodels/login_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../constants/routes_constant.dart';
import '../../widgets/components/common_text_form_field_widget.dart';
import '../../widgets/components/common_text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onModelReady: (viewmodel) {},
        builder: (context, viewmodel, child) {
          WidgetsBinding.instance.addPostFrameCallback((v) {
            viewmodel.isEnabled();
          });
          return CustomScaffold(
            showAppBar: false,
            backgroundColor: AppColor().white,
            resizeToBottomInset: false,
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CommonImageWidget(
                    width: Responsive().screenWidth(context),
                    height: Responsive().screenHeight(context),
                    imageSource: ImageConstants().backgroundWatermark,
                    isNetworkImage: false),
                formSection(viewmodel, context)
              ],
            ),
          );
        });
  }

  Positioned formSection(LoginViewModel viewmodel, BuildContext context) {
    return Positioned(
      top: 86,
      left: 16,
      right: 16,
      child: Form(
          key: viewmodel.formKey,
          child: Column(
            children: [
              logoWidget(),
              const SizedBox(
                height: 36,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: Responsive().screenWidth(context),
                decoration: BoxDecoration(
                    color: AppColor().white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor().black10, width: 1.5)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    CommonTextWidget(
                      StringConstants().loginToYourAcc,
                      style: context.textThemeHelper.displayMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    CommonTextWidget(
                      StringConstants().enterEmailPasswordToLogin,
                      style: context.textThemeHelper.displayMedium?.copyWith(
                          color: AppColor().black70,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonDropdownTextFormField(
                        labelText: StringConstants().selectUserHint,
                        dropDownItem: viewmodel.userTypes,
                        value: viewmodel.selectedUserType,
                        onChanged: (val) {
                          viewmodel.onUserTypeChanged(val);
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonTextFormFieldWidget(
                      hintText: StringConstants().emailIdHint,
                      isMandatory: true,
                      controller: viewmodel.emailController,
                      validator: (val) {
                        if (viewmodel.emailController.text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonTextFormFieldWidget(
                      hintText: StringConstants().passwordHint,
                      isMandatory: true,
                      controller: viewmodel.passController,
                      isObscure: viewmodel.isObscure,
                      onSuffixTap: () {
                        viewmodel.isObscure = !viewmodel.isObscure;
                      },
                      isPasswordField: true,
                      validator: (val) {
                        if (viewmodel.passController.text.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                      onPressed: () {
                        if (viewmodel.formKey.currentState?.validate() ??
                            false) {
                          Navigator.pushNamed(
                              context, AppRoutes.producerHomeScreenRoute);
                        }
                      },
                      label: StringConstants().loginBtnLabel,
                      color: viewmodel.isBtnEnabled
                          ? AppColor().darkGreen
                          : AppColor().black10,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                              color: viewmodel.isBtnEnabled
                                  ? AppColor().white
                                  : AppColor().darkBlue60),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CommonTextWidget(
                      StringConstants().forgotPassLabel,
                      style: context.textThemeHelper.displayMedium?.copyWith(
                          color: AppColor().green, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              )
            ],
          )),
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
          border: Border.all(color: AppColor().green60, width: 0.8)),
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
