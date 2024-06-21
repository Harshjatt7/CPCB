import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../components/common_button_widget.dart';
import '../components/common_text_widget.dart';

class CommonCommentPopUp extends StatelessWidget {
  const CommonCommentPopUp({
    super.key,
    this.labelText,
    this.hintText,
    this.onSubmit,
    this.controller,
    required this.ctx,
    this.validator,
    this.buttonColor,
  });
  final String? labelText;
  final String? hintText;
  final VoidCallback? onSubmit;
  final BuildContext ctx;
  final TextEditingController? controller;
  final String Function(String?)? validator;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter comment";
                  } else {
                    return null;
                  }
                },
                controller: controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 600,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appColor.black)),
                    border: const OutlineInputBorder(),
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodySmall),
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
