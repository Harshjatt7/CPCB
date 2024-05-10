import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/responsive_helper.dart';
import 'package:cpcb_tyre/viewmodels/producer_viewmodels/profile_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
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
        onModelReady: (viewModel) {},
        viewModel: ProfileViewModel(),
        builder: (context, viewModel, child) {
          return CustomScaffold(
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
                              bottom:
                                  BorderSide(color: AppColor().appBarBorder))),
                      child: CommonTextWidget(
                        'Profile',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: Responsive().screenHeight(context),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            color: AppColor().greenEAF4EA),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              'Rajendra Kumar Sahu',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: AppColor().profileBlackPrimary),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  CommonImageWidget(
                                      imageSource: ImageConstants().mail,
                                      isNetworkImage: false),
                                  CommonTextWidget(
                                    'Email ID:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color:
                                                AppColor().profileBlackPrimary),
                                  ),
                                  CommonTextWidget(
                                    'rks@grid-india.in',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color:
                                                AppColor().profileBlackPrimary),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                CommonImageWidget(
                                    imageSource: ImageConstants().phoneNo,
                                    isNetworkImage: false),
                                CommonTextWidget(
                                  'Mobile Number:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color:
                                              AppColor().profileBlackPrimary),
                                ),
                                CommonTextWidget(
                                  '+91 9999012345',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color:
                                              AppColor().profileBlackPrimary),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
