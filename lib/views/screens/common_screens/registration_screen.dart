import 'package:cpcb_tyre/views/widgets/app_components/common_pop_up.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return CommonPopUp(
                    onPressedNo: () {
                      Navigator.pop(ctx);
                    },
                    onPressedYes: () async {
                      Navigator.pop(ctx);
                      if (context.mounted) {}
                    },
                  );
                });
          },
          child: const CommonTitleWidget(
            label:
                "Please complete the Registeration process on the web portal",
          ),
        ),
      ),
    );
  }
}
