import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_dashboard_heading.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_end_product.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:flutter/material.dart';

import '../../../constants/enums/enums.dart';
import '../../../constants/routes_constant.dart';

class AdminRetreaderTab extends StatelessWidget {
  AdminRetreaderTab(
      {super.key,
      required this.retreaderData,
      required this.retreaderCommonData});
  final EPRApplicationData? retreaderData;
  final CommonEprOblicationData? retreaderCommonData;
  final HelperFunctions helperFunctions = HelperFunctions();
  final stringConstants = StringConstants();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          CommonAdminDashboardHeading(),
          CommonEndProduct(
            title: retreaderCommonData?.retreadedTyre?.name ?? '',
            generated: helperFunctions.precisionFormat(
                retreaderCommonData?.retreadedTyre?.earnedCredit),
            transferred: helperFunctions.precisionFormat(
                retreaderCommonData?.retreadedTyre?.creditTransfered),
          ),
          CommonTotalApplicationCard(
            title: stringConstants.totalRetreaderApplication,
            totalApplication: "${retreaderData?.applications}",
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.adminApplicationReceivedRoute,
                  arguments: AdminUserTypes.retreader.text);
            },
          ),
          CommonEPRApplication(
            data: retreaderData,
            userType: StringConstants.retreader,
          ),
        ],
      ),
    );
  }
}
