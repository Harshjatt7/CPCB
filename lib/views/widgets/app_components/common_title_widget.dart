import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonTitleWidget extends StatelessWidget {
  const CommonTitleWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonTextWidget(
        useLocalization: false,
        label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
