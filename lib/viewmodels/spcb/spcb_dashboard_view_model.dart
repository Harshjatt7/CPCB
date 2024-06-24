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
  String? url;
  List<Data>? data;
  List<Data>? producerData;
  List<Data>? recyclerData;
  List<Data>? retreaderData;

  List<Data> tempData = [];
  int page = 1;
  int searchPage = 1;
  ScrollController scrollController = ScrollController();
  static final debouncer = Debouncer(milliseconds: 500);
  TextEditingController queryController = TextEditingController();
  final _spcbRepo = SpcbRepository();
  String? complaintError;

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
        await performSearch(value, userType: currentUserType.text).then((_) {
          scrollController.jumpTo(0);
        });
      } else {
        data = tempData.isEmpty ? currentTabData() : tempData;
        updateUI();
      }
    });
  }

  void getUpdatedList() async {
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
    state = ViewState.idle;
  }

  void onScrollEnding() {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((getSearchLastPage() ?? 0) > searchPage) {
        searchPage++;
        loadMoreData();
      } else {
        helperFunctions.logger(searchPage.toString());
      }
    } else {
      if ((getLastPage() ?? 0) > page) {
        page++;
        loadMoreData();
      }
    }
  }

  int? getLastPage(){
    switch(currentUserType){
      case AdminUserTypes.producer:
        return _spcbResponseModel?.data?.spcbData?.producerData?.lastPage;
      case AdminUserTypes.recycler:
        return _spcbResponseModel?.data?.spcbData?.recyclerData?.lastPage;
      case AdminUserTypes.retreader:
        return _spcbResponseModel?.data?.spcbData?.retreaderData?.lastPage ;
      default:
      return null;
    }
  }

  int? getSearchLastPage(){
    switch(currentUserType){
      case AdminUserTypes.producer:
        return _spcbSearchResponseModel?.data?.spcbData?.producerData?.lastPage;
      case AdminUserTypes.recycler:
        return _spcbSearchResponseModel?.data?.spcbData?.recyclerData?.lastPage;
      case AdminUserTypes.retreader:
        return _spcbSearchResponseModel?.data?.spcbData?.retreaderData?.lastPage ;
      default:
      return null;
    }
  }

  List<Data>? currentTabSearchData() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        return _spcbSearchResponseModel?.data?.spcbData?.producerData?.data ??
            [];
      case AdminUserTypes.recycler:
        return _spcbSearchResponseModel?.data?.spcbData?.recyclerData?.data ??
            [];
      case AdminUserTypes.retreader:
        return _spcbSearchResponseModel?.data?.spcbData?.retreaderData?.data ??
            [];
      default:
        return _spcbSearchResponseModel?.data?.spcbData?.producerData?.data ??
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

  List<Data>? currentTabData() {
    switch (currentUserType) {
      case AdminUserTypes.producer:
        return _spcbResponseModel?.data?.spcbData?.producerData?.data ?? [];
      case AdminUserTypes.recycler:
        return _spcbResponseModel?.data?.spcbData?.recyclerData?.data ?? [];
      case AdminUserTypes.retreader:
        return _spcbResponseModel?.data?.spcbData?.retreaderData?.data ?? [];
      default:
        return _spcbResponseModel?.data?.spcbData?.producerData?.data ?? [];
    }
  }

  Future<APIResponse<SpcbUsersResponseModel?>?> performSearch(String value,
      {bool? isPaginating = false, String? userType}) async {
    state = ViewState.busy;
    try {
      _spcbSearchResponseModel = await _spcbRepo.getSpcbUserData(
          userType: userType ?? '',
          searchValue: value,
          page: searchPage.toString());
      if (_spcbSearchResponseModel?.isSuccess == true) {
        _spcbSearchResponseModel?.data = SpcbUsersResponseModel.fromJson(
            _spcbSearchResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(currentTabSearchData() ?? []);
        } else {
          data = currentTabSearchData();
        }
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _spcbSearchResponseModel;
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
      searchPage = 1;
    } else {
      page = 1;
    }
  }

  Future<APIResponse<SpcbUsersResponseModel?>?> getSPCBData(
      {bool? isPaginating = false}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _spcbResponseModel = await _spcbRepo.getSpcbUserData(
          page: "$page", userType: currentUserType.text.toString());
      if (_spcbResponseModel?.isSuccess == true) {
        _spcbResponseModel?.data = SpcbUsersResponseModel.fromJson(
            _spcbResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(currentTabData() ?? []);
        } else {
          data = currentTabData();
          alreadyObtainData();
        }
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _spcbResponseModel;
  }

   void alreadyObtainData(){
    switch(currentUserType){
      case AdminUserTypes.producer:
      producerData=data;
      notifyListeners();
      break;
      case AdminUserTypes.recycler:
      recyclerData=data;
      break;
      case AdminUserTypes.retreader:
      retreaderData=data;
      break;

    }
   }
}
