import 'package:cpcb_tyre/views/widgets/app_components/common_upload_field.dart';
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
  AuditorFormTile({
    super.key,
    this.groupValue,
    this.title,
    this.isMandatory = false,
    this.onChanged,
    this.isUpload = false,
    this.titleStyle,
    this.isRadioField = false,
    this.radioPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRadioField == true||isRadioField==false)
            CommonRadioButton(
              titleStyle: titleStyle,
              isMandatory: isMandatory,
              title: title,
              groupValue: groupValue ?? "",
              value1: "not confirmed",
              value2: "confirmed",
              label1: "Not Confirmed",
              label2: "Confirmed",
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
                controller: TextEditingController()),
          ),
          if (isRadioField == false)  
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CommonTextFormFieldWidget(
                bgColor: appColor.white,
                hintText: "Remarks",
                isMandatory: false,
                controller: TextEditingController()),
          ),
          if (isUpload == true)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CommonDocumentField(
                onTap: () {},
                label: "Upload",
                isMandatory: isMandatory,
                bgColor: appColor.white,
              ),
            )
        ],
      ),
    );
  }
}
