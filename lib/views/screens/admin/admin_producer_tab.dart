import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_oblication_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AdminProducerTab extends StatelessWidget {
  AdminProducerTab({super.key, required this.producerData, this.userType});
  final StringConstants stringConstants = StringConstants();
  final EPRApplicationData? producerData;
  final String? userType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          dashBoardHeading(context, stringConstants.eprOblications,
              StringConstants.producer),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreManufacturers, count: '1321'),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreProducedDomestically,
              count: '1321'),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImported, count: '1321'),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImportedAndImportedVehicles,
              count: '1321'),
          CommonEPROblicationsTile(
              title: stringConstants.newTyreImportedExclusively, count: '1321'),
          CommonEPROblicationsTile(
              title: stringConstants.wasteTyreImporter, count: '1321'),
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
