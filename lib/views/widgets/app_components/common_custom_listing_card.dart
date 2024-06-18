import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonCustomListingCard extends StatelessWidget {
  CommonCustomListingCard({
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
  final StringConstants stringConstants = StringConstants();
  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: CommonTextWidget(
                      maxLines: 1,
                      companyName ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: appColor.black),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onMenuTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: CommonImageWidget(
                          imageSource: ImageConstants().menuIcon,
                          isNetworkImage: false),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              buildCustomTextWidget(context,
                  text:
                      "${stringConstants.contactNumber.i18n()}: $contactNumber"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${stringConstants.email.i18n()}: $email"),
              const SizedBox(
                height: 6,
              ),
              buildCustomTextWidget(context,
                  text: "${stringConstants.state.i18n()}: $state"),
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
            ?.copyWith(color: appColor.black40));
  }
}
