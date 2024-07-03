import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AuditorRecyclerForm2 extends StatelessWidget {
  const AuditorRecyclerForm2({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextWidget(
      "Page 2",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
