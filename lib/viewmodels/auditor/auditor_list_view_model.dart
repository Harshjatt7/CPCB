import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/state_enums.dart';
import '../../constants/message_constant.dart';
import '../../controllers/auditor/auditor_repository.dart';
import '../../models/response/auditor/audit_list_response_model.dart';
import '../../models/response/auditor/audit_plan_detail_response_model.dart';
import '../../models/response/base_response_model.dart';

class AuditorListViewModel extends BaseViewModel {
  final helperFunction = HelperFunctions();
  TextEditingController searchController = TextEditingController();
  bool isSearchExpanded = false;
  String groupValue = 'no';
  final appColor = AppColor();
  final stringConstants = StringConstants();
  String? applicationStatus = "";

  APIResponse<AuditPlanListResponseModel?>? _auditPlanListModel;
  APIResponse<AuditPlanListResponseModel?>? get auditPlanListModel =>
      _auditPlanListModel;
  List<AuditPlanListData>? auditPlanListdata;
  final AuditorRepository auditorRepository = AuditorRepository();

  APIResponse<AuditPlanDetailResponseModel?>? _auditPlanDetailModel;
  APIResponse<AuditPlanDetailResponseModel?>? get auditPlanDetailModel =>
      _auditPlanDetailModel;
  List<AuditPlanDetailData>? auditPlanDetaildata;

  Future<APIResponse<AuditPlanDetailResponseModel?>?> getAuditPlanDetail(
      BuildContext context,{String? id}) async {
    state = ViewState.busy;

    try {
      _auditPlanDetailModel = await auditorRepository.getAuditPlanDetail(id);
      if (_auditPlanDetailModel?.isSuccess == true) {
        _auditPlanDetailModel?.data = AuditPlanDetailResponseModel.fromJson(
            _auditPlanDetailModel?.completeResponse);
        auditPlanDetaildata = _auditPlanDetailModel?.data?.data;
      } else {
        if (context.mounted) {
          helperFunction.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunction.logger("$err");
    }

    state = ViewState.idle;

    return _auditPlanDetailModel;
  }

  Future<APIResponse<AuditPlanListResponseModel?>?> getAuditPlanList(
      BuildContext context) async {
    state = ViewState.busy;

    try {
      _auditPlanListModel = await auditorRepository.getAuditPlanListData();
      if (_auditPlanListModel?.isSuccess == true) {
        _auditPlanListModel?.data = AuditPlanListResponseModel.fromJson(
            _auditPlanListModel?.completeResponse);
        auditPlanListdata = _auditPlanListModel?.data?.data;
      } else {
        if (context.mounted) {
          helperFunction.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunction.logger("$err");
    }
    state = ViewState.idle;
    return _auditPlanListModel;
  }

  getStatus(String status) {
    switch (status) {
      case "continue":
        applicationStatus = AuditorStatus.resume.text;
        break;
      case "assigned":
        applicationStatus = AuditorStatus.acknowledge.text;
        break;
      case "started":
        applicationStatus = AuditorStatus.start.text;
        break;
      case "Completed":
        applicationStatus = AuditorStatus.viewReport.text;
        break;
      case "acknowledged":
        applicationStatus = AuditorStatus.acknowledge.text;
        break;  
      default:
        applicationStatus = AuditorStatus.start.text;
        break;
    }
    updateUI();
  }
}
