import 'package:cpcb_tyre/viewmodels/producer_viewmodels/producer_widget_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_update_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProducerWidgetScreen extends StatelessWidget {
  const ProducerWidgetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseView<ProducerWidgetViewModel>(
      onModelReady: (viewmodel) {
        viewmodel.wait(context);
      },
      viewModel: ProducerWidgetViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          appBar: const CommonAppBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CommonDocumentField(
                    fileName: viewModel.filename,
                    error: viewModel.fileError,
                    onTap: () {
                      viewModel.openFileManager(context);
                    },
                    label: 'Choose File')
              ],
            ),
          ),
        );
      },
    );
  }
}
