import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_4_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_mandatory_title.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AuditorRecyclerForm4 extends StatelessWidget {
  AuditorRecyclerForm4({super.key});
  final AppColor appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    return BaseView<RecyclerForm4ViewModel>(
        onModelReady: (viewModel) {},
        viewModel: RecyclerForm4ViewModel(),
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonTitleWidget(
                    label:
                        "Verify the production of end products by end products by random selection of 5 invoices"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16 ),
                  child: CommonTextWidget(
                    "View entries",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: appColor.blue100,
                        decoration: TextDecoration.underline),
                  ),
                ),
                commonForm4Tiles(context,
                    title:
                        "No. of invoices for which type/ quantity/ both can’t be verified"),
                commonForm4Tiles(context,
                    title:
                        "No. of buyers for which type/ quantity/ both of end product sold could not be verified")
              ],
            ),
          );
        });
  }

  Column commonForm4Tiles(
    BuildContext context, {
    bool isMandatory = false,
    String? groupValue,
    String? title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonMandatoryTitle(
          title: title ?? '',
          isMandatory: true,
        ),
        CommonRadioButton(
            groupValue: groupValue ?? "",
            value1: "not confirmed",
            value2: "confirmed",
            label1: "Not Confirmed",
            label2: "Confirmed",
            onChanged: (value) {
              groupValue = value ?? '';
            }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CommonTextFormFieldWidget(
              useLocalization: false,
              bgColor: appColor.white,
              hintText: title ?? '',
              isMandatory: false,
              controller: TextEditingController()),
        ),
        Padding(
          padding:
              const EdgeInsets.only( top: 8, bottom: 16),
          child: CommonTextFormFieldWidget(
              bgColor: appColor.white,
              hintText: "Remarks",
              isMandatory: false,
              controller: TextEditingController()),
        ),
      ],
    );
  }
}
