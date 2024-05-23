import 'dart:async';

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
import 'package:flutter/widgets.dart';

import '../../utils/helper/debouncing_helper.dart';

class RetreaderViewDataViewmodel extends BaseViewModel {
  final _apiRoutes = APIRoutes();
  final _retreaderRepo = RetreaderRepository();
  UserTypes? currentUser;
  APIResponse<RetreaderResponseModel?>? _retreaderResponseModel;
  APIResponse<RetreaderResponseModel?>? get retreaderResponseModel =>
      _retreaderResponseModel;
  APIResponse<RetreaderResponseModel?>? _retreaderSearchResponseModel;
  APIResponse<RetreaderResponseModel?>? get retreaderSearchResponseModel =>
      _retreaderResponseModel;
  //RetreadedData? data;
  String? url;
  List<RetreadedData>? data;

  int page = 1;
  bool isSearchExpanded = false;

  TextEditingController searchController = TextEditingController();
  static final debouncer = Debouncer(milliseconds: 500);

  void getCurrentUserType(BuildContext context) {
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  void searchRetreader(String value) {
    debouncer.run(() {
      if (value.length >= 3) {
        performSearch(value);
      } else {
        data = _retreaderResponseModel?.data?.data ?? [];
        updateUI();
      }
    });
  }

  void getUpdatedList() {
    state = ViewState.busy;
    searchController.text = "";
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      data = _retreaderResponseModel?.data?.data ?? [];
      _retreaderSearchResponseModel = null;
      HelperFunctions().logger(data.toString());
      updateUI();
    } else {
      data = _retreaderSearchResponseModel?.data?.data ?? [];
      updateUI();
    }
    state = ViewState.idle;
  }

  void onScrollEnding() {
    if ((retreaderResponseModel?.data?.meta?.lastPage ?? 0) >= page) {
      page++;
      loadMoreData();
    }
  }

  Future<APIResponse<RetreaderResponseModel?>?> performSearch(String value,
      {bool? isPaginating = false}) async {
    state = ViewState.busy;
    // data?.clear();
    try {
      _retreaderSearchResponseModel = await _retreaderRepo
          .getRetreaderData(getUrl() ?? "", searchValue: value);
      if (_retreaderSearchResponseModel?.isSuccess == true) {
        _retreaderSearchResponseModel?.data = RetreaderResponseModel.fromJson(
            _retreaderSearchResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_retreaderSearchResponseModel?.data?.data ?? []);
        } else {
          data = _retreaderSearchResponseModel?.data?.data ?? [];
        }
      } else {
        HelperFunctions().logger("No response");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;
    return _retreaderSearchResponseModel;
  }

  bool isLoading = false;
  void loadMoreData() async {
    state = ViewState.busy;
    await getRetreaderData(isPaginating: true);
    state = ViewState.idle;
    updateUI();
  }

  Future<APIResponse<RetreaderResponseModel?>?> getRetreaderData(
      {bool? isPaginating = false}) async {
    state = ViewState.busy;

    try {
      _retreaderResponseModel =
          await _retreaderRepo.getRetreaderData(getUrl() ?? "", page: "$page");
      if (_retreaderResponseModel?.isSuccess == true) {
        _retreaderResponseModel?.data = RetreaderResponseModel.fromJson(
            _retreaderResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_retreaderResponseModel?.data?.data ?? []);
        } else {
          data = _retreaderResponseModel?.data?.data ?? [];
        }
      } else {
        HelperFunctions().logger("No response");
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
