import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonCustomListingCard extends StatelessWidget {
  const CommonCustomListingCard({
    super.key,
    this.companyName,
    this.contactNumber,
    this.email,
    this.state,
    this.onMenuTap,
  });
  final String? companyName;
  final String? contactNumber;
  final String? email;
  final String? state;
  final Function()? onMenuTap;

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
                  Row(
                    children: [
                      CommonTextWidget(
                        companyName ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: AppColor().black),
                      ),
                    ],
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
                height: 10,
              ),
              buildCustomTextWidget(context,
                  text:
                      "${StringConstants().contactNumber.i18n()}: $contactNumber"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${StringConstants().email.i18n()}: $email"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${StringConstants().state.i18n()}: $state"),
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
