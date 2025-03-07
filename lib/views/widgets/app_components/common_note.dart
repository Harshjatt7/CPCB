import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonNote extends StatelessWidget {
  /// [CommonNote] will be used as the common note in this project.
  ///
  /// [note] is required field to use this widget.
  ///
  /// [textColor] is optional, it will use a default info icon. it will use a default green color.
  ///
  /// [color] is optional, it will use a defualt white color.
  ///
   CommonNote({super.key, required this.note, this.textColor, this.color});
  final String note;
  final Color? textColor;
  final Color? color;
  final AppColor appColor=AppColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color ?? appColor.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: appColor.grey03,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(StringConstants().note,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: textColor ?? appColor.darkGreen,
                  )),
          const SizedBox(width: 10.0),
          Flexible(
            child: CommonTextWidget(note,
                style: Theme.of(context).textTheme.displaySmall),
          ),
        ],
      ),
    );
  }
}
