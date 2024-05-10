import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/onborading/producer_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_note.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ProducerScreen extends StatelessWidget {
  const ProducerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List monthList = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return BaseView<ProducerViewModel>(
      onModelReady: (viewmodel) {
        viewmodel.wait(context);
      },
      viewModel: ProducerViewModel(),
      builder: (context, viewModel, child) {
        return CustomScaffold(
          appBar: const CommonAppBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  key: viewModel.formKey,
                  child: CommonDropdownTextFormField(
                    dropDownItem: monthList,
                    labelText: "Choose Month",
                    value: viewModel.dropdownValue,
                    onChanged: (value) {
                      if (viewModel.formKey.currentState?.validate() ?? false) {
                        viewModel.changeDropdownValue(value);
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (viewModel.formKey.currentState?.validate() ?? false) {
                        HelperFunctions().logger("Validated");
                      } else {
                        HelperFunctions().logger("Not Validated");
                      }
                    },
                    child: const Text("Click")),
                const CommonNote(
                    note:
                        "Please carefully examine the following documents. If verified, please upload the document PDF; if not, please mention remarks"),
              ],
            ),
          ),
        );
      },
    );
  }
}
