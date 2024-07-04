import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/auditor_form_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuditorRecyclerForm1 extends StatelessWidget {
  AuditorRecyclerForm1({super.key});
  final AppColor appColor = AppColor();
  String groupValueA = "confirmed";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonTitleWidget(label: "(A). Company details"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AuditorFormTile(
            isMandatory: true,
            groupValue: groupValueA,
            title: "GST",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AuditorFormTile(
            isMandatory: true,
            groupValue: groupValueA,
            title: "Company’s PAN No.",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AuditorFormTile(
            isMandatory: false,
            groupValue: groupValueA,
            title: "Company’s IEC",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AuditorFormTile(
            isMandatory: true,
            groupValue: groupValueA,
            title: "Recycler’s CTO/CCA",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AuditorFormTile(
            isMandatory: true,
            groupValue: groupValueA,
            title: "Authorization under Hazardous & other waste rules 2016",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AuditorFormTile(
            isMandatory: true,
            groupValue: groupValueA,
            title: "Recycling facility details",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextWidget(
                  "GPS coordinates for Recycler",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: appColor.black30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    disabledBgColor: appColor.black10,
                    isReadOnly: true,
                    hintText: "GPS Latitude",
                    isMandatory: false,
                    controller: TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    disabledBgColor: appColor.black10,
                    isReadOnly: true,
                    hintText: "GPS Longitude",
                    isMandatory: false,
                    controller: TextEditingController()),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CommonRadioButton(
                  isMandatory: false,
                  title: "GPS coordinates for Auditor",
                  groupValue: groupValueA,
                  value1: "not confirmed",
                  value2: "confirmed",
                  label1: "Not Confirmed",
                  label2: "Confirmed",
                  onChanged: (value) {
                    groupValueA = value ?? '';
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CommonTextFormFieldWidget(
                  hintText: "GPS Latitude",
                  isMandatory: false,
                  controller: TextEditingController()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CommonTextFormFieldWidget(
                  hintText: "GPS Longitude",
                  isMandatory: false,
                  controller: TextEditingController()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: CommonTextWidget(
                "Remarks",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: appColor.black30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CommonTextFormFieldWidget(
                  hintText: "Remarks",
                  isMandatory: false,
                  controller: TextEditingController()),
            )
          ],
        ),
        const CommonTitleWidget(label: "(B). Authorized person"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AuditorFormTile(
              isMandatory: false,
              groupValue: groupValueA,
              title: "Authorized person Aadhar Card",
              isUpload: true),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AuditorFormTile(
                groupValue: groupValueA,
                title: "Authorized person PAN No.",
                isMandatory: false,
                isUpload: true)),
        const Column(
          children: [
            CommonTitleWidget(label: "(C). Plant Machinery"),
          ],
        )
      ],
    );
  }
}
