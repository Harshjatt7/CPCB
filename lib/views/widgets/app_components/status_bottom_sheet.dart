import 'package:cpcb_tyre/models/response/auditor/audit_plan_detail_response_model.dart';
import 'package:flutter/material.dart';

import 'auditor_bottom_sheet.dart';

class StatusBottomSheet extends StatelessWidget {
  final AuditPlanDetailData? auditPlanDetail;
  final VoidCallback? onPressed;
  const StatusBottomSheet({super.key, this.onPressed, this.auditPlanDetail});

  @override
  Widget build(BuildContext context) {
    return AuditorBottomSheet(
      status: auditPlanDetail?.status == "completed"
          ? "View Report"
          : auditPlanDetail?.routeData?.name,
      progress: auditPlanDetail?.statusPercentage?.toDouble(),
      unitName: auditPlanDetail?.unitName,
      unitRegisteration: auditPlanDetail?.regNum,
      unitGstin: auditPlanDetail?.gstin,
      unitType: auditPlanDetail?.legalName,
      unitAddress: auditPlanDetail?.address,
      district: auditPlanDetail?.district,
      state: auditPlanDetail?.state,
      currentStatus: auditPlanDetail?.status,
      createdOn: auditPlanDetail?.createdOn,
      startDate: auditPlanDetail?.startDate,
      endDate: auditPlanDetail?.endDate,
      onPressed: onPressed,
    );
  }
}
