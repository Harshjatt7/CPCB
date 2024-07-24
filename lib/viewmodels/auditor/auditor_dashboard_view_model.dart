import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/auditor/auditor_repository.dart';
import 'package:cpcb_tyre/models/response/auditor/auditor_dashboard_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class AuditorDashboardViewModel extends BaseViewModel {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController previousStartDateController = TextEditingController();
  TextEditingController previousEndDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String? groupValue = 'no';
  bool isSearchExpanded = false;
  final stringConstants = StringConstants();
  final appColor = AppColor();
  APIResponse<AuditorDashBoardResponseModel?>? _dashboardResponseModel;
  APIResponse<AuditorDashBoardResponseModel?>? get dashboardResponseModel =>
      _dashboardResponseModel;
  AuditorDashboardData? data;
  HelperFunctions helperFunctions = HelperFunctions();
  final AuditorRepository auditorRepository = AuditorRepository();

  void assignTextEditingControllers() {
    previousStartDateController.text = "2024/02/10";
    previousEndDateController.text = "2024/02/10";
  }

  Future<APIResponse<AuditorDashBoardResponseModel?>?> getDasboardData(
      BuildContext context) async {
    state = ViewState.busy;

    try {
      _dashboardResponseModel = await auditorRepository.getDasboardData();
      if (_dashboardResponseModel?.isSuccess == true) {
        _dashboardResponseModel?.data = AuditorDashBoardResponseModel.fromJson(
            _dashboardResponseModel?.completeResponse);
        data = _dashboardResponseModel?.data?.data;
      } else {
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _dashboardResponseModel;
  }
}
