import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/spcb/spcb_repository.dart';
import 'package:cpcb_tyre/models/request/spcb/spcb_complaint_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/models/response/spcb/spcb_users_list_response_model.dart';
import 'package:cpcb_tyre/utils/helper/debouncing_helper.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class SpcbDashboardViewModel extends BaseViewModel {
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  final helperFunctions = HelperFunctions();
  //String currentUser = AdminUserTypes.producer.text;
  AdminUserTypes currentUserType = AdminUserTypes.producer;
  APIResponse<SpcbUsersResponseModel?>? _spcbResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbResponseModel =>
      _spcbResponseModel;
  APIResponse<SpcbUsersResponseModel?>? _spcbSearchResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbSearchResponseModel =>
      _spcbSearchResponseModel;
  APIResponse<SpcbUsersResponseModel?>? _spcbProducerResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbProducerResponseModel =>
      _spcbProducerResponseModel;
  APIResponse<SpcbUsersResponseModel?>? _spcbSearchProducerResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbSearchProducerResponseModel =>
      _spcbSearchProducerResponseModel;

  APIResponse<SpcbUsersResponseModel?>? _spcbRetResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbRetResponseModel =>
      _spcbRetResponseModel;
  APIResponse<SpcbUsersResponseModel?>? _spcbSearchRetResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbSearchRetResponseModel =>
      _spcbSearchRetResponseModel;

  APIResponse<SpcbUsersResponseModel?>? _spcbRecResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbRecResponseModel =>
      _spcbRecResponseModel;
  APIResponse<SpcbUsersResponseModel?>? _spcbSearchRecResponseModel;
  APIResponse<SpcbUsersResponseModel?>? get spcbSearchRecResponseModel =>
      _spcbSearchRecResponseModel;

  String? url;
  List<Data>? data;
  List<Data>? producerData;
  List<Data>? recyclerData;
  List<Data>? retreaderData;

  List<Data>? producerSearchData;
  List<Data>? recyclerSearchData;
  List<Data>? retreaderSearchData;

  List<Data> tempData = [];
  int page = 1;
  int producerPage = 1;
  int recyclerPage = 1;
  int retreaderPage = 1;
  int searchPage = 1;
  int producerSearchPage = 1;
  int retreaderSearchPage = 1;
  int recyclerSearchPage = 1;
  ScrollController scrollController = ScrollController();
  static final debouncer = Debouncer(milliseconds: 500);
  TextEditingController queryController = TextEditingController();
  final _spcbRepo = SpcbRepository();
  String? complaintError;

  String? producerQueryText = "";
  String? recyclerQueryText = "";
  String? retreaderQueryText = "";

  Future<void> getAllTabsData() async {
    await getSPCBData(userType: AdminUserTypes.producer);
    await getSPCBData(userType: AdminUserTypes.recycler);
    await getSPCBData(userType: AdminUserTypes.retreader);

    await onProducerTab();
  }

  Future raiseComplaint(
    BuildContext context,
    String? query,
    int? userId,
  ) async {
    state = ViewState.busy;
    SpcbComplaintRequestModel request =
        SpcbComplaintRequestModel(complaint: query, userId: userId);
    try {
      APIResponse<AddDataResponseModel>? res = await _spcbRepo.postComplaint(
        request,
      );
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.completeResponse['message'] ?? "");
        }
      } else {
        final apiError = res?.error?.errorsList;
        complaintError = (apiError?.complaint ?? []).isEmpty
            ? ""
            : apiError?.complaint?.first ?? "";
        if (context.mounted) {
          HelperFunctions()
              .commonSuccessSnackBar(context, complaintError ?? "");
        }
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, StringConstants().somethingWentWrong);
      }
    }
    state = ViewState.idle;
    queryController.clear();
    updateUI();
  }

  Future<void> searchSPCB(String value) async {
    debouncer.run(() async {
      if (value.length >= 3) {
        if (searchController.text != getTempQuery()) {
          await performSearch(value, userType: currentUserType.text).then((_) {
            scrollController.jumpTo(0);
          });
        }
      } else {
        data = tempData.isEmpty ? currentTabData() : tempData;
        updateUI();
      }
    });
  }

  Future<void> onProducerTab() async {
    currentUserType = AdminUserTypes.producer;
    scrollController.jumpTo(0);
    if (searchController.text.isEmpty) {
      if (producerData?.isEmpty == true || producerData == null) {
        // await getSPCBData();
      } else {
        data = producerData;
      }
    } else {
      data = producerSearchData;

      if (searchController.text != getTempQuery()) {
        resetCurrentUserPage(isSearch: true);
        await searchSPCB(searchController.text);
        getUpdatedList(isLoad: false);
      }
    }
    updateUI();
  }

  Future<void> onRecyclerTab() async {
    currentUserType = AdminUserTypes.recycler;
    scrollController.jumpTo(0);
    if (searchController.text.isEmpty) {
      if (recyclerData?.isEmpty == true || recyclerData == null) {
        //await getSPCBData();
      } else {
        data = recyclerData;
      }
    } else {
      data = recyclerSearchData;

      if (searchController.text != getTempQuery()) {
        resetCurrentUserPage(isSearch: true);
        await searchSPCB(searchController.text);
        getUpdatedList(isLoad: false);
      }
    }
    updateUI();
  }

  Future<void> onRetreaderTab() async {
    currentUserType = AdminUserTypes.retreader;
    scrollController.jumpTo(0);
    if (searchController.text.isEmpty) {
      if (retreaderData?.isEmpty == true || retreaderData == null) {
        // await getSPCBData();
      } else {
        data = retreaderData;
      }
    } else {
      data = retreaderSearchData;

      if (searchController.text != getTempQuery()) {
        resetCurrentUserPage(isSearch: true);
        await searchSPCB(searchController.text);

        getUpdatedList(isLoad: false);
      }
    }
    updateUI();
  }

  void getUpdatedList({bool isLoad = false}) async {
    state = ViewState.busy;
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      data = tempData.isEmpty ? finalCurrentTabData() : tempData;
      searchController.text = "";
    } else {
      data = currentTabSearchData();
      //searchController.text = "";
    }
    updateUI();
    resetPage();
    state = isLoad == true ? ViewState.busy : ViewState.idle;
  }

  void onScrollEnding() {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      searchPageIncreament();
    } else {
      currentUserPageIncreament();
    }
  }

  int getSearchPage() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        return producerSearchPage;
      case AdminUserTypes.recycler:
        return recyclerSearchPage;
      case AdminUserTypes.retreader:
        return retreaderSearchPage;
    }
  }

  void searchPageIncreament() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        if ((getSearchLastPage() ?? 0) > producerSearchPage) {
          producerSearchPage++;
          loadMoreData();
        } else {
          helperFunctions.logger(producerSearchPage.toString());
        }
        break;
      case AdminUserTypes.recycler:
        if ((getSearchLastPage() ?? 0) > recyclerSearchPage) {
          recyclerSearchPage++;
          loadMoreData();
        } else {
          helperFunctions.logger(recyclerSearchPage.toString());
        }
        break;
      case AdminUserTypes.retreader:
        if ((getSearchLastPage() ?? 0) > retreaderSearchPage) {
          retreaderSearchPage++;
          loadMoreData();
        } else {
          helperFunctions.logger(retreaderSearchPage.toString());
        }
        break;
    }
  }

  int currentUserPageIncreament({AdminUserTypes? userTypes}) {
    switch (userTypes ?? currentUserType) {
      case AdminUserTypes.producer:
        if ((getLastPage(userType: userTypes) ?? 0) > producerPage) {
          producerPage++;
          loadMoreData();
        }
        return producerPage;
      case AdminUserTypes.recycler:
        if ((getLastPage(userType: userTypes) ?? 0) > recyclerPage) {
          recyclerPage++;
          loadMoreData();
        }
        return recyclerPage;
      case AdminUserTypes.retreader:
        if ((getLastPage(userType: userTypes) ?? 0) > retreaderPage) {
          retreaderPage++;
          loadMoreData();
        }
        return retreaderPage;
    }
  }

  void resetCurrentUserPage({bool isSearch = false}) {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        producerPage = isSearch ? producerPage : 1;
        producerSearchPage = isSearch ? 1 : producerSearchPage;
        break;
      case AdminUserTypes.recycler:
        recyclerPage = isSearch ? recyclerPage : 1;
        recyclerSearchPage = isSearch ? 1 : recyclerSearchPage;
        break;
      case AdminUserTypes.retreader:
        retreaderPage = isSearch ? retreaderPage : 1;
        retreaderSearchPage = isSearch ? 1 : retreaderSearchPage;
        break;
    }
  }

  int? getLastPage({AdminUserTypes? userType}) {
    switch (userType ?? currentUserType) {
      case AdminUserTypes.producer:
        return _spcbProducerResponseModel
            ?.data?.spcbData?.producerData?.lastPage;
      case AdminUserTypes.recycler:
        return _spcbRecResponseModel?.data?.spcbData?.recyclerData?.lastPage;
      case AdminUserTypes.retreader:
        return _spcbRetResponseModel?.data?.spcbData?.retreaderData?.lastPage;
      default:
        return null;
    }
  }

  int? getSearchLastPage() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        return _spcbSearchProducerResponseModel
            ?.data?.spcbData?.producerData?.lastPage;
      case AdminUserTypes.recycler:
        return _spcbSearchRecResponseModel
            ?.data?.spcbData?.recyclerData?.lastPage;
      case AdminUserTypes.retreader:
        return _spcbSearchRetResponseModel
            ?.data?.spcbData?.retreaderData?.lastPage;
      default:
        return null;
    }
  }

  List<Data>? currentTabSearchData() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        return _spcbSearchProducerResponseModel
                ?.data?.spcbData?.producerData?.data ??
            [];
      case AdminUserTypes.recycler:
        return _spcbSearchRecResponseModel
                ?.data?.spcbData?.recyclerData?.data ??
            [];
      case AdminUserTypes.retreader:
        return _spcbSearchRetResponseModel
                ?.data?.spcbData?.retreaderData?.data ??
            [];
      default:
        return _spcbSearchProducerResponseModel
                ?.data?.spcbData?.producerData?.data ??
            [];
    }
  }

  List<Data>? finalCurrentTabData() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        return producerData;
      case AdminUserTypes.recycler:
        return recyclerData;
      case AdminUserTypes.retreader:
        return retreaderData;
    }
  }

  List<Data>? currentTabData({AdminUserTypes? userType}) {
    switch (userType ?? currentUserType) {
      case AdminUserTypes.producer:
        return _spcbProducerResponseModel?.data?.spcbData?.producerData?.data ??
            [];
      case AdminUserTypes.recycler:
        return _spcbRecResponseModel?.data?.spcbData?.recyclerData?.data ?? [];
      case AdminUserTypes.retreader:
        return _spcbRetResponseModel?.data?.spcbData?.retreaderData?.data ?? [];
      default:
        return _spcbProducerResponseModel?.data?.spcbData?.producerData?.data ??
            [];
    }
  }

  Future<APIResponse<SpcbUsersResponseModel?>?> performSearch(
    String value, {
    bool? isPaginating = false,
    String? userType,
    bool? isLoad = false,
  }) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _spcbSearchResponseModel = await _spcbRepo.getSpcbUserData(
          userType: userType ?? '',
          searchValue: value,
          page: "${getSearchPage()}");
      if (_spcbSearchResponseModel?.isSuccess == true) {
        _spcbSearchResponseModel?.data = SpcbUsersResponseModel.fromJson(
            _spcbSearchResponseModel?.completeResponse);
        getCurrentSearchResponseModel();
        if (isPaginating == true) {
          data?.addAll(currentTabSearchData() ?? []);
          alreadyObtainSearchData();
        } else {
          data = currentTabSearchData();
          alreadyObtainSearchData();
        }

        assignTempQuery();
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return spcbSearchResponseModel;
  }

  void loadMoreData() async {
    state = ViewState.parallelBusy;
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      await performSearch(searchController.text,
          isPaginating: true, userType: currentUserType.text);
    } else {
      await getSPCBData(isPaginating: true);
      if ((data?.length ?? 0) >= 1) {
        tempData.clear();
        data?.forEach((e) {
          tempData.add(Data(
              addressLine1: e.addressLine1,
              name: e.name,
              regNum: e.regNum,
              registrationDate: e.registrationDate,
              stateName: e.stateName,
              userId: e.userId));
        });
      }
    }
    state = ViewState.idle;
    updateUI();
  }

  void resetPage() {
    if (searchController.text.isEmpty) {
      // searchPage = 1;
      resetCurrentUserPage(isSearch: true);
    } else {
      // page = 1;
      resetCurrentUserPage();
    }
  }

  Future<APIResponse<SpcbUsersResponseModel?>?> getSPCBData(
      {bool? isPaginating = false,
      bool? isLoad = false,
      AdminUserTypes? userType}) async {
    ();
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _spcbResponseModel = await _spcbRepo.getSpcbUserData(
          page: "${currentUserPageIncreament(userTypes: userType)}",
          userType: userType != null ? userType.text : currentUserType.text);

      if (_spcbResponseModel?.isSuccess == true) {
        _spcbResponseModel?.data = SpcbUsersResponseModel.fromJson(
            _spcbResponseModel?.completeResponse);
        getCurrentResponseModel(userType: userType);
        if (isPaginating == true) {
          data?.addAll(currentTabData(userType: userType) ?? []);
        } else {
          data = currentTabData(userType: userType);
          alreadyObtainData(userType: userType);
        }
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = isLoad == true ? ViewState.busy : ViewState.idle;
    return spcbResponseModel;
  }

  void alreadyObtainData({AdminUserTypes? userType}) {
    switch (userType ?? currentUserType) {
      case AdminUserTypes.producer:
        producerData = data;
        break;
      case AdminUserTypes.recycler:
        recyclerData = data;
        break;
      case AdminUserTypes.retreader:
        retreaderData = data;
        break;
    }
  }

  void alreadyObtainSearchData({AdminUserTypes? userType}) {
    switch (userType ?? currentUserType) {
      case AdminUserTypes.producer:
        producerSearchData = data;
        break;
      case AdminUserTypes.recycler:
        recyclerSearchData = data;
        break;
      case AdminUserTypes.retreader:
        retreaderSearchData = data;
        break;
    }
  }

  void getCurrentResponseModel({AdminUserTypes? userType}) {
    switch (userType ?? currentUserType) {
      case AdminUserTypes.producer:
        _spcbProducerResponseModel = _spcbResponseModel;
        break;
      case AdminUserTypes.recycler:
        _spcbRecResponseModel = _spcbResponseModel;
        break;
      case AdminUserTypes.retreader:
        _spcbRetResponseModel = _spcbResponseModel;
        break;
    }
  }

  void getCurrentSearchResponseModel() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        _spcbSearchProducerResponseModel = _spcbSearchResponseModel;
        break;
      case AdminUserTypes.recycler:
        _spcbSearchRecResponseModel = _spcbSearchResponseModel;
        break;
      case AdminUserTypes.retreader:
        _spcbSearchRetResponseModel = _spcbSearchResponseModel;
        break;
    }
  }

  void assignTempQuery() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        producerQueryText = searchController.text;
        break;
      case AdminUserTypes.recycler:
        recyclerQueryText = searchController.text;
        break;
      case AdminUserTypes.retreader:
        retreaderQueryText = searchController.text;
        break;
    }
  }

  String? getTempQuery() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        return producerQueryText;
      case AdminUserTypes.recycler:
        return recyclerQueryText;
      case AdminUserTypes.retreader:
        return retreaderQueryText;
    }
  }

  void emptyTempQuery() {
    producerQueryText = "";
    recyclerQueryText = "";
    retreaderQueryText = "";
    producerSearchData = [];
    recyclerSearchData = [];
    retreaderSearchData = [];
  }
}
