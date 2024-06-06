import 'dart:async';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/retreader/retreader_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/retreader_view_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/helper/debouncing_helper.dart';

class RetreaderViewDataViewmodel extends BaseViewModel {
   StringConstants stringConstants = StringConstants();

  final _retreaderRepo = RetreaderRepository();
  UserTypes? currentUser;
  APIResponse<RetreaderResponseModel?>? _retreaderResponseModel;
  APIResponse<RetreaderResponseModel?>? get retreaderResponseModel =>
      _retreaderResponseModel;
  APIResponse<RetreaderResponseModel?>? _retreaderSearchResponseModel;
  APIResponse<RetreaderResponseModel?>? get retreaderSearchResponseModel =>
      _retreaderSearchResponseModel;
  String? url;
  List<RetreadedData>? data;
  List<RetreadedData> tempData = [];
  int page = 1;
  int searchPage = 1;
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  static final debouncer = Debouncer(milliseconds: 500);
  void getCurrentUserType(BuildContext context) {
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  void searchRetreader(String value) {
    debouncer.run(() {
      if (value.length >= 3) {
        // performSearch(value).then((_) {
        //   scrollController.jumpTo(0);
        // });
      } else {
        data = _retreaderResponseModel?.data?.data ?? [];
        updateUI();
      }
    });
  }

  void getUpdatedList() async {
    state = ViewState.busy;
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      data = tempData.isEmpty
          ? _retreaderResponseModel?.data?.data ?? []
          : tempData;
      searchController.text = "";
    } else {
      data = _retreaderSearchResponseModel?.data?.data ?? [];
      searchController.text = "";
    }
    updateUI();
    resetPage();
    state = ViewState.idle;
  }

  void onScrollEnding() {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((_retreaderSearchResponseModel?.data?.meta?.lastPage ?? 0) >
          searchPage) {
        searchPage++;
        loadMoreData();
      } else {
        HelperFunctions().logger(searchPage.toString());
      }
    } else {
      if ((_retreaderResponseModel?.data?.meta?.lastPage ?? 0) > page) {
        page++;
        loadMoreData();
      }
    }
  }

  Future<APIResponse<RetreaderResponseModel?>?> performSearch(String value,
      {bool? isPaginating = false}) async {
    state = ViewState.busy;

    try {
      _retreaderSearchResponseModel = await _retreaderRepo.getRetreaderData(
          searchValue: value, page: searchPage.toString());
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

  void loadMoreData() async {
    state = ViewState.busy;
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      await performSearch(searchController.text, isPaginating: true);
    } else {
      await getRetreaderData(isPaginating: true);
      tempData.clear();
      data?.forEach((e) {
        tempData.add(RetreadedData(
            wasteTyreSupplierName: e.wasteTyreSupplierName,
            retreadedDate: e.retreadedDate,
            contactDetails: e.contactDetails,
            gstNumber: e.gstNumber,
            financialYear: e.financialYear,
            typeOfRawMaterial: e.typeOfRawMaterial,
            id: e.id,
            quantityOfWasteGenerated: e.quantityOfWasteGenerated,
            quantityProcessed: e.quantityProcessed,
            quantityProduced: e.quantityProduced,
            addressOfWasteTyreSupplier: e.addressOfWasteTyreSupplier));
      });
    }
    state = ViewState.idle;
    updateUI();
  }

  void resetPage() {
    if (searchController.text.isEmpty) {
      searchPage = 1;
    } else {
      page = 1;
    }
  }

  Future<APIResponse<RetreaderResponseModel?>?> getRetreaderData(
      {bool? isPaginating = false}) async {
    state = ViewState.busy;
    try {
      _retreaderResponseModel =
          await _retreaderRepo.getRetreaderData(page: "$page");
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
}
