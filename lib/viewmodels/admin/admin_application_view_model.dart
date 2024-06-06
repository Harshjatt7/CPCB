import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/admin/admin_repository.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../constants/enums/state_enums.dart';
import '../../models/response/admin/admin_application_response_model.dart';
import '../../models/response/base_response_model.dart';
import '../../utils/helper/helper_functions.dart';

class AdminApplicationViewModel extends BaseViewModel {
  TextEditingController searchController = TextEditingController();
  bool isSearchExpanded = false;
  final _adminRepo = AdminRepository();
  ScrollController scrollController = ScrollController();
  APIResponse<AdminApplicationResponseModel?>? _adminApplicationResponseModel;
  APIResponse<AdminApplicationResponseModel?>?
      get adminApplicationResponseModel => _adminApplicationResponseModel;
  List<ApplicationResponsedData>? data;
  List<ApplicationResponsedData> tempData = [];
  int page = 1;
  String userType = "";
  void onScrollEnding() {
    if ((_adminApplicationResponseModel?.data?.meta?.lastPage ?? 0) > page) {
      page++;
      loadMoreData();
    }
  }

  void loadMoreData() async {
    state = ViewState.busy;

    await getApplicationData(isPaginating: true, userType);
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
        HelperFunctions().logger("No response");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }
    state = ViewState.idle;
    return _adminApplicationResponseModel;
  }

  Future getDownloadPaymentReceipt(BuildContext context, String userId) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _adminRepo.getAdminPaymentReceipt(userId);
      if (value.isSuccess == true) {
        HelperFunctions()
            .downloadAndStoreFile(name: "Transaction", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;

        if (context.mounted) {
          HelperFunctions()
              .commonErrorSnackBar(context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }
    state = ViewState.idle;

    return null;
  }

  Future getDownloadApplication(BuildContext context, String id) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _adminRepo.getAdminDownloadApplication(id);
      if (value.isSuccess == true) {
        HelperFunctions()
            .downloadAndStoreFile(name: "Application", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;

        if (context.mounted) {
          HelperFunctions()
              .commonErrorSnackBar(context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, StringConstants().somethingWentWrong);
        Navigator.pop(context);
      }
      HelperFunctions().logger("$err");
    }
    state = ViewState.idle;

    return null;
  }
}
