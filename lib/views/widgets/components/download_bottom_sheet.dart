import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../constants/string_constant.dart';
import '../../../theme/app_color.dart';
import 'common_text_widget.dart';

class DownloadBottomSheet extends StatelessWidget {
  final VoidCallback? onDownloadTransactionTapped;
  final VoidCallback? onDownloadApplicationTapped;
  const DownloadBottomSheet(
      {super.key,
      this.onDownloadApplicationTapped,
      this.onDownloadTransactionTapped});

  @override
  Widget build(BuildContext context) {
    return downloadBottomSheet(context);
  }

  Widget downloadBottomSheet(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 6,
            width: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColor().black20),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      StringConstants().options,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                        onPressed: onDownloadTransactionTapped,
                        imageSrc: ImageConstants().downloadTransactionIcon,
                        color: AppColor().darkGreen,
                        label: StringConstants().downloadTransactionLabel),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                        onPressed: onDownloadApplicationTapped,
                        imageSrc: ImageConstants().downloadApplicationIcon,
                        color: AppColor().darkGreen,
                        label: StringConstants().downloadApplicationBtnLabel),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        labelStyle:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: AppColor().black,
                                  fontWeight: FontWeight.w600,
                                ),
                        color: AppColor().transparent,
                        label: StringConstants().close)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
