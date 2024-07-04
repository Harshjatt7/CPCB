import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_3_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AuditorRecyclerForm3 extends StatelessWidget {
  AuditorRecyclerForm3({super.key});
  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm3ViewModel>(
      onModelReady: (viewModel) {},
      viewModel: RecyclerForm3ViewModel(),
      builder: (context, model, child) {
        return Column(
          children: [
            Row(
              children: [
                const CommonTitleWidget(
                    label: "(A). Verification of Procurement"),
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: CommonTextWidget(
                    "View entries",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: appColor.blue100,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            commonRecyclerForm3Tile(
              title: "No. of suppliers contacted",
            ),
            commonRecyclerForm3Tile(
                title:
                    "No. of suppliers for which supplier details could be verified",
                isDisable: true,
                notVerifiedTitle:
                    "No. of suppliers for which supplier details could not be verified"),
            const CommonTitleWidget(
                label: "(B). Physically visit at least one of the suppliers"),
            commonRecyclerForm3Tile(title: "No. of suppliers contacted"),
            commonRecyclerForm3Tile(
                title:
                    "No. of suppliers for which supplier details could be verified",
                isDisable: true,
                notVerifiedTitle:
                    "No. of suppliers for which supplier details could not be verified")
          ],
        );
      },
    );
  }

  Column commonRecyclerForm3Tile(
      {String? title,
      String? notVerifiedTitle,
      TextEditingController? textEditingController,
      bool isDisable = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CommonMandatoryTitle(
            title: title ?? '',
            isMandatory: true,
          ),
        ),
        CommonRadioButton(
            isMandatory: false,
            groupValue: "confirmed",
            value1: "not confirmed",
            value2: "confirmed",
            label1: "Not Confirmed",
            label2: "Confirmed",
            onChanged: (value) {}),
        Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 12, left: 16, right: 16),
          child: CommonTextFormFieldWidget(
              bgColor: appColor.white,
              hintText: title ?? "",
              isMandatory: false,
              controller: textEditingController ?? TextEditingController()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CommonTextFormFieldWidget(
              bgColor: appColor.white,
              hintText: "Remark",
              isMandatory: false,
              controller: textEditingController ?? TextEditingController()),
        ),
        //TODO add remarks
        if (isDisable == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: CommonTextFormFieldWidget(
                disabledBgColor: appColor.black10,
                bgColor: appColor.white,
                isReadOnly: isDisable,
                hintText: notVerifiedTitle ?? "",
                isMandatory: false,
                controller: textEditingController ?? TextEditingController()),
          ),
      ],
    );
  }
}
