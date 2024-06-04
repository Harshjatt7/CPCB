import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_oblication_tile.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:cpcb_tyre/views/widgets/components/common_text_widget.dart';
import 'package:flutter/material.dart';

class AdminProducerTab extends StatelessWidget {
  const AdminProducerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
          const CommonTotalApplicationCard(
            totalApplication: '4,564',
            onTap: null,
          ),
          const CommonEPRApplication(
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
