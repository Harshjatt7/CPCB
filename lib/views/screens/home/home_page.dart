import 'package:cpcb_tyre/models/request/month_model.dart';
import 'package:cpcb_tyre/viewmodels/onborading/producer_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_note.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_update_field.dart';
// import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/components/common_appbar.dart';
import 'package:cpcb_tyre/views/widgets/components/custom_scaffold.dart';
import 'package:file_picker/file_picker.dart';
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
      builder: (context, model, child) {
        return CustomScaffold(
          appBar: const CommonAppBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                CommonDocumentField(
                  fileName: model.fileName,
                  onTap: () async{
                  model.openFileManager(context);
                }),
                const CommonNote(
                    note:
                        "Please carefully examine the following documents. If verified, please upload the document PDF; if not, please mention remarks"),
                // CommonDropdownTextFormField(
                //   dropDownItem: monthList,
                //   labelText: "Choose Month ",
                //   onChanged: (value) {
                //     model.changeDropdownValue(value);
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
