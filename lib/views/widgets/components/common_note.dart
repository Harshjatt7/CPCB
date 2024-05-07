import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/theme/text_style_constants.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonNote extends StatelessWidget {
  const CommonNote({super.key, required this.note, this.color});
  final String note;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColor().greyD3D3D3,
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            StringConstants().note,
            style: TextStyleConstants().mediumTextStyle().copyWith(
                color: color ?? AppColor().green2E9331,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10.0),
          Flexible(
            child: Text(
              note,
              style: TextStyleConstants()
                  .mediumTextStyle()
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
