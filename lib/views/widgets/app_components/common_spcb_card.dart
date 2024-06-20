import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../constants/image_constants.dart';
import '../../../constants/string_constant.dart';

class CommonSpcbCard extends StatelessWidget {
  const CommonSpcbCard({
    super.key,
    this.companyName,
    this.address,
    this.date,
    this.state,
    this.onMenuTap,
    this.applicationNumber,
    this.onCommentTap,
  });
  final String? companyName;
  final String? address;
  final String? date;
  final String? state;
  final Function()? onMenuTap;
  final String? applicationNumber;
  final Function()? onCommentTap;

  @override
  Widget build(BuildContext context) {
    final appColor = AppColor();
    final imageConstants = ImageConstants();
    final stringConstants = StringConstants();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: appColor.black10),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                applicationNumber ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: appColor.black40),
              ),
              const SizedBox(
                height: 8,
              ),
              CommonTextWidget(
                companyName ?? "",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: appColor.black),
              ),
              const SizedBox(
                height: 10,
              ),
              buildCustomTextWidget(context, appColor,
                  text: "${stringConstants.address.i18n()}: $address"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context, appColor,
                  text: "${stringConstants.state.i18n()}: $state"),
              Divider(
                color: appColor.black10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CommonImageWidget(
                        imageSource: imageConstants.calendarIcon,
                        isNetworkImage: false,
                      ),
                      const SizedBox(width: 4,),
                      CommonTextWidget(
                        "${stringConstants.date.i18n()}: $date",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: appColor.black40),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onCommentTap,
                    child: CommonImageWidget(
                      imageSource: imageConstants.commentIcon,
                      isNetworkImage: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  CommonTextWidget buildCustomTextWidget(
      BuildContext context, AppColor appColor,
      {String? text}) {
    return CommonTextWidget(text ?? "",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: appColor.black40));
  }
}
