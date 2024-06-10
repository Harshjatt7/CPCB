import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/common_viewmodel/profile_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_single_child_scrollview.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final bool? isAdmin;
  final ImageConstants imageConstants = ImageConstants();
  final AppColor appColor = AppColor();
  ProfileScreen({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (viewModel) async {
          await viewModel.getProfileData();
        },
        viewModel: ProfileViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
            isLoading: viewModel.state == ViewState.busy,
            appBar: CommonAppBar(
              isIconBar: true,
            ),
            body: CommonSingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: Responsive().screenWidth(context),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border(
                            bottom: BorderSide(color: appColor.black10))),
                    child: CommonTextWidget(
                      viewModel.stringConstants.profileTitle,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  detailContainer(context, viewModel,
                      title: isAdmin == true
                          ? viewModel.data?.email ?? ""
                          : viewModel.data?.name ?? "",
                      designation:
                          isAdmin == true ? viewModel.data?.name : null,
                      email: isAdmin == true
                          ? viewModel.data?.companyEmail ?? ""
                          : viewModel.data?.email ?? "",
                      phoneNo: viewModel.data?.mobileNumber ?? "",
                      isAdmin: isAdmin,
                      name: isAdmin == true ? viewModel.data?.email : null),
                  if (isAdmin == false)
                    detailContainer(context, viewModel,
                        backgroundColor: appColor.darkBlue10,
                        borderColor: appColor.black20,
                        title:
                            viewModel.stringConstants.authorizedPersonDetails,
                        email: viewModel.data?.authorizedPersonEmailId ?? "",
                        phoneNo: viewModel.data?.authorizedcontactNumber ?? ""),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: ProducerListTile(
                  //     isBackgroundIcon: true,
                  //       image: imageConstants.person,
                  //       title: stringConstants.userType,
                  //       subtitle: viewModel.data?.userType ?? ""),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: ProducerListTile(
                  //     isBackgroundIcon: true,
                  //       image: imageConstants.passKey,
                  //       title: stringConstants.currentStatus,
                  //       subtitle: viewModel.data?.state ?? ""),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CommonButtonWidget(
                      label: viewModel.stringConstants.logOut,
                      color: appColor.darkGreen,
                      onPressed: () {
                        viewModel.clearAppData(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Padding detailContainer(BuildContext context, ProfileViewModel viewModel,
      {required String title,
      required String email,
      required String phoneNo,
      Color? backgroundColor,
      Color? borderColor,
      bool? isAdmin = false,
      String? name,
      String? designation}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: Responsive().screenHeight(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? appColor.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: backgroundColor ?? appColor.green10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              isAdmin == true ? name ?? "" : title,
              useLocalization: false,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: appColor.black01),
            ),
            if (isAdmin == true)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    CommonTextWidget(
                      viewModel.stringConstants.designation,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: appColor.black01),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CommonTextWidget(
                      designation ?? "",
                      useLocalization: false,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: appColor.black01),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                children: [
                  CommonImageWidget(
                      imageSource: imageConstants.mail, isNetworkImage: false),
                  const SizedBox(
                    width: 8,
                  ),
                  CommonTextWidget(
                    viewModel.stringConstants.emailId,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: appColor.black01),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CommonTextWidget(
                    email,
                    useLocalization: false,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: appColor.black01),
                  ),
                ],
              ),
            ),
            if (isAdmin == false)
              Row(
                children: [
                  CommonImageWidget(
                      imageSource: imageConstants.phoneNo,
                      isNetworkImage: false),
                  const SizedBox(
                    width: 8,
                  ),
                  CommonTextWidget(
                    viewModel.stringConstants.mobileNumber,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: appColor.black01),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CommonTextWidget(
                    phoneNo,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: appColor.black01),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
