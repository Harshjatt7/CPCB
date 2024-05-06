import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../theme/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leadingIcon;
  final VoidCallback? onLeadingTapped;
  final List<Widget>? actions;
  final double? appBarHeight;

  /// [CommonAppBar] will be used as the common appbar in this project.
  ///
  /// [title] is required field to use this widget.
  ///
  /// [leadingIcon] is optional, and can be used if any other widget is needed, instead it will use a
  /// default chevron icon, which will pop current screen if tapped.
  ///
  /// [actions] will take list of widgets, add the corresponding action [VoidCallback] while sending the widgets.
  ///
  /// [appBarHeight] will take height of appbar, if not given it will use 48.

  const CommonAppBar(
      {super.key,
      required this.title,
      this.actions,
      this.leadingIcon,
      this.onLeadingTapped,
      this.appBarHeight = 48});

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 48);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                child: CommonImageWidget(
                  imageSource: ImageConstants().chevron,
                  isNetworkImage: false,
                  height: 16,
                  width: 16,
                  bgColor: AppColor().transparent,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            CommonTextWidget(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: CommonImageWidget(
                      imageSource: ImageConstants().chevron,
                      isNetworkImage: false,
                      height: 16,
                      width: 16,
                      bgColor: AppColor().transparent,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: CommonImageWidget(
                      imageSource: ImageConstants().chevron,
                      isNetworkImage: false,
                      height: 16,
                      width: 16,
                      bgColor: AppColor().transparent,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
