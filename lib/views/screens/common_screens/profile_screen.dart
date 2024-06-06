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

import '../../../constants/string_constant.dart';

class ProfileScreen extends StatelessWidget {
  final bool? isAdmin;
  ProfileScreen({super.key, this.isAdmin = false});
  final StringConstants stringConstants = StringConstants();

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
            appBar: const CommonAppBar(
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
                            bottom: BorderSide(color: AppColor().black10))),
                    child: CommonTextWidget(
                      viewModel.stringConstants.profileTitle,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  detailContainer(context, viewModel,
                      title: viewModel.data?.name ?? '',
                      email: viewModel.data?.email ?? '',
                      phoneNo: viewModel.data?.mobileNumber ?? ''),
                  if (isAdmin == false)
                    detailContainer(context, viewModel,
                        backgroundColor: AppColor().darkBlue10,
                        borderColor: AppColor().black20,
                        title:
                            viewModel.stringConstants.authorizedPersonDetails,
                        email: viewModel.data?.authorizedPersonEmailId ?? '',
                        phoneNo: viewModel.data?.authorizedcontactNumber ?? ''),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: ProducerListTile(
                  //     isBackgroundIcon: true,
                  //       image: ImageConstants().person,
                  //       title: stringConstants.userType,
                  //       subtitle: viewModel.data?.userType ?? ""),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: ProducerListTile(
                  //     isBackgroundIcon: true,
                  //       image: ImageConstants().passKey,
                  //       title: stringConstants.currentStatus,
                  //       subtitle: viewModel.data?.state ?? ""),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CommonButtonWidget(
                      label: viewModel.stringConstants.logOut,
                      color: AppColor().darkGreen,
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
      Color? borderColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: Responsive().screenHeight(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? AppColor().transparent),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: backgroundColor ?? AppColor().green10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: AppColor().black01),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  CommonImageWidget(
                      imageSource: ImageConstants().mail,
                      isNetworkImage: false),
                  const SizedBox(
                    width: 8,
                  ),
                  CommonTextWidget(
                    viewModel.stringConstants.emailId,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColor().black01),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CommonTextWidget(
                    email,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor().black01),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CommonImageWidget(
                    imageSource: ImageConstants().phoneNo,
                    isNetworkImage: false),
                const SizedBox(
                  width: 8,
                ),
                CommonTextWidget(
                  viewModel.stringConstants.mobileNumber,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: AppColor().black01),
                ),
                const SizedBox(
                  width: 4,
                ),
                CommonTextWidget(
                  phoneNo,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColor().black01),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
