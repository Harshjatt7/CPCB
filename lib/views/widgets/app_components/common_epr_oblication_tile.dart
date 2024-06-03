import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonEPROblicationsTile extends StatelessWidget {
  final String title;
  final String count;
  final void Function()? onTap;
  const CommonEPROblicationsTile(
      {super.key, required this.title, required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor().black10),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 2,
                child: CommonTextWidget(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                )),
            Flexible(
                flex: 1,
                child: CommonTextWidget(
                  count,
                  style: Theme.of(context).textTheme.labelLarge,
                )),
          ],
        ),
      ),
    );
  }
}
