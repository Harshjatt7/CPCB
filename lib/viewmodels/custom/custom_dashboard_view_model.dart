import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/custom/custom_repository.dart';
import 'package:cpcb_tyre/models/response/custom/custom_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/state_enums.dart';
import '../../models/response/base_response_model.dart';
import '../../views/widgets/components/download_certificate_bottom_sheet.dart';

class CustomDashboardViewModel extends BaseViewModel {
  StringConstants stringConstants = StringConstants();
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  APIResponse<CustomResponseModel?>? _customResponseModel;
  APIResponse<CustomResponseModel?>? get customResponseModel =>
      _customResponseModel;
  final helperFunctions = HelperFunctions();
  final _customRepo = CustomRepository();
  int page =1;
  List<CustomData>? data;
  List<CustomData> tempData = [];
  
  void onScrollEnding() {
    if ((_customResponseModel?.data?.meta?.lastPage ?? 0) > page) {
      page++;
      loadMoreData();
    }
  }

void loadMoreData() async {
    state = ViewState.parallelBusy;
    await getCustomData(isPaginating: true);
    tempData.clear();
    data?.forEach((e) {
      tempData.add(CustomData(
        email: e.email,
        mobileNumber: e.mobileNumber,
        stateName: e.stateName,
      ));
    });

    state = ViewState.idle;
    updateUI();
  }
  void downloadCertificate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return DownloadCertificateBottomSheet();
      },
    );
  }

  Future<APIResponse<CustomResponseModel?>?> getCustomData(
      {bool? isPaginating = false}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _customResponseModel = await _customRepo.getCustomData(page: "$page");
      if (_customResponseModel?.isSuccess == true) {
        _customResponseModel?.data = CustomResponseModel.fromJson(
            _customResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_customResponseModel?.data?.data ?? []);
        } else {
          data = _customResponseModel?.data?.data ?? [];
        }
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _customResponseModel;
  }
}
