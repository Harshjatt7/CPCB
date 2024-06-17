import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/custom/custom_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/custom/custom_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../utils/helper/debouncing_helper.dart';
import '../../views/widgets/components/download_certificate_bottom_sheet.dart';

class CustomDashboardViewModel extends BaseViewModel {
  StringConstants stringConstants = StringConstants();
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final _customRepository = CustomRepository();
  final _helperFunctions = HelperFunctions();
  APIResponse<CustomResponseModel?>? _customResponseModel;
  APIResponse<CustomResponseModel?>? get customResponseModel =>
      _customResponseModel;
  APIResponse<CustomResponseModel?>? _customSearchResponseModel;
  APIResponse<CustomResponseModel?>? get customSearchResponseModel =>
      _customSearchResponseModel;
  final helperFunctions = HelperFunctions();
  int page =1;
  List<CustomData>? customData;
  List<CustomData> tempData = [];
  int searchPage = 1;
  final messageConstant = MessageConstant();
  final debouncer = Debouncer(milliseconds: 500);

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
    customData?.forEach((e) {
      tempData.add(CustomData(
        email: e.email,
        mobileNumber: e.mobileNumber,
        stateName: e.stateName,
      ));
    });

    state = ViewState.idle;
    updateUI();
  }

  void downloadCertificate(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) {
        return DownloadCertificateBottomSheet(
          onDownloadCertificateTapped: () async {
            if (ctx.mounted) {
              Navigator.pop(ctx);
            }
            await getCustomDownloadCertificate(context, id);
          },
        );
      },
    );
  }

  Future<APIResponse<CustomResponseModel?>?> getCustomData(
      {bool? isPaginating = false}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _customResponseModel =
          await _customRepository.getCustomData(page: "$page");
      if (_customResponseModel?.isSuccess == true) {
        _customResponseModel?.data = CustomResponseModel.fromJson(
            _customResponseModel?.completeResponse);
        if (isPaginating == true) {
          customData?.addAll(_customResponseModel?.data?.data ?? []);
        } else {
          customData = _customResponseModel?.data?.data ?? [];
        }
      } else {
        _helperFunctions.logger("No response");
      }
    } catch (err) {
      _helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _customResponseModel;
  }

  Future getCustomDownloadCertificate(BuildContext context, String id) async {
    state = ViewState.busy;
    try {
      APIResponse value = await _customRepository.getDownloadCertificate(id);
      if (value.isSuccess == true) {
        _helperFunctions.downloadAndStoreFile(
            name: "Certificate", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;

        if (context.mounted) {
          _helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? '');
        }
      }
    } catch (err) {
      _helperFunctions.logger("$err");
    }
    state = ViewState.idle;

    return null;
  }

  Future<APIResponse<CustomResponseModel?>?> performCustomSearch(
      String value,
      {bool? isPaginating = false}) async {
    state = ViewState.busy;

    try {
      _customSearchResponseModel = await _customRepository.getCustomData(
          searchValue: value, page: searchPage.toString());
      if (_customSearchResponseModel?.isSuccess == true) {
        _customSearchResponseModel?.data =
            CustomResponseModel.fromJson(
                _customSearchResponseModel?.completeResponse);
        if (isPaginating == true) {
          customData?.addAll(_customSearchResponseModel?.data?.data ?? []);
        } else {
          customData = _customSearchResponseModel?.data?.data ?? [];
        }
      } else {
        helperFunctions.logger(messageConstant.errorMessage);
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    state = ViewState.idle;
    return _customSearchResponseModel;
  }

  Future<void> searchCustom(String value) async {
    debouncer.run(() async {
      if (value.length >= 3) {
        await performCustomSearch(value).then((_) {
          scrollController.jumpTo(0);
        });
      } else {
        customData = tempData.isEmpty
            ? _customResponseModel?.data?.data ?? []
            : tempData;
        updateUI();
      }
    });
  }

  void getUpdatedList() async {
    state = ViewState.busy;
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      customData = tempData.isEmpty
          ? _customResponseModel?.data?.data ?? []
          : tempData;
      searchController.text = "";
    } else {
      customData = _customSearchResponseModel?.data?.data ?? [];
      searchController.text = "";
    }
    updateUI();
    resetPage();
    state = ViewState.idle;
  }
  void resetPage() {
    if (searchController.text.isEmpty) {
      searchPage = 1;
    } else {
      page = 1;
    }
  }
}
