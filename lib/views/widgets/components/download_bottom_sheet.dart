import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../constants/string_constant.dart';
import '../../../theme/app_color.dart';
import 'common_text_widget.dart';

class DownloadBottomSheet extends StatelessWidget {
  final VoidCallback? onDownloadTransactionTapped;
  final VoidCallback? onDownloadApplicationTapped;
  final ImageConstants imageConstants = ImageConstants();
  final StringConstants stringConstants = StringConstants();
  final AppColor appColor = AppColor();
  DownloadBottomSheet(
      {super.key,
      this.onDownloadApplicationTapped,
      this.onDownloadTransactionTapped});

  @override
  Widget build(BuildContext context) {
    return downloadBottomSheet(context);
  }

  Widget downloadBottomSheet(BuildContext context) {
    return Container(
      height: 220,
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
                color: appColor.black20),
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
                      stringConstants.options,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                        onPressed: onDownloadTransactionTapped,
                        imageSrc: imageConstants.downloadTransactionIcon,
                        color: appColor.darkGreen,
                        label: stringConstants.downloadTransactionLabel),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // CommonButtonWidget(
                    //     onPressed: onDownloadApplicationTapped,
                    //     imageSrc: imageConstants.downloadApplicationIcon,
                    //     color: appColor.darkGreen,
                    //     label: stringConstants.downloadApplicationBtnLabel),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        labelStyle:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: appColor.black,
                                  fontWeight: FontWeight.w600,
                                ),
                        color: appColor.transparent,
                        label: stringConstants.close)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
