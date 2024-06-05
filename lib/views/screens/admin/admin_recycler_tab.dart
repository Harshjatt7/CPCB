import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_dashboard_heading.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_end_product.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:flutter/material.dart';

class AdminRecyclerTab extends StatelessWidget {
  AdminRecyclerTab({super.key,required this.recyclerData});
  final StringConstants stringConstants = StringConstants();
  final EPRApplicationData? recyclerData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const CommonAdminDashboardHeading(),
          CommonEndProduct(
              title: stringConstants.reclaimedRubber,
              generated: '898',
              transferred: '989'),
          CommonEndProduct(
              title: stringConstants.recoverCarbon,
              generated: '8986766',
              transferred: '98967676'),
          CommonEndProduct(
              title: stringConstants.crumbRubber,
              generated: '898',
              transferred: '989'),
          CommonEndProduct(
              title: stringConstants.tpoChar,
              generated: '898',
              transferred: '989'),
          CommonEndProduct(
              title: stringConstants.crumbRubberModified,
              generated: '898',
              transferred: '989'),
           CommonTotalApplicationCard(
            totalApplication: "${recyclerData?.applications}",
            onTap: null,
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
