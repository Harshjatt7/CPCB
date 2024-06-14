import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonEndProduct extends StatelessWidget {
  final String title;
  final String generated;
  final String transferred;
  const CommonEndProduct(
      {super.key,
      required this.title,
      required this.generated,
      required this.transferred});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColor().black10),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 5,
              child: CommonTextWidget(
                title,
                style: Theme.of(context).textTheme.displayMedium,
              )),
          Flexible(
            flex: 4,
            child: CommonTextWidget(
              generated,
              useLocalization: false,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonTextWidget(
              transferred,
              textAlign: TextAlign.right,
              useLocalization: false,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
