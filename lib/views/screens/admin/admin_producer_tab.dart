import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_oblication_tile.dart';
import 'package:cpcb_tyre/views/widgets/components/common_image_widget.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AdminProucerTab extends StatelessWidget {
  const AdminProucerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            dashBoardHeading(context, StringConstants().eprOblications,
                StringConstants.producer),
            CommonEPROblicationsTile(
                title: StringConstants().newTyreManufacturers, count: '1321'),
            CommonEPROblicationsTile(
                title: StringConstants().newTyreProducedDomestically,
                count: '1321'),
            CommonEPROblicationsTile(
                title: StringConstants().newTyreImported, count: '1321'),
            CommonEPROblicationsTile(
                title: StringConstants().newTyreImportedAndImportedVehicles,
                count: '1321'),
            CommonEPROblicationsTile(
                title: StringConstants().newTyreImportedExclusively,
                count: '1321'),
            CommonEPROblicationsTile(
                title: StringConstants().wasteTyreImporter, count: '1321'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CommonTextWidget(
                  StringConstants().totalApplicationReceived,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstants().dashboardBackGround),
                      fit: BoxFit.contain)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 95, vertical: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColor().darkGreen, width: 7)),
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                CommonImageWidget(
                                    imageSource: ImageConstants().statsIcon,
                                    isNetworkImage: false),
                                CommonTextWidget(
                                  '4,564',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 32,
                                          color: AppColor().darkGreen),
                                ),
                                CommonTextWidget(
                                  StringConstants().totalApplication,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            dashBoardHeading(context, StringConstants().eprOblications,
                StringConstants.producer),
            CommonEPROblicationsTile(
                title: StringConstants().applicationsUnderProcessAtCPCB,
                count: '131'),
            CommonEPROblicationsTile(
                title:
                    StringConstants().applicationsUnderEvaluationWithDivision,
                count: '125'),
            CommonEPROblicationsTile(
                title: StringConstants().applicationsApprovedByAuthority,
                count: '131'),
            CommonEPROblicationsTile(
                title: StringConstants().applicationsRejectedByAuthority,
                count: '131'),
            CommonEPROblicationsTile(
                title:
                    StringConstants().applicationsAwaitingApprovalAtAuthority,
                count: '131'),
            CommonEPROblicationsTile(
                title: StringConstants().returnForDivision, count: '131'),
            CommonEPROblicationsTile(
                title: StringConstants().applicationPendingAtTheApplicants,
                count: '131'),
            CommonEPROblicationsTile(
                title: StringConstants().numberOfRegistrationGrantedToProducers,
                count: '131'),
          ],
        ),
      ),
    );
  }

  Padding dashBoardHeading(
      BuildContext context, String title, String userType) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 2,
              child: CommonTextWidget(
                title,
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
    );
  }
}
