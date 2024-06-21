import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_oblication_tile.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonEPRApplication extends StatelessWidget {
  final String userType;
  final EPRApplicationData? data;
  final StringConstants stringConstants = StringConstants();
  final AppColor appColor=AppColor();
   CommonEPRApplication(
      {super.key, required this.userType, required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 2,
                  child: CommonTextWidget(
                    stringConstants.eprApplications,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: appColor.black80),
                  )),
              Flexible(
                  flex: 1,
                  child: CommonTextWidget(
                    userType,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: appColor.black80),
                  )),
            ],
          ),
        ),
        CommonEPROblicationsTile(
            title: stringConstants.applicationsUnderProcess,
            count: "${data?.applicationUnderProcess ?? ''}"),
        CommonEPROblicationsTile(
            title: stringConstants.applicationsUnderEvaluationWithDivision,
            count: "${data?.applicationUnderDh ?? ''}"),
        CommonEPROblicationsTile(
            title: stringConstants.applicationsApprovedByAuthority,
            count: "${data?.applicationApprovedAuthority ?? ''}"),
        CommonEPROblicationsTile(
            title: stringConstants.applicationsRejectedByAuthority,
            count: "${data?.applicationRejectedAuthority ?? ''}"),
        CommonEPROblicationsTile(
            title: stringConstants.applicationsAwaitingApprovalAtAuthority,
            count: "${data?.applicationAwaitingApproval ?? ''}"),
        // CommonEPROblicationsTile(
        //     title: stringConstants.returnForDivision, count:"${data?.applicationUnderDh}"),
        CommonEPROblicationsTile(
            title: stringConstants.applicationPendingAtApplicants,
            count: "${data?.applicationPendingApplicant ?? ''}"),
        CommonEPROblicationsTile(
            title: stringConstants.eprRegistrationGranted,
            count: "${data?.applicationGranted ?? ''}"),
      ],
    );
  }
}
