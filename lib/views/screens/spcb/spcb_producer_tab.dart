import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/spcb/spcb_dashboard_view_model.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_spcb_card.dart';
import 'package:flutter/material.dart';

import '../../../constants/string_constant.dart';
import '../../widgets/app_components/commo_comment_pop_up.dart';
import '../../widgets/components/common_single_child_scrollview.dart';

class SpcbProducerTab extends StatelessWidget {
  SpcbProducerTab({super.key, this.spcbViewModel});
  final StringConstants stringConstants = StringConstants();
  final HelperFunctions helperFunctions = HelperFunctions();
  final AppColor appColor = AppColor();
  final SpcbDashboardViewModel? spcbViewModel;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
          // viewModel.onScrollEnding();
        }
        return false;
      },
      child: CommonSingleChildScrollView(
        // controller: viewModel.scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              // TODO: Apply API later
              // child: (viewModel.data?.length ?? 0) == 0
              //     ? Center(
              //         child: CommonTextWidget(
              //             MessageConstant().noMatchingResultsFound))
              //     : Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: List<Widget>.generate(
              //             viewModel.data?.length ?? 0, (index) {
              //           final applicationData = viewModel.data?[index];
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 8),
              //             child: CommonCustomListingCard(
              //               companyName: "Producer Company Name",
              //               email: "Lorem ipsum, ipsum, 102231",
              //               contactNumber: "Lorem ipsum, ipsum, 102231",
              //               state: "Delhi",
              //              ),
              //             ),
              //           );
              //         }),
              //       )

              // TODO: Remove these dummy strings later
              child: CommonSpcbCard(
                companyName: "2 Degrees Clicon Private Limited",
                date: "24/08/2023",
                address: "Lorem ipsum, ipsum, 102231",
                state: "Delhi",
                applicationNumber: "011123234344",
                onMenuTap: () {
                  // viewModel.downloadCertificate(context);
                },
                onCommentTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext ctx) {
                      return CommonCommentPopUp(
                          ctx: ctx,
                          controller: spcbViewModel?.queryController,
                          labelText: "Raise your complaint here",
                          hintText: "Write your comment ...",
                          onSubmit: () async {
                            await spcbViewModel?.raiseComplaint(
                                context, spcbViewModel?.queryController.text);
                          
                          });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
