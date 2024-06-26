import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/request/login_request_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/utils/helper/text_theme_helper.dart';
import 'package:cpcb_tyre/viewmodels/auth_viewmodels/login_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/components/common_text_form_field_widget.dart';
import '../../widgets/components/common_text_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final StringConstants stringConstants = StringConstants();
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onModelReady: (viewmodel) {
          viewmodel.getCurrentUserType(context);
        },
        builder: (context, viewmodel, child) {
          WidgetsBinding.instance.addPostFrameCallback((v) {
            viewmodel.isEnabled();
          });
          return CustomScaffold(
            isLoading: viewmodel.state == ViewState.busy,
            showAppBar: false,
            backgroundColor: appColor.white,
            resizeToBottomInset: true,
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CommonImageWidget(
                    width: Responsive().screenWidth(context),
                    height: Responsive().screenHeight(context),
                    imageSource: imageConstants.backgroundWatermark,
                    isNetworkImage: false),
                CommonSingleChildScrollView(
                    child: formSection(viewmodel, context))
              ],
            ),
          );
        });
  }

  Widget formSection(LoginViewModel viewmodel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    color: appColor.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: appColor.black10, width: 1.5)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    CommonTextWidget(
                      stringConstants.loginToYourAcc,
                      style: context.textThemeHelper.displayMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    CommonTextWidget(
                      stringConstants.enterEmailPasswordToLogin,
                      style: context.textThemeHelper.displayMedium?.copyWith(
                          color: appColor.black70, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonDropdownTextFormField(
                        labelText: stringConstants.selectUserHint,
                        dropDownItem: viewmodel.userTypes,
                        value: viewmodel.selectedUserType,
                        error: viewmodel.userTypeDropdownError,
                        onTap: () {
                          viewmodel
                              .changeDropdownValue(viewmodel.selectedUserType);
                        },
                        onChanged: (val) {
                          viewmodel.onUserTypeChanged(val);
                          viewmodel.userTypeDropdownError = null;
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonTextFormFieldWidget(
                      hintText: stringConstants.emailIdHint,
                      isMandatory: true,
                      controller: viewmodel.emailController,
                      isLastField: true,
                      validator: (val) {
                        return viewmodel.emailValidation();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonTextFormFieldWidget(
                      hintText: stringConstants.passwordHint,
                      isMandatory: true,
                      controller: viewmodel.passController,
                      isObscure: viewmodel.isObscure,
                      isLastField: true,
                      onSuffixTap: () {
                        viewmodel.isObscure = !viewmodel.isObscure;
                      },
                      isPasswordField: true,
                      // validator: (val) {
                      // return viewmodel.passValidation();
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                      onPressed: () async {
                        if (viewmodel.isBtnEnabled) {
                          if (context.mounted) {
                            await viewmodel.onLoginButtonTapped(
                                context,
                                LoginRequestModel(
                                    email: viewmodel.emailController.text,
                                    password: viewmodel.passController.text,
                                    userType: viewmodel.selectedUserType
                                        ?.toLowerCase()));
                          }
                        }
                      },
                      label: stringConstants.loginBtnLabel,
                      color: viewmodel.isBtnEnabled
                          ? appColor.darkGreen
                          : appColor.black10,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                              color: viewmodel.isBtnEnabled
                                  ? appColor.white
                                  : appColor.darkBlue60),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (viewmodel.selectedUserType?.toLowerCase() ==
                            AdminUserTypes.producer.text ||
                        viewmodel.selectedUserType?.toLowerCase() ==
                            AdminUserTypes.recycler.text ||
                        viewmodel.selectedUserType?.toLowerCase() ==
                            AdminUserTypes.retreader.text)
                      InkWell(
                        onTap: () async {
                          launchUrl(Uri.parse(APIRoutes.baseUrl +
                              APIRoutes().forgotPasswordWebUrl));
                        },
                        child: CommonTextWidget(
                          stringConstants.forgotPassLabel,
                          style: context.textThemeHelper.displayMedium
                              ?.copyWith(
                                  color: appColor.green,
                                  fontWeight: FontWeight.w600),
                        ),
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
          color: appColor.white,
          shape: BoxShape.circle,
          border: Border.all(color: appColor.green60, width: 0.8)),
      child: CommonImageWidget(
          borderRadius: BorderRadius.zero,
          height: 72,
          width: 56,
          bgColor: appColor.transparent,
          imageSource: imageConstants.blueLogo,
          isNetworkImage: false),
    );
  }
}
