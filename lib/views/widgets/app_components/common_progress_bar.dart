import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../components/common_text_widget.dart';

class CommonProgressBar extends StatelessWidget {
  CommonProgressBar({super.key, this.widthFactor,this.progress});
  final double? widthFactor;
  final int? progress;
  final appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: Row(
        children: [
          CommonTextWidget(
            '$progress%',
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
                  widthFactor: widthFactor, //progress number
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
