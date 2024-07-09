import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: CommonTitleWidget(
          label: "Please complete the Registeration process on the web portal",
        ),
      ),
    );
  }
}
