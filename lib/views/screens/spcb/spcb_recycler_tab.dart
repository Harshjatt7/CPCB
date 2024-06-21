import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../constants/string_constant.dart';
import '../../../viewmodels/spcb/spcb_dashboard_view_model.dart';
import '../../widgets/app_components/commo_comment_pop_up.dart';
import '../../widgets/app_components/common_spcb_card.dart';

class SpcbRecyclerTab extends StatelessWidget {
  const SpcbRecyclerTab({super.key, this.spcbViewModel});
  final SpcbDashboardViewModel? spcbViewModel;

  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
          // viewModel.onScrollEnding();
        }
        return false;
      },
      child: SingleChildScrollView(
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
                companyName: "Recycler",
                date: "24/08/2023",
                address: "Lorem ipsum, ipsum, 102231",
                state: "Delhi",
                applicationNumber: "011123234344",
                onCommentTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext ctx) {
                      return CommonCommentPopUp(
                          ctx: ctx,
                          labelText: stringConstants.addComment,
                          hintText: stringConstants.writeComment.i18n(),
                          controller: spcbViewModel?.queryController,
                          onSubmit: () async {
                            if (ctx.mounted) {
                              Navigator.pop(ctx);
                            }
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
