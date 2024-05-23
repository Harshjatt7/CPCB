import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/controllers/retreader/procurement_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/procurement_response_model.dart';
import 'package:cpcb_tyre/utils/helper/debouncing_helper.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class ProcurementViewDataViewModel extends BaseViewModel {
  final _procurementRepo = ProcurementRepository();
  APIResponse<ProcurementResponseModel?>? _procurementResponseModel;
  APIResponse<ProcurementResponseModel?>? get procurementResponseModel =>
      _procurementResponseModel;
  APIResponse<ProcurementResponseModel?>? _procurementSearchResponseModel;
  APIResponse<ProcurementResponseModel?>? get procurementSearchResponseModel =>
      _procurementSearchResponseModel;

  List<ProcurementAddData>? data;
  TextEditingController searchController = TextEditingController();
  static final debouncer = Debouncer(milliseconds: 500);

  int page = 1;
  bool isSearchExpanded = false;

  void onScrollEnding() {
    if ((procurementResponseModel?.data?.meta?.lastPage ?? 0) > page) {
      page++;
      loadMoreData();
    }
  }

  void searchProcurement(String value) {
    debouncer.run(() {
      if (value.length >= 3) {
        performSearch(value);
      } else {
        data = _procurementResponseModel?.data?.data ?? [];
        updateUI();
      }
    });
  }

  void getUpdatedList() {
    state = ViewState.busy;
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      data = _procurementResponseModel?.data?.data ?? [];
      searchController.text = "";
      updateUI();
    } else {
      data = _procurementSearchResponseModel?.data?.data ?? [];
      searchController.text = "";
      updateUI();
    }
    state = ViewState.idle;
  }

  void loadMoreData() async {
    state = ViewState.busy;
    await getProcurementData(isPaginating: true);
    state = ViewState.idle;
    updateUI();
  }

  Future<APIResponse<ProcurementResponseModel?>?> getProcurementData(
      {bool? isPaginating = false}) async {
    state = ViewState.busy;

    try {
      _procurementResponseModel =
          await _procurementRepo.getProcurementData(page: "$page");
      if (_procurementResponseModel?.isSuccess == true) {
        _procurementResponseModel?.data = ProcurementResponseModel.fromJson(
            _procurementResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_procurementResponseModel?.data?.data ?? []);
        } else {
          data = _procurementResponseModel?.data?.data ?? [];
        }
      } else {
        HelperFunctions().logger("No response");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;

    return _procurementResponseModel;
  }

  Future<APIResponse<ProcurementResponseModel?>?> performSearch(String value,
      {bool? isPaginating = false}) async {
    state = ViewState.busy;
    try {
      _procurementSearchResponseModel =
          await _procurementRepo.getProcurementData(searchValue: value);
      if (_procurementSearchResponseModel?.isSuccess == true) {
        _procurementSearchResponseModel?.data =
            ProcurementResponseModel.fromJson(
                _procurementSearchResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_procurementSearchResponseModel?.data?.data ?? []);
        } else {
          data = _procurementSearchResponseModel?.data?.data ?? [];
        }
      } else {
        HelperFunctions().logger("No response");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }

    state = ViewState.idle;
    return _procurementSearchResponseModel;
  }
}
