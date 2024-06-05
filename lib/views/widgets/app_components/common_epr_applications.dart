import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_oblication_tile.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonEPRApplication extends StatelessWidget {
  final String userType;
  const CommonEPRApplication(
      {super.key, required this.userType, required this.data});
  final EPRApplicationData? data;
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
                    StringConstants().eprApplications,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor().black80),
                  )),
              Flexible(
                  flex: 1,
                  child: CommonTextWidget(
                    userType,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor().black80),
                  )),
            ],
          ),
        ),
        CommonEPROblicationsTile(
            title: StringConstants().applicationsUnderProcessAtCPCB,
            count: "${data?.applicationUnderProcess}"),
        CommonEPROblicationsTile(
            title: StringConstants().applicationsUnderEvaluationWithDivision,
            count: "${data?.applicationUnderDh}"),
        CommonEPROblicationsTile(
            title: StringConstants().applicationsApprovedByAuthority,
            count:"${data?.applicationApprovedAuthority}" ),
        CommonEPROblicationsTile(
            title: StringConstants().applicationsRejectedByAuthority,
            count:"${data?.applicationRejectedAuthority}" ),
        CommonEPROblicationsTile(
            title: StringConstants().applicationsAwaitingApprovalAtAuthority,
            count: "${data?.applicationAwaitingApproval}"),
        // CommonEPROblicationsTile(
        //     title: StringConstants().returnForDivision, count:"${data?.applicationUnderDh}"),
        CommonEPROblicationsTile(
            title: StringConstants().applicationPendingAtTheApplicants,
            count: "${data?.applicationPendingApplicant}"),
        CommonEPROblicationsTile(
            title: StringConstants().numberOfRegistrationGrantedToProducers,
            count: "${data?.applicationGranted}"),
      ],
    );
  }
}
