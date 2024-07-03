import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AuditorRecyclerForm3 extends StatelessWidget {
  const AuditorRecyclerForm3({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextWidget(
      "Page 3",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}