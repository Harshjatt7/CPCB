import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../components/common_button_widget.dart';
import '../components/common_text_widget.dart';

class CommonCommentPopUp extends StatelessWidget {
  const CommonCommentPopUp({super.key,this.labelText,this.hintText,this.onSubmit,required this.ctx});
  final String? labelText;
  final String? hintText;
  final VoidCallback? onSubmit;
  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    final appColor = AppColor();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: appColor.white,
      scrollable: true,
      content: Container(
        height: 250,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CommonTextWidget(
                  labelText ?? '',
                  style: Theme.of(context).textTheme.displayMedium,
                )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLength: 300,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: Theme.of(context).textTheme.bodySmall),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CommonButtonWidget(
                    label: stringConstants.submitBtnLabel,
                    color: appColor.white,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    onPressed: onSubmit,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: CommonButtonWidget(
                    label: stringConstants.cancel,
                    color: appColor.white,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
