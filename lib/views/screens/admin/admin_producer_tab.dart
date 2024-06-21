import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/producer_epr_oblications_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_dashboard_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_oblication_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AdminProducerTab extends StatelessWidget {
  AdminProducerTab(
      {super.key,
      required this.producerData,
      required this.producerEprOblicationsData,
      required this.adminDashBoardViewmodel});
  final StringConstants stringConstants = StringConstants();
  final HelperFunctions helperFunctions = HelperFunctions();
  final AppColor appColor = AppColor();
  final EPRApplicationData? producerData;
  final EprOblicationsData? producerEprOblicationsData;
  final AdminDashBoardViewmodel adminDashBoardViewmodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          dashBoardHeading(
            context,
            StringConstants.producer,
            stringConstants.eprObligations,
          ),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreManufacturers,
              count: helperFunctions.precisionFormat(
                  producerEprOblicationsData?.newTyreManufacturers)),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreProcuredDomestically,
              count: helperFunctions.precisionFormat(
                  producerEprOblicationsData?.newTyreProducedDomestically)),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImported,
              count: helperFunctions.precisionFormat(
                  producerEprOblicationsData?.newTyreImported)),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImportedWithImportedVehicles,
              count: helperFunctions.precisionFormat(producerEprOblicationsData
                  ?.newTyreImportedAndImportedVehicles)),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImportedExclusively,
              count: helperFunctions.precisionFormat(producerEprOblicationsData
                  ?.newTyreImportedExclusivelyForNewVehiclesManufacturedDomestically)),
          CommonEPROblicationsTile(
              title: stringConstants.wasteTyreImporter,
              count: helperFunctions.precisionFormat(
                  producerEprOblicationsData?.wasteTyreImported)),
          Divider(
            color: AppColor().black10,
          ),
          CommonEPROblicationsTile(
              title: stringConstants.totalLabel,
              count: helperFunctions.precisionFormat(
                  adminDashBoardViewmodel.totalEprObligations())),
          CommonTotalApplicationCard(
            totalApplication: "${producerData?.applications ?? ''}",
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.adminApplicationReceivedRoute,
                  arguments: AdminUserTypes.producer.text);
            },
          ),
          CommonEPRApplication(
            data: producerData,
            userType: StringConstants.producer,
          ),
        ],
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
    );
  }
}
