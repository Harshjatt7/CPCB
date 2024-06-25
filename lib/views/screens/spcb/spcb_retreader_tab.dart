import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../viewmodels/spcb/spcb_dashboard_view_model.dart';
import '../../widgets/app_components/commo_comment_pop_up.dart';
import '../../widgets/app_components/common_spcb_card.dart';

class SpcbRetreaderTab extends StatelessWidget {
  const SpcbRetreaderTab({super.key, required this.spcbViewModel});
  final SpcbDashboardViewModel spcbViewModel;

  @override
  Widget build(BuildContext context) {
    final stringConstants = StringConstants();
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
          spcbViewModel.onScrollEnding();
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: spcbViewModel.scrollController,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: (spcbViewModel.data?.length ?? 0) == 0
                    ? Center(
                        child: CommonTextWidget(
                            MessageConstant().noMatchingResultsFound))
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List<Widget>.generate(
                            spcbViewModel.data?.length ?? 0, (index) {
                          final applicationData = spcbViewModel.data?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CommonSpcbCard(
                              companyName: applicationData?.name,
                              date: applicationData?.registrationDate,
                              address: applicationData?.addressLine1,
                              state: applicationData?.stateName,
                              applicationNumber: applicationData?.regNum,
                              onCommentTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return CommonCommentPopUp(
                                        ctx: ctx,
                                        controller:
                                            spcbViewModel.queryController,
                                        labelText: stringConstants.addComment,
                                        hintText: stringConstants.writeComment.i18n(),
                                        onSubmit: () async {
                                          if (ctx.mounted) {
                                            Navigator.pop(ctx);
                                          }
                                          await spcbViewModel.raiseComplaint(
                                              context,
                                              spcbViewModel
                                                  .queryController.text,
                                              applicationData?.userId);
                                        });
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      )),
          ],
        ),
      ),
    );
  }
}
