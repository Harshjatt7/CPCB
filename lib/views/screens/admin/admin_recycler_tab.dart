import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_dashboard_heading.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_end_product.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:flutter/material.dart';

class AdminRecyclerTab extends StatelessWidget {
  const AdminRecyclerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const CommonAdminDashboardHeading(),
          CommonEndProduct(
              title: StringConstants().reclaimedRubber,
              generated: '898',
              transferred: '989'),
          CommonEndProduct(
              title: StringConstants().recoverCarbon,
              generated: '8986766',
              transferred: '98967676'),
          CommonEndProduct(
              title: StringConstants().crumbRubber,
              generated: '898',
              transferred: '989'),
          CommonEndProduct(
              title: StringConstants().tpoChar,
              generated: '898',
              transferred: '989'),
          CommonEndProduct(
              title: StringConstants().crumbRubberModified,
              generated: '898',
              transferred: '989'),
          const CommonTotalApplicationCard(
            totalApplication: '4,564',
            onTap: null,
          ),
          const CommonEPRApplication(
            userType: StringConstants.recycler,
          ),
        ],
      ),
    );
  }
}
