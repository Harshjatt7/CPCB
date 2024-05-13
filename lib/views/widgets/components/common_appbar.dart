import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../theme/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingIcon;
  final VoidCallback? onLeadingTapped;
  final List<Widget>? actions;
  final double? appBarHeight;
  final bool? isIconBar;
  final bool? isProfileBar;
  final String? image;
  final String? name;
  final String? designation;

  /// [CommonAppBar] will be used as the common appbar in this project.
  ///
  /// [title] is optional field to use this widget.
  ///
  /// [leadingIcon] is optional, and can be used if any other widget is needed, instead it will use a
  /// default chevron icon, which will pop current screen if tapped.
  /// else [onLeadingTapped] can be used if a custom action is required.
  ///
  /// [actions] will take list of widgets, add the corresponding action [VoidCallback] while sending the widgets.
  ///
  /// [appBarHeight] will take height of appbar, if not given it will use 70.
  ///
  /// [isIconBar] will take boolen value for [iconAppBar] widget
  ///
  /// [isProfileBar] will take boolen value for [profileAppBar] widget and [name],[image],[designation] are manually have to be added if true
  ///

  const CommonAppBar(
      {super.key,
      this.title,
      this.actions,
      this.leadingIcon,
      this.onLeadingTapped,
      this.name,
      this.image,
      this.designation,
      this.isIconBar = false,
      this.isProfileBar = false,
      this.appBarHeight = 70});

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isProfileBar == true
          ? profileAppBar(context,
              image: image ?? '',
              designation: designation ?? '',
              name: name ?? '')
          : isIconBar == true
              ? iconAppBar()
              : normalAppBar(context),
    );
  }

  Widget profileAppBar(BuildContext context,
      {required String image,
      required String designation,
      required String name}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor().appBarBorder))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              height: 60,
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor().blackUltraLight, width: 1)),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                child: CommonImageWidget(
                    fit: BoxFit.contain,
                    imageSource: image,
                    isNetworkImage: false),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: CommonTextWidget(name,
                      style: Theme.of(context).textTheme.bodyLarge!),
                ),
                CommonTextWidget(designation,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColor().appBarSubTitleText,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconAppBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor().appBarBorder))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            CommonImageWidget(
                height: 50,
                imageSource: ImageConstants().blueLogo,
                isNetworkImage: false),
            const Spacer(),
            CommonImageWidget(
                height: 30,
                fit: BoxFit.cover,
                imageSource: ImageConstants().notification,
                isNetworkImage: false)
          ],
        ),
      ),
    );
  }

  Container normalAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor().appBarBorder))),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          InkWell(
            onTap: onLeadingTapped ??
                () {
                  Navigator.pop(context);
                },
            child: CommonImageWidget(
              imageSource: leadingIcon ?? ImageConstants().arrowBack,
              isNetworkImage: false,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          CommonTextWidget(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColor().appBarTitle),
          ),
        ],
      ),
    );
  }
}
