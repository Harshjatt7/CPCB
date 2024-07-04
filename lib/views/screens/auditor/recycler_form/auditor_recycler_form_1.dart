import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_upload_field.dart';
import 'package:cpcb_tyre/views/widgets/app_components/plant_machinery_widget.dart';
import 'package:cpcb_tyre/views/widgets/app_components/recycler_data_table.dart';
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
    return BaseView<RecyclerForm1ViewModel>(
        onModelReady: (viewModel) {},
        viewModel: RecyclerForm1ViewModel(),
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CommonTitleWidget(label: "(A). Company details"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles(
                  context,
                  isMandatory: true,
                  groupValue: groupValueA,
                  title: "GST",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles(
                  context,
                  isMandatory: true,
                  groupValue: groupValueA,
                  title: "Company’s PAN No.",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles(
                  context,
                  isMandatory: false,
                  groupValue: groupValueA,
                  title: "Company’s IEC",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles(
                  context,
                  isMandatory: true,
                  groupValue: groupValueA,
                  title: "Recycler’s CTO/CCA",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles(
                  context,
                  isMandatory: true,
                  groupValue: groupValueA,
                  title:
                      "Authorization under Hazardous & other waste rules 2016",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles(
                  context,
                  isMandatory: true,
                  groupValue: groupValueA,
                  title: "Recycling facility details",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CommonTextFormFieldWidget(
                        hintText: "GPS Latitude",
                        isMandatory: false,
                        controller: TextEditingController()),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CommonTextFormFieldWidget(
                        hintText: "GPS Longitude",
                        isMandatory: false,
                        controller: TextEditingController()),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: CommonTextWidget(
                      "Remarks",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: appColor.black30),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                child: commonFormTiles(context,
                    isMandatory: false,
                    groupValue: groupValueA,
                    title: "Authorized person Aadhar Card",
                    isUpload: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles(context,
                    isMandatory: false,
                    groupValue: groupValueA,
                    title: "Authorized person PAN No.",
                    isUpload: true),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CommonTitleWidget(label: "(C). Plant Machinery"),
                  RecyclerDataTable(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: PlantMachineryWidget(),
                  )
                ],
              ),
              const CommonTitleWidget(label: "(D). Power Consumption"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles2(context,
                    isMandatory: true,
                    groupValue: groupValueA,
                    title: "Electricity bills of last financial year",
                    isUpload: false),
              ),
              const CommonTitleWidget(
                  label: "(E). Air Pollution control devices"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles2(context,
                    isMandatory: false,
                    groupValue: groupValueA,
                    title: "Details of Pollution Control System",
                    isUpload: true),
              ),
              const CommonTitleWidget(label: "(F). Video of Plant"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: commonFormTiles2(context,
                    isMandatory: false,
                    groupValue: groupValueA,
                    title: "Any other plant machinery",
                    isUpload: true),
              ),
            ],
          );
        });
  }

  Column commonFormTiles2(
    BuildContext context, {
    bool isMandatory = false,
    String? groupValue,
    String? title,
    bool isUpload = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRadioButton(
            isMandatory: isMandatory,
            groupValue: groupValue ?? "",
            value1: "not confirmed",
            value2: "confirmed",
            label1: "Not Confirmed",
            label2: "Confirmed",
            onChanged: (value) {
              groupValue = value ?? '';
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          child: RichText(
            text: TextSpan(
              text: title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: appColor.black30),
              children: [
                TextSpan(
                  text: isMandatory == true ? " *" : "",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: appColor.red),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CommonTextFormFieldWidget(
              disabledBgColor: appColor.black10,
              isReadOnly: true,
              hintText: title ?? '',
              isMandatory: false,
              controller: TextEditingController()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CommonTextFormFieldWidget(
              bgColor: appColor.white,
              hintText: "Remarks",
              isMandatory: false,
              controller: TextEditingController()),
        ),
        if (isUpload == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CommonDocumentField(
              onTap: () {},
              label: "Upload",
              bgColor: appColor.white,
            ),
          )
      ],
    );
  }

  Column commonFormTiles(
    BuildContext context, {
    bool isMandatory = false,
    String? groupValue,
    String? title,
    bool isUpload = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRadioButton(
            isMandatory: isMandatory,
            title: title,
            groupValue: groupValue ?? "",
            value1: "not confirmed",
            value2: "confirmed",
            label1: "Not Confirmed",
            label2: "Confirmed",
            onChanged: (value) {
              groupValue = value ?? '';
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CommonTextFormFieldWidget(
            
              disabledBgColor: appColor.black10,
              isReadOnly: true,
              hintText: title ?? '',
              isMandatory: false,
              controller: TextEditingController()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CommonTextFormFieldWidget(
              bgColor: appColor.white,
              hintText: "Remarks",
              isMandatory: false,
              controller: TextEditingController()),
        ),
        if (isUpload == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CommonDocumentField(
              onTap: () {},
              label: "Upload",
              bgColor: appColor.white,
            ),
          )
      ],
    );
  }
}
