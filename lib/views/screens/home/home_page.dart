import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProducerScreen extends StatelessWidget {
  const ProducerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CommonAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
      ),
    );
  }
}
