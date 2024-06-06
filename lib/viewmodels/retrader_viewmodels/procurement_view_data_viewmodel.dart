import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/retreader/retreader_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/procurement_response_model.dart';
import 'package:cpcb_tyre/utils/helper/debouncing_helper.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

class ProcurementViewDataViewModel extends BaseViewModel {
  final _apiRoutes = APIRoutes();
  StringConstants stringConstants = StringConstants();

  final _retreaderRepo = RetreaderRepository();
  APIResponse<ProcurementResponseModel?>? _procurementResponseModel;
  APIResponse<ProcurementResponseModel?>? get procurementResponseModel =>
      _procurementResponseModel;
  APIResponse<ProcurementResponseModel?>? _procurementSearchResponseModel;
  APIResponse<ProcurementResponseModel?>? get procurementSearchResponseModel =>
      _procurementSearchResponseModel;

  ScrollController scrollController = ScrollController();

  List<ProcurementAddData>? data;
  List<ProcurementAddData> tempData = [];

  TextEditingController searchController = TextEditingController();
  static final debouncer = Debouncer(milliseconds: 500);

  int page = 1;
  int searchPage = 1;
  bool isSearchExpanded = false;

  void onScrollEnding() {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((_procurementSearchResponseModel?.data?.meta?.lastPage ?? 0) >
          searchPage) {
        searchPage++;
        loadMoreData();
      } else {
        HelperFunctions().logger(searchPage.toString());
      }
    } else {
      if ((_procurementResponseModel?.data?.meta?.lastPage ?? 0) > page) {
        page++;
        loadMoreData();
      }
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
      data = tempData.isEmpty
          ? _procurementResponseModel?.data?.data ?? []
          : tempData;
      searchController.text = "";
      updateUI();
    } else {
      data = _procurementSearchResponseModel?.data?.data ?? [];
      searchController.text = "";
      updateUI();
    }
    resetPage();

    state = ViewState.idle;
  }

  void loadMoreData() async {
    state = ViewState.busy;
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      await performSearch(searchController.text, isPaginating: true);
    } else {
      await getProcurementData(isPaginating: true);
      tempData.clear();
      data?.forEach((e) {
        tempData.add(ProcurementAddData(
            financeYear: e.financeYear,
            invoiceNumber: e.invoiceNumber,
            isOpeningBalance: e.isOpeningBalance,
            isPublished: e.isPublished,
            openingBalance: e.openingBalance,
            purchasedDate: e.purchasedDate,
            purchasedQuantity: e.purchasedQuantity,
            rawMaterial: e.rawMaterial,
            sellerAddress: e.sellerAddress,
            sellerGstNo: e.sellerGstNo,
            sellerMobile: e.sellerMobile,
            sellerName: e.sellerName));
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

  Future<APIResponse<ProcurementResponseModel?>?> getProcurementData(
      {bool? isPaginating = false}) async {
    state = ViewState.busy;
    try {
      _procurementResponseModel = await _retreaderRepo
          .getProcurementData(getUrl() ?? '', page: "$page");
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
      _procurementSearchResponseModel = await _retreaderRepo.getProcurementData(
          getUrl() ?? '',
          search: value,
          page: '$searchPage');
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

  String? getUrl() {
    switch (MaterialAppViewModel.userTypeEnum) {
      case UserTypes.producer:
        return '';
      case UserTypes.recycler:
        return _apiRoutes.recyclerProcurementDataAPIRoute;
      case UserTypes.retreader:
        return _apiRoutes.retreaderGetProcurementDataAPIRoute;
      case UserTypes.inspection:
        return '';
      case UserTypes.admin:
        return '';
      case UserTypes.custom:
        return '';
      case UserTypes.auditor:
        return '';
      case UserTypes.spcb:
        return '';
      default:
        return null;
    }
  }
}
