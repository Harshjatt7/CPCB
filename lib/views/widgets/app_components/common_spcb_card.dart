import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor().black10),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget(
                    applicationNumber ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColor().black40),
                  ),
                  GestureDetector(
                    onTap: onMenuTap,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: CommonImageWidget(
                          imageSource: ImageConstants().menuIcon,
                          isNetworkImage: false),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CommonTextWidget(
                companyName ?? "",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColor().black),
              ),
              const SizedBox(
                height: 10,
              ),
              buildCustomTextWidget(context,
                  text: "${StringConstants().address.i18n()}: $address"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${StringConstants().state.i18n()}: $state"),
              Divider(
                color: AppColor().black10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget(
                    "${StringConstants().date.i18n()}: $date",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor().black40),
                  ),
                  GestureDetector(
                    onTap: onCommentTap,
                    child: CommonImageWidget(
                      imageSource: ImageConstants().commentIcon,
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

  CommonTextWidget buildCustomTextWidget(BuildContext context, {String? text}) {
    return CommonTextWidget(text ?? "",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColor().black40));
  }
}
