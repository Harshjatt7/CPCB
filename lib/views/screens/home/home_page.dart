import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_note.dart';
import 'package:cpcb_tyre/views/widgets/components/common_producer_environment_tile.dart';
import 'package:cpcb_tyre/views/widgets/components/common_producer_list_tile.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProducerScreen extends StatelessWidget {
  const ProducerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CommonNote(note: "You have to complete the registration process to access your dashboard, Click on the “Initiate Registration” to start the process."),
            const ProducerListTile(title: "User Type", subtitle: "Producer"),
           Row(children: [
             ProducerEnvironmentTile(
                title: "Date of EC",
                subtitle: "24 April 2024",
                image: ImageConstants().calendar),
                 ProducerEnvironmentTile(
                title: "Current Status",
                subtitle: "Paid",
                image: ImageConstants().environmentInfo,
                subtitleColor: AppColor().green2E9331,)
           ],),
          ],
        ),
      ),
    );
  }
}
