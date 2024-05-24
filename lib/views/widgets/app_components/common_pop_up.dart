import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonPopUp extends StatelessWidget {
  const CommonPopUp({super.key, this.onPressedYes,this.onPressedNo});
  final void Function()? onPressedYes;
  final void Function()? onPressedNo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: AppColor().red,
      content: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColor().white,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: CommonTextWidget(
                MessageConstant().submitAlertTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Flexible(flex: 5, child: SizedBox()),
                  Flexible(
                    flex: 2,
                    child: CommonButtonWidget(
                      label: StringConstants().no,
                      color: AppColor().white,
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      onPressed: onPressedNo,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: CommonButtonWidget(
                        label: StringConstants().yes,
                        color: AppColor().darkGreen,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColor().white),
                        onPressed: onPressedYes,
                        //  () async {
                        //   Navigator.pop(ctx);
                        //   if (context.mounted) {
                        //     await viewModel.addRetreadedData(
                        //       context,
                        //     );
                        //   }
                        // },
                      ),
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
