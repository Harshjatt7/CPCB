import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../components/common_button_widget.dart';
import '../components/common_text_widget.dart';

class CommonCommentPopUp extends StatelessWidget {
  CommonCommentPopUp(
      {super.key,
      this.labelText,
      this.hintText,
      this.onSubmit,
      this.controller,
      this.filePath,
      this.onTap,
      this.onSuffixTap,
      required this.ctx,
      this.uploadInvoiceController,
      this.validator});
  final String? labelText;
  final String? hintText;
  final VoidCallback? onSubmit;
  final BuildContext ctx;
  final TextEditingController? controller;
  final formKey = GlobalKey<FormState>();
  final String? filePath;
  final ImageConstants imageConstants = ImageConstants();
  final TextEditingController? uploadInvoiceController;
  final void Function()? onTap;
  final void Function()? onSuffixTap;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    final appColor = AppColor();
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: appColor.white,
      scrollable: true,
      content: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
              color: appColor.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                labelText ?? '',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: FocusNode(canRequestFocus: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return stringConstants.enterComment.i18n();
                  } else {
                    return null;
                  }
                },
                controller: controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 600,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: appColor.black90,
                    ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appColor.black10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appColor.black10)),
                  border: const OutlineInputBorder(),
                  hintText: hintText,
                  hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: appColor.grey01,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonTextFormFieldWidget(
                    isDocument: true,
                    disabledBgColor: appColor.transparent,
                    isReadOnly: true,
                    hintText: stringConstants.upload,
                    icon: uploadInvoiceController?.text.isEmpty ?? false
                        ? imageConstants.fileUpload
                        : imageConstants.removeIcon,
                    onTap: onTap,
                    onSuffixTap: onSuffixTap,
                    validator: validator,
                    isMandatory: false,
                    controller:
                        uploadInvoiceController ?? TextEditingController()),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Flexible(flex: 3, child: SizedBox()),
                    Flexible(
                      flex: 2,
                      child: CommonButtonWidget(
                        label: stringConstants.cancel,
                        color: appColor.white,
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        onPressed: () {
                          Navigator.pop(context);
                          controller?.clear();
                          uploadInvoiceController?.clear();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 2,
                      child: CommonButtonWidget(
                        label: stringConstants.submitBtnLabel,
                        color: AppColor().darkGreen,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: appColor.white),
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            onSubmit != null ? onSubmit!() : null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
