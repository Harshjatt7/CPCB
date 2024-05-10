import 'package:cpcb_tyre/viewmodels/producer_viewmodels/producer_widget_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
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
                CommonDropdownTextFormField(
                  onTap: () {
                    viewModel.changeDropdownValue(null);
                  },
                  dropDownItem: viewModel.monthList,
                  labelText: "Choose Month ",
                  error: viewModel.dropdownError,
                  onChanged: (value) {
                    viewModel.changeDropdownValue(value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
