import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/admin/admin_repository.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../constants/enums/state_enums.dart';
import '../../constants/message_constant.dart';
import '../../models/response/admin/admin_application_response_model.dart';
import '../../models/response/base_response_model.dart';
import '../../utils/helper/debouncing_helper.dart';
import '../../utils/helper/helper_functions.dart';

class AdminApplicationViewModel extends BaseViewModel {
  final MessageConstant messageConstant = MessageConstant();
  final StringConstants stringConstants = StringConstants();
  final HelperFunctions helperFunctions=HelperFunctions();
  TextEditingController searchController = TextEditingController();
  final _adminRepo = AdminRepository();
  ScrollController scrollController = ScrollController();
  APIResponse<AdminApplicationResponseModel?>? _adminApplicationResponseModel;
  APIResponse<AdminApplicationResponseModel?>?
      get adminApplicationResponseModel => _adminApplicationResponseModel;
  List<ApplicationResponsedData>? data;
  List<ApplicationResponsedData> tempData = [];
  int page = 1;
  int searchPage = 1;
  final debouncer = Debouncer(milliseconds: 500);
  bool isSearchExpanded = false;
  APIResponse<AdminApplicationResponseModel?>? _adminApplicationSearchModel;
  APIResponse<AdminApplicationResponseModel?>?
      get recyclerSearchResponseModel => _adminApplicationSearchModel;

  void loadMoreData(String? userType) async {
    state = ViewState.busy;

    await getApplicationData(isPaginating: true, userType ?? "");
    tempData.clear();
    data?.forEach((e) {
      tempData.add(ApplicationResponsedData(
        companyName: e.companyName,
        firstReceived: e.firstReceived,
        id: e.id,
        lastMarked: e.lastMarked,
        lastReceived: e.lastReceived,
        markedBy: e.markedBy,
        markedTo: e.markedTo,
        status: e.status,
        userId: e.userId,
      ));
    });

    state = ViewState.idle;
    updateUI();
  }

  Future<APIResponse<AdminApplicationResponseModel?>?> getApplicationData(
      String userType,
      {bool? isPaginating = false}) async {
    state = ViewState.busy;
    try {
      _adminApplicationResponseModel = await _adminRepo.getApplicationData(
          userType: userType, page: "$page");
      if (_adminApplicationResponseModel?.isSuccess == true) {
        _adminApplicationResponseModel?.data =
            AdminApplicationResponseModel.fromJson(
                _adminApplicationResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_adminApplicationResponseModel?.data?.data ?? []);
        } else {
          data = _adminApplicationResponseModel?.data?.data ?? [];
        }
      } else {
        helperFunctions.logger(messageConstant.errorMessage);
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _adminApplicationResponseModel;
  }

  Future<APIResponse<AdminApplicationResponseModel?>?> performAdminSearch(
      String? userType, String value,
      {bool? isPaginating = false}) async {
    state = ViewState.busy;
    try {
      _adminApplicationSearchModel = await _adminRepo.getApplicationData(
          userType: userType, search: value, page: "$searchPage");
      if (_adminApplicationSearchModel?.isSuccess == true) {
        _adminApplicationSearchModel?.data =
            AdminApplicationResponseModel.fromJson(
                _adminApplicationSearchModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_adminApplicationSearchModel?.data?.data ?? []);
        } else {
          data = _adminApplicationSearchModel?.data?.data ?? [];
        }
        state = ViewState.idle;
      } else {
        helperFunctions.logger(messageConstant.errorMessage);
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }
    state = ViewState.idle;
    return null;
  }

  Future getDownloadPaymentReceipt(BuildContext context, String userId) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _adminRepo.getAdminPaymentReceipt(userId);
      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: stringConstants.transaction, response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;

        if (context.mounted) {
          helperFunctions
              .commonErrorSnackBar(context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _adminApplicationSearchModel;
  }

  Future<void> searchRetreader(String value, String? userType) async {
    debouncer.run(() async {
      if (value.length >= 3) {
        await performAdminSearch(userType, value).then((_) {
          scrollController.jumpTo(0);
        });
      } else {
        data = _adminApplicationResponseModel?.data?.data ?? [];
        updateUI();
      }
    });
  }

  void getUpdatedList() async {
    state = ViewState.busy;
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      data = tempData.isEmpty
          ? _adminApplicationResponseModel?.data?.data ?? []
          : tempData;
      searchController.text = "";
    } else {
      data = _adminApplicationSearchModel?.data?.data ?? [];
      searchController.text = "";
    }

    state = ViewState.idle;
    updateUI();
    resetPage();
  }

  void onScrollEnding(String? userType) {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((_adminApplicationSearchModel?.data?.meta?.lastPage ?? 0) >
          searchPage) {
        searchPage++;
        loadMoreData(userType);
      } else {
        helperFunctions.logger(searchPage.toString());
      }
    } else {
      if ((_adminApplicationResponseModel?.data?.meta?.lastPage ?? 0) > page) {
        page++;
        loadMoreData(userType);
      }
    }
  }

  void resetPage() {
    if (searchController.text.isEmpty) {
      searchPage = 1;
    } else {
      page = 1;
    }
  }

  Future getDownloadApplication(BuildContext context, String id) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _adminRepo.getAdminDownloadApplication(id);
      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: stringConstants.application, response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;

        if (context.mounted) {
          helperFunctions
              .commonErrorSnackBar(context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      if (context.mounted) {
        helperFunctions
            .commonErrorSnackBar(context, stringConstants.somethingWentWrong);
      }
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;

    return null;
  }
}
