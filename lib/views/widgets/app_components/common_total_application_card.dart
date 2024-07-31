import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonTotalApplicationCard extends StatelessWidget {
  final String totalApplication;
  final void Function()? onTap;
  final ImageConstants imageConstants = ImageConstants();
  final StringConstants stringConstants = StringConstants();
  final AppColor appColor = AppColor();
  final bool? isAuditor;
  final String? title;

  CommonTotalApplicationCard({
    super.key,
    required this.totalApplication,
    required this.onTap,
    this.isAuditor = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isAuditor == false)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CommonTextWidget(
                title ?? "",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(isAuditor == false
                        ? imageConstants.dashboardBackGround
                        : imageConstants.auditorDashboardBackground),
                    fit: BoxFit.contain)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: appColor.darkGreen, width: 7)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: Column(
                        children: [
                          CommonImageWidget(
                              imageSource: isAuditor == false
                                  ? imageConstants.statsIcon
                                  : imageConstants.auditorDashboardTotalIcon,
                              isNetworkImage: false),
                          CommonTextWidget(
                            totalApplication,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontSize: 32, color: appColor.darkGreen),
                          ),
                          CommonTextWidget(
                            isAuditor == false
                                ? stringConstants.totalApplication
                                : stringConstants.totalAudits,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
