import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonTitleBar extends StatelessWidget {
  String? title;
  CommonTitleBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColor().black10,
            ),
          ),
        ),
        child: CommonTextWidget(title ?? '',
            style: Theme.of(context).textTheme.labelLarge));
  }
}
