import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/controllers/retreader/retreader_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/retreader_view_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

class RetreaderViewDataViewmodel extends BaseViewModel {
  final _apiRoutes = APIRoutes();
  final _commonRepo = RetreaderRepository();

  UserTypes? currentUser;
  APIResponse<RetreaderResponseModel?>? _retreaderResponseModel;
  APIResponse<RetreaderResponseModel?>? get retreaderResponseModel =>
      _retreaderResponseModel;
  //RetreadedData? data;
  String? url;
  List<RetreadedData>? data;

  int page = 1;

  void getCurrentUserType(BuildContext context) {
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  final List<int> apiData = List.generate(10, (index) => index);

  bool isLoading = false;

  void loadMoreData() async {
    state = ViewState.busy;
    var res = await getRetreaderData(isPaginating: true);

    state = ViewState.idle;
    updateUI();
  }

  Future<APIResponse<RetreaderResponseModel?>?> getRetreaderData(
      {bool? isPaginating = false}) async {
    state = ViewState.busy;

    try {
      _retreaderResponseModel =
          await _commonRepo.getRetreaderData(getUrl() ?? "", page: "$page");
      if (_retreaderResponseModel?.isSuccess == true) {
        _retreaderResponseModel?.data = RetreaderResponseModel.fromJson(
            _retreaderResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_retreaderResponseModel?.data?.data ?? []);
        } else {
          data = _retreaderResponseModel?.data?.data ?? [];
        }

        //data?.addAll(_retreaderResponseModel?.data?.data ?? [])
      } else {
        HelperFunctions().logger("drfsxrfdesxfdsxf");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return _retreaderResponseModel;
  }

  String? getUrl() {
    switch (MaterialAppViewModel.userTypeEnum) {
      case UserTypes.producer:
        return _apiRoutes.producerDashboardAPIRoute;
      case UserTypes.recycler:
        return _apiRoutes.producerDashboardAPIRoute;
      case UserTypes.retreader:
        return _apiRoutes.retreaderAPIRoute;
      case UserTypes.inspection:
        return _apiRoutes.producerDashboardAPIRoute;
      case UserTypes.admin:
        return _apiRoutes.producerDashboardAPIRoute;
      case UserTypes.custom:
        return _apiRoutes.producerDashboardAPIRoute;
      case UserTypes.other:
        return _apiRoutes.producerDashboardAPIRoute;
      default:
        return null;
    }
  }
}
