import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonTitleWidget extends StatelessWidget {
  const CommonTitleWidget({super.key, required this.label,this.useLocalization});
  final String label;
  final bool? useLocalization;

  @override
  Widget build(BuildContext context) {
    return CommonTextWidget(
      useLocalization: useLocalization??true,
      label,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
