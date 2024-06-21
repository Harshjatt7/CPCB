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
  String currentUser = StringConstants.producer;
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
  bool isSubmitEnabled = false;

  Future raiseComplaint(
    BuildContext context,
    String? query,
  ) async {
    state = ViewState.busy;
    SpcbComplaintRequestModel request =
        SpcbComplaintRequestModel(complaint: query, userId: 3);
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
        await performSearch(value, userType: currentUser).then((_) {
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
      searchController.text = "";
    }
    updateUI();
    resetPage();
    state = ViewState.idle;
  }

  void onScrollEnding() {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((currentTabSearchData() ?? 0) > searchPage) {
        searchPage++;
        loadMoreData();
      } else {
        helperFunctions.logger(searchPage.toString());
      }
    } else {
      if ((currentTabData() ?? 0) > page) {
        page++;
        loadMoreData();
      }
    }
  }

  dynamic currentTabSearchData() {
    switch (currentUser) {
      case StringConstants.producer:
        return _spcbSearchResponseModel?.data?.spcbData?.producerData?.data ??
            [];
      case StringConstants.recycler:
        return _spcbSearchResponseModel?.data?.spcbData?.recyclerData?.data ??
            [];
      case StringConstants.retreader:
        return _spcbSearchResponseModel?.data?.spcbData?.retreaderData?.data ??
            [];
    }
  }

  dynamic finalCurrentTabData() {
    switch (currentUser) {
      case StringConstants.producer:
        return producerData;
      case StringConstants.recycler:
        return recyclerData;
      case StringConstants.retreader:
        return retreaderData;
    }
  }

  dynamic currentTabData() {
    switch (currentUser) {
      case StringConstants.producer:
        return _spcbResponseModel?.data?.spcbData?.producerData?.data ?? [];
      case StringConstants.recycler:
        return _spcbResponseModel?.data?.spcbData?.recyclerData?.data ?? [];
      case StringConstants.retreader:
        return _spcbResponseModel?.data?.spcbData?.retreaderData?.data ?? [];
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
          data?.addAll(currentTabSearchData());
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
          isPaginating: true, userType: currentUser);
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
          page: "$page", userType: currentUser.toString());
      if (_spcbResponseModel?.isSuccess == true) {
        _spcbResponseModel?.data = SpcbUsersResponseModel.fromJson(
            _spcbResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(currentTabData());
        } else {
          data = currentTabData();
          if (currentUser == StringConstants.producer) {
            producerData = data;
          } else if (currentUser == StringConstants.recycler) {
            recyclerData = data;
          } else if (currentUser == StringConstants.retreader) {
            retreaderData = data;
          }
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
}
