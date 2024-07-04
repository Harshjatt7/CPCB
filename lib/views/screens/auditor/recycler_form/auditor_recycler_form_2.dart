import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_2_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_dropdown_text_form_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AuditorRecyclerForm2 extends StatelessWidget {
  AuditorRecyclerForm2({super.key});
  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm2ViewModel>(
      onModelReady: (viewModel) {},
      viewModel: RecyclerForm2ViewModel(),
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonTitleWidget(label: "(A). Plant Capacity Assessment"),
            CommonMandatoryTitle(
              title: "Type of end product",
              isMandatory: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CommonDropdownTextFormField(
                  labelText: "Select", dropDownItem: const[], onChanged: null),
            ),
            commonRecyclerForm2Tile(
                title:
                    "Plant Production capacity registered on the portal as per CTO (Tonnes per annum) = x",
                hintText: "Enter",
                textEditingController: TextEditingController()),
            commonRecyclerForm2Tile(
                title:
                    "End Product Produced on audit day during 1 hr test run (T per hour) = b",
                hintText: "Enter",
                textEditingController: TextEditingController()),
            commonRecyclerForm2Tile(
                title: "No. of days the plant is operational per year",
                hintText: "Enter",
                textEditingController: TextEditingController()),
            commonRecyclerForm2Tile(
                title: "No. of hrs the plant is operational per shift",
                hintText: "Enter",
                textEditingController: TextEditingController()),
            commonRecyclerForm2Tile(
                title:
                    "Actual processing capacity as derived from test run (Tonnes per annum)",
                hintText: "", //Value will come from API
                textEditingController: TextEditingController(),
                isDisable: true),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: CommonTitleWidget(
                  label: "Are values x and y comparable (Yes/No)"),
            ),
            CommonRadioButton(
              groupValue: "confirmed",
              value1: "not confirmed",
              value2: "confirmed",
              label1: "Not Confirmed",
              label2: "Confirmed",
              onChanged: (value) {},
            ),
            commonRecyclerForm2Tile(
                title:
                    "Difference in actual processing capacity. (Tonnes per annum)",
                hintText: "Enter",
                textEditingController: TextEditingController(),
                isDisable: false),
            commonRecyclerForm2Tile(
                title: "Total quantity of sales uploaded by recycler in a FY=z",
                hintText: "", //Value will come from API
                textEditingController: TextEditingController(),
                isDisable: true),
            commonRecyclerForm2Tile(
                title:
                    "Difference in actual processing capacity against the uploaded sales. (Tonnes per annum)",
                hintText: "", //Value will come from API
                textEditingController: TextEditingController(),
                isDisable: true),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: CommonTitleWidget(label: "(B). Electricity Verification"),
            ),
            commonRecyclerForm2Tile(
                title:
                    "Power consumption during audit day for 1 hr test run (Kwh) = a",
                hintText: "Enter",
                textEditingController: TextEditingController(),
                isDisable: false),
            commonRecyclerForm2Tile(
                title:
                    "Actual Average Annual power consumption (a/b*Z) = C Kwh",
                hintText: "Enter",
                textEditingController: TextEditingController(),
                isDisable: true),
            commonRecyclerForm2Tile(
                title:
                    "Total electricity consumed in last FY as per Electricity Bill = D Kwh",
                hintText: "Enter",
                textEditingController: TextEditingController(),
                isDisable: false),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 8, left: 16, right: 16),
              child: CommonTextWidget(
                "Are values C and D comparable (Yes/No)",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            )
          ],
        );
      },
    );
  }

  Column commonRecyclerForm2Tile(
      {String? title,
      String? hintText,
      TextEditingController? textEditingController,
      bool isDisable = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonMandatoryTitle(
          title: title ?? '',
          isMandatory: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonTextFormFieldWidget(
              disabledBgColor: appColor.black10,
              bgColor: appColor.white,
              isReadOnly: isDisable,
              hintText: hintText ?? "",
              isMandatory: false,
              controller: textEditingController ?? TextEditingController()),
        ),
      ],
    );
  }
}
