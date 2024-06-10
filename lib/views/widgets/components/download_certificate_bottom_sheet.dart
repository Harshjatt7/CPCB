import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../constants/string_constant.dart';
import '../../../theme/app_color.dart';
import 'common_text_widget.dart';

class DownloadCertificateBottomSheet extends StatelessWidget {
  final VoidCallback? onDownloadCertificateTapped;
  final StringConstants stringConstants = StringConstants();
  final AppColor appColor=AppColor();
  DownloadCertificateBottomSheet({super.key, this.onDownloadCertificateTapped});

  @override
  Widget build(BuildContext context) {
    return downloadBottomSheet(context);
  }

  Widget downloadBottomSheet(BuildContext context) {
    return Container(
      height: 230,
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
                        onPressed: onDownloadCertificateTapped,
                        imageSrc: ImageConstants().downloadTransactionIcon,
                        color: appColor.darkGreen,
                        label: stringConstants.downloadCertificate),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonButtonWidget(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        labelStyle:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: appColor.black80,
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
