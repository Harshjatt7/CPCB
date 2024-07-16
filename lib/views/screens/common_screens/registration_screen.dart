import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/viewmodels/common_viewmodel/dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_producer_list_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_title_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({
    super.key,
    required this.viewModel,
  });
  final DashboardViewModel viewModel;
  final AppColor appColor = AppColor();
  final StringConstants stringConstants = StringConstants();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 16, bottom: 8),
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 8),
          //         child: CommonImageWidget(
          //             height: 50,
          //             fit: BoxFit.contain,
          //             imageSource: ImageConstants().blueLogo,
          //             isNetworkImage: false),
          //       ),
          //       const Flexible(
          //         child: CommonTitleWidget(
          //           label: "EPR Portal for Tyre Waste Management System",
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: appColor.black10,
          // ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: CommonTitleWidget(
                  label:
                      "Welcome to the EPR Portal for Tyre Waste Management System.")),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ProducerListTile(
                title: stringConstants.userType,
                subtitle: viewModel.data?.userType ?? ""),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ProducerListTile(
                title: stringConstants.currentStatus,
                subtitle: viewModel.data?.currentStatus ?? ""),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              decoration: BoxDecoration(color: appColor.grey20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: "Note*  ",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: appColor.green),
                    children: [
                      TextSpan(
                        text:
                            "You have to complete the registration process to access your dashboard, Click on the “Initiate Registration” to start the process on web portal",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: appColor.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CommonButtonWidget(
            label: "Initiate Registration",
            color: appColor.darkGreen,
            onPressed: () async {
              launchUrl(Uri.parse(APIRoutes.baseUrl));
            },
          )
        ],
      ),
    );
  }
}
