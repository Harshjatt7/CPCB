import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonProgressBar extends StatelessWidget {
  CommonProgressBar({super.key, required this.percentage});
  final AppColor appColor = AppColor();
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: Row(
        children: [
          CommonTextWidget(
            '${percentage.toInt()}%',
          ),
          const SizedBox(
            width: 4,
          ),
          Flexible(
            child: Stack(
              children: [
                Container(
                  height: 7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: appColor.black10),
                ),
                FractionallySizedBox(
                  widthFactor: percentage / 100, //progress number
                  child: Container(
                    height: 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appColor.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
