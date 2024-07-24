import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/auditor/recycler_form/recycler_form_1_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_radio_button.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_rich_text.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonAuditorRecyclerForm1Tile extends StatelessWidget {
  CommonAuditorRecyclerForm1Tile(
      {super.key,
      this.isMandatory = false,
      this.groupValue,
      this.title,
      this.isUpload = false,
      this.isDisableField = true,
      this.viewModel,
      this.disableController,
      this.remarksController,
      this.uploadController,
      this.isDocument = false,
      this.onTap,
      this.onSuffixTap,
      this.remarksValidator,
      this.uploadValidator,
      this.onChanged,
      this.isSummary = false,
      this.isReadOnly = false});
  final AppColor appColor = AppColor();
  final StringConstants stringConstants = StringConstants();
  final bool? isMandatory;
  final String? groupValue;
  final String? title;
  final bool? isUpload;
  final bool? isDisableField;
  final RecyclerFormViewModel? viewModel;
  final TextEditingController? disableController;
  final TextEditingController? remarksController;
  final TextEditingController? uploadController;
  final bool? isDocument;
  final void Function()? onTap;
  final void Function()? onSuffixTap;
  final String? Function(String?)? remarksValidator;
  final String? Function(String?)? uploadValidator;
  final bool? isReadOnly;
  final void Function(String?)? onChanged;
  final bool? isSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRadioButton(
            isMandatory: isMandatory ?? false,
            groupValue: groupValue ?? "",
            value1: stringConstants.radioValue1,
            value2: stringConstants.radioValue2,
            label1: stringConstants.notConfirmed,
            label2: stringConstants.confirmed,
            onChanged: onChanged),
        CommonRichText(title: title, isMandatory: isMandatory),
        if (isDisableField == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                disabledBgColor: appColor.black10,
                isReadOnly: true,
                hintText: title ?? '',
                isMandatory: false,
                controller: disableController ?? TextEditingController()),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CommonTextFormFieldWidget(
              isReadOnly: isReadOnly,
              bgColor: appColor.white,
              hintText: stringConstants.remarks.i18n(),
              isMandatory: false,
              validator: remarksValidator,
              controller: remarksController ?? TextEditingController()),
        ),
        if (isUpload == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
              disabledBgColor:
                  isSummary == false ? appColor.white : appColor.black10,
              isReadOnly: true,
              hintText: stringConstants.upload.i18n(),
              icon: isSummary == false
                  ? uploadController?.text.isEmpty ?? false
                      ? viewModel?.imageConstants.fileUpload
                      : viewModel?.imageConstants.removeIcon
                  : null,
              onTap: onTap,
              onSuffixTap: onSuffixTap,
              isDocument: isDocument,
              isMandatory: false,
              validator: uploadValidator,
              controller: uploadController ?? TextEditingController(),
            ),
          )
      ],
    );
  }
}
