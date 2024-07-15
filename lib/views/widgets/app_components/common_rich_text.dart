import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';

class CommonRichText extends StatelessWidget {
   CommonRichText({super.key, this.title, this.isMandatory});
  final String? title;
  final bool? isMandatory;
  final AppColor appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: appColor.black30),
          children: [
            TextSpan(
              text: isMandatory == true ? " *" : "",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: appColor.red),
            ),
          ],
        ),
      ),
    );
  }
}
