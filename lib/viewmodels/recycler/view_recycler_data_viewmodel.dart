import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/state_enums.dart';
import '../../controllers/recycler/recycler_repository.dart';
import '../../models/response/base_response_model.dart';
import '../../models/response/recycler/get_recycler_data_list_response_model.dart';
import '../../utils/helper/debouncing_helper.dart';
import '../../utils/helper/helper_functions.dart';

class RecyclerDataViewModel extends BaseViewModel {
  final StringConstants stringConstants = StringConstants();
  final MessageConstant messageConstant = MessageConstant();
  final HelperFunctions helperFunctions = HelperFunctions();

  final _recyclerRepo = RecyclerRepository();
  List<RecyclerDataListData>? recyclerData;
  List<RecyclerDataListData> tempData = [];
  int page = 1;
  int searchPage = 1;

  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final debouncer = Debouncer(milliseconds: 500);

  APIResponse<RecyclerDataListResponseModel?>? _recyclerResponseModel;
  APIResponse<RecyclerDataListResponseModel?>? get recyclerResponseModel =>
      _recyclerResponseModel;

  APIResponse<RecyclerDataListResponseModel?>? _recyclerSearchResponseModel;
  APIResponse<RecyclerDataListResponseModel?>?
      get recyclerSearchResponseModel => _recyclerSearchResponseModel;
  Future<APIResponse<RecyclerDataListResponseModel?>?> getRecyclerData(
      {bool? isPaginating = false}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _recyclerResponseModel =
          await _recyclerRepo.getRecyclerData(page: "$page");
      if (_recyclerResponseModel?.isSuccess == true) {
        _recyclerResponseModel?.data = RecyclerDataListResponseModel.fromJson(
            _recyclerResponseModel?.completeResponse);
        if (isPaginating == true) {
          recyclerData?.addAll(_recyclerResponseModel?.data?.data ?? []);
        } else {
          recyclerData = _recyclerResponseModel?.data?.data ?? [];
        }
      } else {
        helperFunctions.logger(messageConstant.errorMessage);
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _recyclerResponseModel;
  }

  Future<APIResponse<RecyclerDataListResponseModel?>?> performRecyclerSearch(
      String value,
      {bool? isPaginating = false}) async {
    state = ViewState.busy;

    try {
      _recyclerSearchResponseModel = await _recyclerRepo.getRecyclerData(
          searchValue: value, page: searchPage.toString());
      if (_recyclerSearchResponseModel?.isSuccess == true) {
        _recyclerSearchResponseModel?.data =
            RecyclerDataListResponseModel.fromJson(
                _recyclerSearchResponseModel?.completeResponse);
        if (isPaginating == true) {
          recyclerData?.addAll(_recyclerSearchResponseModel?.data?.data ?? []);
        } else {
          recyclerData = _recyclerSearchResponseModel?.data?.data ?? [];
        }
      } else {
        helperFunctions.logger(messageConstant.errorMessage);
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _recyclerSearchResponseModel;
  }

  Future<void> searchRecycler(String value) async {
    debouncer.run(() async {
      if (value.length >= 3) {
        await performRecyclerSearch(value).then((_) {
          scrollController.jumpTo(0);
        });
      } else {
        recyclerData = tempData.isEmpty
            ? _recyclerResponseModel?.data?.data ?? []
            : tempData;
        updateUI();
      }
    });
  }

  void getUpdatedList() async {
    state = ViewState.busy;
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      recyclerData = tempData.isEmpty
          ? _recyclerResponseModel?.data?.data ?? []
          : tempData;
      searchController.text = "";
    } else {
      recyclerData = _recyclerSearchResponseModel?.data?.data ?? [];
      searchController.text = "";
    }
    updateUI();
    resetPage();
    state = ViewState.idle;
  }

  void onScrollEnding() {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((_recyclerSearchResponseModel?.data?.meta?.lastPage ?? 0) >
          searchPage) {
        searchPage++;
        loadMoreData();
      } else {
        helperFunctions.logger(searchPage.toString());
      }
    } else {
      if ((_recyclerResponseModel?.data?.meta?.lastPage ?? 0) > page) {
        page++;
        loadMoreData();
      }
    }
  }

  void loadMoreData() async {
    state = ViewState.parallelBusy;
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      await performRecyclerSearch(searchController.text, isPaginating: true);
    } else {
      await getRecyclerData(isPaginating: true);
      if ((recyclerData?.length ?? 0) >= 1) {
        tempData.clear();
        recyclerData?.forEach((e) {
          tempData.add(RecyclerDataListData(
              wasteTyreSupplierName: e.wasteTyreSupplierName,
              recycledDate: e.recycledDate,
              wasteTyreSupplierContact: e.wasteTyreSupplierContact,
              wasteTyreSupplierGst: e.wasteTyreSupplierGst,
              financialYear: e.financialYear,
              typeOfRecycledMaterial: e.typeOfRecycledMaterial,
              //: e.id,
              wasteGeneratedQty: e.wasteGeneratedQty,
              processedQty: e.processedQty,
              producedQty: e.producedQty,
              wasteTyreSupplierAddress: e.wasteTyreSupplierAddress));
        });
      }
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
}
