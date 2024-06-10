import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_dashboard_heading.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_end_product.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:flutter/material.dart';
import '../../../constants/routes_constant.dart';

class AdminRecyclerTab extends StatelessWidget {
  AdminRecyclerTab(
      {super.key,
      required this.recyclerData,
      required this.recyclerCommonData});
  final StringConstants stringConstants = StringConstants();
  final EPRApplicationData? recyclerData;
  final CommonEprOblicationData? recyclerCommonData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
           CommonAdminDashboardHeading(),
          CommonEndProduct(
              title: recyclerCommonData?.reclaimedRubber?.name ?? '',
              generated:
                  '${recyclerCommonData?.reclaimedRubber?.earnedCredit ?? ''}',
              transferred:
                  '${recyclerCommonData?.reclaimedRubber?.creditTransfered ?? ''}'),
          CommonEndProduct(
              title: recyclerCommonData?.recoverCarbon?.name ?? '',
              generated:
                  '${recyclerCommonData?.recoverCarbon?.earnedCredit ?? ''}',
              transferred:
                  '${recyclerCommonData?.recoverCarbon?.creditTransfered ?? ''}'),
          CommonEndProduct(
              title: recyclerCommonData?.crumbRubber?.name ?? '',
              generated:
                  '${recyclerCommonData?.crumbRubber?.earnedCredit ?? ''}',
              transferred:
                  '${recyclerCommonData?.crumbRubber?.creditTransfered ?? ''}'),
          CommonEndProduct(
              title: recyclerCommonData?.tpoChar?.name ?? '',
              generated: '${recyclerCommonData?.tpoChar?.earnedCredit ?? ''}',
              transferred:
                  '${recyclerCommonData?.tpoChar?.creditTransfered ?? ''}'),
          CommonEndProduct(
              title: recyclerCommonData?.crumbRubberModifiedBitumenCrmb?.name ??
                  '',
              generated:
                  '${recyclerCommonData?.crumbRubberModifiedBitumenCrmb?.earnedCredit ?? ''}',
              transferred:
                  '${recyclerCommonData?.crumbRubberModifiedBitumenCrmb?.creditTransfered ?? ''}'),
          CommonTotalApplicationCard(
            totalApplication: "${recyclerData?.applications}",
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.adminApplicationReceivedRoute,
                  arguments: AdminUserTypes.recycler.text);
            },
          ),
          CommonEPRApplication(
            data: recyclerData,
            userType: StringConstants.recycler,
          ),
        ],
      ),
    );
  }
}
