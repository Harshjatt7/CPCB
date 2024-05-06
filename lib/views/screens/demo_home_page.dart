import 'package:flutter/material.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/utils/helper/global_provider_helper.dart';
import 'package:cpcb_tyre/viewmodels/auth_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/material_app_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    Provider.of<MaterialAppViewModel>(context, listen: false).count++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        viewModel: AuthViewModel(),
        onModelReady: (viewmodel) {},
        builder: (context, viewmodel, child) {
          return CustomScaffold(
            isLoading: viewmodel.state == ViewState.busy,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonTextWidget(
                    StringConstants().welcomeText,
                  ),
                  InkWell(
                    onTap: () async {
                      if (context.mounted) {
                        context.globalProvider.changeLanguage(context);
                      }
                    },
                    child: CommonTextWidget(
                        "${StringConstants().cartCount.i18n()}: ${Provider.of<MaterialAppViewModel>(context, listen: false).count}"),
                  ),
                ],
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _incrementCounter();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.globalProvider.changeLanguage(context);
                  },
                  tooltip: 'Change Language',
                  child: const Icon(Icons.language),
                ),
              ],
            ),
          );
        });
  }
}
