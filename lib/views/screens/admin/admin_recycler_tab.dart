import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/admin/admin_dashboard_viewmodel.dart';
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
      required this.recyclerCommonData,
      required this.adminDashBoardViewmodel});
  final StringConstants stringConstants = StringConstants();
  final EPRApplicationData? recyclerData;
  final CommonEprOblicationData? recyclerCommonData;
  final HelperFunctions helperFunctions = HelperFunctions();
  final AdminDashBoardViewmodel adminDashBoardViewmodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          CommonAdminDashboardHeading(),
          CommonEndProduct(
            title: recyclerCommonData?.reclaimedRubber?.name ?? '',
            generated: helperFunctions.precisionFormat(
                recyclerCommonData?.reclaimedRubber?.earnedCredit),
            transferred: helperFunctions.precisionFormat(
                recyclerCommonData?.reclaimedRubber?.creditTransfered),
          ),
          CommonEndProduct(
              title: recyclerCommonData?.crumbRubber?.name ?? '',
              generated: helperFunctions.precisionFormat(
                  recyclerCommonData?.crumbRubber?.earnedCredit),
              transferred: helperFunctions.precisionFormat(
                  recyclerCommonData?.crumbRubber?.creditTransfered)),
          CommonEndProduct(
            title:
                recyclerCommonData?.crumbRubberModifiedBitumenCrmb?.name ?? '',
            generated: helperFunctions.precisionFormat(recyclerCommonData
                ?.crumbRubberModifiedBitumenCrmb?.earnedCredit),
            transferred: helperFunctions.precisionFormat(recyclerCommonData
                ?.crumbRubberModifiedBitumenCrmb?.creditTransfered),
          ),
          CommonEndProduct(
            title: recyclerCommonData?.recoverCarbon?.name ?? '',
            generated: helperFunctions.precisionFormat(
                recyclerCommonData?.recoverCarbon?.earnedCredit),
            transferred: helperFunctions.precisionFormat(
                recyclerCommonData?.recoverCarbon?.creditTransfered),
          ),
          CommonEndProduct(
              title: recyclerCommonData?.tpoChar?.name ?? '',
              generated: helperFunctions
                  .precisionFormat(recyclerCommonData?.tpoChar?.earnedCredit),
              transferred: helperFunctions.precisionFormat(
                  recyclerCommonData?.tpoChar?.creditTransfered)),
          Divider(
            color: AppColor().black10,
          ),
          CommonEndProduct(
            title: stringConstants.totalLabel,
            generated: helperFunctions.precisionFormat(
                adminDashBoardViewmodel.totalRecyclerGenerated()),
            transferred: helperFunctions.precisionFormat(
                adminDashBoardViewmodel.totalRecyclerTransferred()),
          ),
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
