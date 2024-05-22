import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
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
  const ProfileScreen({super.key});

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
                      StringConstants().profileTitle,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  detailContainer(context,
                      title: viewModel.data?.name ?? '',
                      email: viewModel.data?.email ?? '',
                      phoneNo: viewModel.data?.mobileNumber ?? ''),
                  detailContainer(context,
                      title: StringConstants().authorizedPersonDetails,
                      email: viewModel.data?.authorizedPersonName ?? '',
                      phoneNo: viewModel.data?.authorizedcontactNumber ?? '')
                ],
              ),
            ),
            persistentFooterButtons: [
              CommonButtonWidget(
                label: StringConstants().logOut,
                color: AppColor().darkGreen,
                onPressed: () {
                  viewModel.clearAppData(context);
                },
              )
            ],
          );
        });
  }

  Padding detailContainer(BuildContext context,
      {required String title, required String email, required String phoneNo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: Responsive().screenHeight(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: AppColor().green10),
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
                    StringConstants().emailId,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColor().black01),
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
                  StringConstants().mobileNumber,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: AppColor().black01),
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
