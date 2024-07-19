import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/models/response/spcb/spcb_users_list_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_spcb_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../constants/string_constant.dart';
import '../../../viewmodels/spcb/spcb_dashboard_view_model.dart';
import '../../widgets/app_components/commo_comment_pop_up.dart';
import '../../widgets/components/common_single_child_scrollview.dart';

class SpcbCommonTab extends StatelessWidget {
  SpcbCommonTab(
      {super.key,
      required this.data,
      this.onPopUpSubmit,
      required this.viewModel,
      this.showNoMatchingText = false});
  final HelperFunctions helperFunctions = HelperFunctions();
  final AppColor appColor = AppColor();

  final List<Data> data;
  final VoidCallback? onPopUpSubmit;
  final SpcbDashboardViewModel viewModel;
  final bool? showNoMatchingText;

  @override
  Widget build(BuildContext context) {
    final queryController = TextEditingController();
    final stringConstants = StringConstants();
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
        }
        return false;
      },
      child: CommonSingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: (data.isEmpty && showNoMatchingText == false)
                      ? Center(
                          child: CommonTextWidget(
                              viewModel.state == ViewState.busy
                                  ? ""
                                  : MessageConstant().noMatchingResultsFound))
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List<Widget>.generate(data.length, (index) {
                            final applicationData =
                                data.isEmpty ? null : data[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CommonSpcbCard(
                                companyName: applicationData?.name,
                                date: applicationData?.registrationDate,
                                address: applicationData?.addressLine1,
                                state: applicationData?.stateName,
                                applicationNumber: applicationData?.stateName,
                                onCommentTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return CommonCommentPopUp(
                                          ctx: ctx,
                                          controller: queryController,
                                          labelText: stringConstants.addComment,
                                          hintText: stringConstants.writeComment
                                              .i18n(),
                                          onSubmit: () async {
                                            if (ctx.mounted) {
                                              Navigator.pop(ctx);
                                            }
                                            await viewModel.raiseComplaint(
                                                context,
                                                queryController.text,
                                                applicationData?.userId);
                                          });
                                    },
                                  );
                                },
                              ),
                            );
                          }),
                        )),
              if (viewModel.state == ViewState.parallelBusy)
                const Positioned(
                    bottom: 15,
                    left: 16,
                    right: 16,
                    child: Center(child: CircularProgressIndicator())),
            ]),
          ],
        ),
      ),
    );
  }
}
