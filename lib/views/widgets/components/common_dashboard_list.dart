import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardTileWidget extends StatelessWidget {
  const DashboardTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color:AppColor().white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black,)),
      margin: const EdgeInsets.only(bottom: 90),
      child: ListTile(
        dense: true,
        leading: SvgPicture.asset(ImageConstants().info),
        title: const Text("User Type"),
        subtitle: const Text("Producer"),
      ),
    );
  }
}
