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
  final bool? showNotificationIcon;
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
  /// [showNotificationIcon] will take boolen value to show/hide notification icon from Icon App Bar.
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
      this.showNotificationIcon = false,
      this.appBarHeight = 70});

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: showNotificationIcon == true || isIconBar == true
          ? iconAppBar()
          : normalAppBar(context),
    );
  }

  Widget profileAppBar(BuildContext context,
      {required String image,
      required String designation,
      required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonImageWidget(
              height: 44,
              width: 34,
              imageSource: ImageConstants().blueLogo,
              isNetworkImage: false),
        ),
        const Spacer(),
        Center(
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor().black20, width: 1)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
              child: CommonImageWidget(
                  height: 38,
                  width: 38,
                  fit: BoxFit.contain,
                  imageSource: image,
                  isNetworkImage: false),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: CommonTextWidget(name,
                    style: Theme.of(context).textTheme.bodyLarge!),
              ),
              CommonTextWidget(designation,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor().darkBlue60,
                      )),
            ],
          ),
        ),
      ],
    );
  }

  Widget iconAppBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor().black10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            CommonImageWidget(
                height: 44,
                width: 34,
                imageSource: ImageConstants().blueLogo,
                isNetworkImage: false),
            if (showNotificationIcon == false) const Spacer(),
            if (showNotificationIcon == false)
              CommonImageWidget(
                  height: 24,
                  width: 24,
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
          border: Border(bottom: BorderSide(color: AppColor().black10))),
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
                ?.copyWith(color: AppColor().codGrey),
          ),
        ],
      ),
    );
  }
}
