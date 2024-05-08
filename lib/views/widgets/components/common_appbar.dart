import 'package:cpcb_tyre/views/widgets/app_components/common_icon_appbar.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_profile_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

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
  ///
  /// [actions] will take list of widgets, add the corresponding action [VoidCallback] while sending the widgets.
  ///
  /// [appBarHeight] will take height of appbar, if not given it will use 70.
  ///
  /// [isIconBar] will take boolen value for [IconAppBar] widget
  ///
  /// [isProfileBar] will take boolen value for [ProfileAppBar] widget and [name],[image],[designation] are manually have to be added if true
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
          ? ProfileAppBar(
              image: image ?? '',
              designation: designation ?? '',
              name: name ?? '')
          : isIconBar == true
              ? const IconAppBar()
              : normalAppBar(context),
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
            onTap: () {
              Navigator.pop(context);
            },
            child: CommonImageWidget(
              imageSource: leadingIcon ?? "",
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
