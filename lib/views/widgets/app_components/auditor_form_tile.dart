import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';
import '../components/common_text_form_field_widget.dart';
import 'common_radio_button.dart';

// ignore: must_be_immutable
class AuditorFormTile extends StatelessWidget {
  final bool isMandatory;
  String? groupValue;
  final String? title;
  final bool? isUpload;
  final void Function(String?)? onChanged;
  final TextStyle? titleStyle;
  final bool? isRadioField;
  final appColor = AppColor();
  final EdgeInsets? radioPadding;
  final TextEditingController? remarkController;
  final String? uploadedFileName;
  final TextEditingController? uploadController;
  final TextEditingController? disableController;
  final VoidCallback? onTap;
  final String? Function(String?)? uploadValidator;
  final VoidCallback? onSuffixTap;
  final imageConstants = ImageConstants();
  final StringConstants stringConstants = StringConstants();
  final String? filePath;
  final String? isRemarkMandatory;
  final String? Function(String?)? validator;
  AuditorFormTile(
      {super.key,
      this.groupValue,
      this.title,
      this.isMandatory = false,
      this.onChanged,
      this.isUpload = false,
      this.titleStyle,
      this.isRadioField = false,
      this.radioPadding,
      this.remarkController,
      this.uploadedFileName,
      this.disableController,
      this.onTap,
      this.uploadController,
      this.onSuffixTap,
      this.uploadValidator,
      this.filePath,
      this.isRemarkMandatory,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isRadioField == true || isRadioField == false)
          CommonRadioButton(
            titleStyle: titleStyle,
            isMandatory: isMandatory,
            title: title,
            groupValue: groupValue ?? "",
            value1: stringConstants.notConfirmed,
            value2: stringConstants.confirmed,
            label1: stringConstants.notConfirmed,
            label2: stringConstants.confirmed,
            onChanged: onChanged,
            padding: radioPadding,
          ),
        if (isRadioField == false)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                disabledBgColor: appColor.black10,
                isReadOnly: true,
                hintText: title ?? '',
                isMandatory: false,
                controller: disableController ?? TextEditingController()),
          ),
        if (isRadioField == false)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
              hintText: stringConstants.remark,
              bgColor: appColor.white,
              isMandatory: false,
              controller: remarkController ?? TextEditingController(),
              validator: validator,
            ),
          ),
        if (isUpload == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
              isDocument: true,
              disabledBgColor: appColor.transparent,
              isReadOnly: true,
              hintText: stringConstants.upload,
              icon: uploadController?.text.isEmpty ?? false
                  ? imageConstants.fileUpload
                  : imageConstants.removeIcon,
              onTap: onTap,
              onSuffixTap: onSuffixTap,
              validator: uploadValidator,
              isMandatory: false,
              controller: uploadController ?? TextEditingController(),
            ),
          )
      ],
    );
  }
}
