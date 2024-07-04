import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';

class CommonMandatoryTitle extends StatelessWidget {
  CommonMandatoryTitle(
      {super.key, this.isMandatory = false, required this.title});
  final AppColor appColor = AppColor();
  final bool isMandatory;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.displaySmall,
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
