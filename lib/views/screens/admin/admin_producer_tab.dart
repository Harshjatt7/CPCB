import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_oblication_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AdminProducerTab extends StatelessWidget {
  AdminProducerTab(
      {super.key,
      required this.producerData,
      required this.producerEprOblicationsData});
  final StringConstants stringConstants = StringConstants();
  final EPRApplicationData? producerData;
  final EprOblicationsData? producerEprOblicationsData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          dashBoardHeading(context, stringConstants.eprOblications,
              StringConstants.producer),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreManufacturers,
              count:
                  "${producerEprOblicationsData?.newTyreManufacturers ?? ''}"),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreProducedDomestically,
              count:
                  "${producerEprOblicationsData?.newTyreProducedDomestically ?? ''}"),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImported,
              count: producerEprOblicationsData?.newTyreImported?.toStringAsFixed(1) ?? ''),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImportedAndImportedVehicles,
              count:
                  "${producerEprOblicationsData?.newTyreImportedAndImportedVehicles ?? ''}"),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImportedExclusively,
              count:
                  "${producerEprOblicationsData?.newTyreImportedExclusivelyForNewVehiclesManufacturedDomestically ?? ''}"),
          CommonEPROblicationsTile(
              title: stringConstants.wasteTyreImporter,
              count: "${producerEprOblicationsData?.wasteTyreImported ?? ''}"),
          CommonTotalApplicationCard(
            totalApplication: "${producerData?.applications ?? ''}",
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.adminApplicationReceivedRoute);
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
