import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_admin_dashboard_heading.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_end_product.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_epr_applications.dart';
import 'package:cpcb_tyre/views/widgets/app_components/common_total_application_card.dart';
import 'package:flutter/material.dart';

class AdminRetreaderTab extends StatelessWidget {
  const AdminRetreaderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const CommonAdminDashboardHeading(),
          CommonEndProduct(
              title: StringConstants().retreadedTyre,
              generated: '898',
              transferred: '989'),
          const CommonTotalApplicationCard(
            totalApplication: '4,564',
            onTap: null,
          ),
           CommonEPRApplication(
            userType: StringConstants().retrader,
          ),
        ],
      ),
    );
  }
}
