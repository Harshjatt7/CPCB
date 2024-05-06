import 'package:flutter/material.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../../constants/routes_constant.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
          onTap: () {
            Provider.of<MaterialAppViewModel>(context, listen: false).count++;
            Navigator.pushReplacementNamed(context, AppRoutes.homePageRoute,
                arguments: "Test");
          },
          child: Container(
            alignment: Alignment.center,
            child: CommonTextWidget(
                "${StringConstants().cartCount.i18n()} >> ${Provider.of<MaterialAppViewModel>(context, listen: false).count}"),
          )),
    );
  }
}
