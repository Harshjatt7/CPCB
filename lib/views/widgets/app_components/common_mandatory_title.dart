import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';

class CommonMandatoryTitle extends StatelessWidget {
  CommonMandatoryTitle(
      {super.key, this.isMandatory = false, required this.title, this.style});
  final AppColor appColor = AppColor();
  final bool isMandatory;
  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: RichText(
        text: TextSpan(
          text: title,
          style: style ?? Theme.of(context).textTheme.displaySmall,
          children: [
            TextSpan(
              text: isMandatory == true ? " *" : "",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: appColor.red),
            ),
          ],
        ),
      ),
    );
  }
}
