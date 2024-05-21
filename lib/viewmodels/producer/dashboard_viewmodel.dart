import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/controllers/common/common_repository.dart';
import 'package:cpcb_tyre/models/response/common/dashboard_response_model.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/state_enums.dart';
import '../../models/response/base_response_model.dart';
import '../../utils/helper/helper_functions.dart';

class DashboardViewModel extends BaseViewModel {
  final _apiRoutes = APIRoutes();
  final _commonRepo = CommonRepository();

  UserTypes? currentUser;
  APIResponse<DashboardResponseModel?>? _dashboardResponseModel;
  APIResponse<DashboardResponseModel?>? get dashboardResponseModel =>
      _dashboardResponseModel;
  DashboardData? data;
  String? url;

  void getCurrentUserType(BuildContext context) async {
    await HelperFunctions().getUserType(context);
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  Future<APIResponse<DashboardResponseModel?>?> getDasboardData() async {
    state = ViewState.busy;

    try {
      _dashboardResponseModel =
          await _commonRepo.getDasboardData(getUrl() ?? "");
      if (_dashboardResponseModel?.isSuccess == true) {
        _dashboardResponseModel?.data = DashboardResponseModel.fromJson(
            _dashboardResponseModel?.completeResponse);
        data = _dashboardResponseModel?.data?.data;
      } else {
        HelperFunctions().logger("drfsxrfdesxfdsxf");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return _dashboardResponseModel;
  }

  String? getUrl() {
    switch (MaterialAppViewModel.userTypeEnum) {
      case UserTypes.producer:
        return _apiRoutes.producerDashboardAPIRoute;
      case UserTypes.recycler:
        return _apiRoutes.recyclerDashboardAPIRoute;
      case UserTypes.retreader:
        return _apiRoutes.retreaderDashboardAPIRoute;
      case UserTypes.inspection:
        return '';
      case UserTypes.admin:
        return '';
      case UserTypes.custom:
        return '';
      case UserTypes.other:
        return '';
      default:
        return null;
    }
  }
}


