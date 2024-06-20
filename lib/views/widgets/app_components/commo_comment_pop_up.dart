import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../components/common_button_widget.dart';
import '../components/common_text_widget.dart';

class CommonCommentPopUp extends StatelessWidget {
  const CommonCommentPopUp(
      {super.key,
      this.labelText,
      this.hintText,
      this.onSubmit,
      this.controller,
      required this.ctx});
  final String? labelText;
  final String? hintText;
  final VoidCallback? onSubmit;
  final BuildContext ctx;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    final appColor = AppColor();
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: appColor.white,
      scrollable: true,
      content: Container(
        decoration: BoxDecoration(
            color: appColor.white, borderRadius: BorderRadius.circular(10)),
        height: 300,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CommonTextWidget(
                  labelText ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller,
              maxLength: 300,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appColor.black)),
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
                        controller?.clear();
                        Navigator.pop(context);
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
                      color: appColor.darkGreen,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: appColor.white),
                      onPressed: onSubmit,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
