import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AuditorRecyclerForm5 extends StatelessWidget {
  const AuditorRecyclerForm5({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextWidget(
      "Page 5",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}