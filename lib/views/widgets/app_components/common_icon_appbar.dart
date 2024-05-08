import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget {
  const IconAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
}
