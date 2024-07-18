import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/state_enums.dart';
import '../../constants/message_constant.dart';
import '../../controllers/auditor/auditor_repository.dart';
import '../../models/response/auditor/audit_list_response_model.dart';
import '../../models/response/auditor/audit_plan_detail_response_model.dart';
import '../../models/response/base_response_model.dart';
import '../../utils/helper/debouncing_helper.dart';

class AuditorListViewModel extends BaseViewModel {
  final helperFunction = HelperFunctions();
  bool isSearchExpanded = false;
  String groupValue = 'no';
  final appColor = AppColor();
  final stringConstants = StringConstants();
  String? applicationStatus = "";
  int searchPage = 1;
  List<AuditPlanListData> tempData = [];
  int page = 1;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  static final debouncer = Debouncer(milliseconds: 500);

  APIResponse<AuditPlanListResponseModel?>? _auditPlanListModel;
  APIResponse<AuditPlanListResponseModel?>? get auditPlanListModel =>
      _auditPlanListModel;
  APIResponse<AuditPlanListResponseModel?>? _auditPlanListSearchModel;
  APIResponse<AuditPlanListResponseModel?>? get auditPlanListSearchModel =>
      _auditPlanListSearchModel;

  List<AuditPlanListData>? auditPlanListdata;
  final AuditorRepository _auditorRepository = AuditorRepository();

  APIResponse<AuditPlanDetailResponseModel?>? _auditPlanDetailModel;
  APIResponse<AuditPlanDetailResponseModel?>? get auditPlanDetailModel =>
      _auditPlanDetailModel;

  List<AuditPlanDetailData>? auditPlanDetaildata;

  Future<APIResponse<AuditPlanDetailResponseModel?>?> getAuditPlanDetail(
      BuildContext context,
      {String? id}) async {
    state = ViewState.busy;

    try {
      _auditPlanDetailModel = await _auditorRepository.getAuditPlanDetail(id);
      if (_auditPlanDetailModel?.isSuccess == true) {
        _auditPlanDetailModel?.data = AuditPlanDetailResponseModel.fromJson(
            _auditPlanDetailModel?.completeResponse);
        auditPlanDetaildata = _auditPlanDetailModel?.data?.data;
      } else {
        if (context.mounted) {
          helperFunction.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunction.logger("$err");
    }

    state = ViewState.idle;

    return _auditPlanDetailModel;
  }

  Future<APIResponse<AuditPlanListResponseModel?>?> getAuditPlanList(
      {bool? isPaginating = false}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;

    try {
      _auditPlanListModel = await _auditorRepository.getAuditPlanListData(page: "$page");
      if (_auditPlanListModel?.isSuccess == true) {
        _auditPlanListModel?.data = AuditPlanListResponseModel.fromJson(
            _auditPlanListModel?.completeResponse);
        auditPlanListdata = _auditPlanListModel?.data?.data;
      } else {
        // if (context.mounted) {
        // helperFunction.commonErrorSnackBar(
        //     context, MessageConstant().somethingWentWrong);
        // }
      }
    } catch (err) {
      helperFunction.logger("$err");
    }
    state = ViewState.idle;
    return _auditPlanListModel;
  }

  getStatus(String status) {
    switch (status) {
      case "continue":
        applicationStatus = AuditorStatus.resume.text;
        break;
      case "assigned":
        applicationStatus = AuditorStatus.acknowledge.text;
        break;
      case "started":
        applicationStatus = AuditorStatus.start.text;
        break;
      case "Completed":
        applicationStatus = AuditorStatus.viewReport.text;
        break;
      case "acknowledged":
        applicationStatus = AuditorStatus.acknowledge.text;
        break;
      default:
        applicationStatus = AuditorStatus.start.text;
        break;
    }
    updateUI();
  }

  Future<void> searchRetreader(String value) async {
    debouncer.run(() async {
      if (value.length >= 3) {
        await performSearch(value).then((_) {
          scrollController.jumpTo(0);
        });
      } else {
        auditPlanListdata =
            tempData.isEmpty ? _auditPlanListModel?.data?.data ?? [] : tempData;
        updateUI();
      }
    });
  }

  void getUpdatedList() async {
    state = ViewState.busy;
    if (searchController.text.isEmpty || isSearchExpanded == false) {
      auditPlanListdata =
          tempData.isEmpty ? _auditPlanListModel?.data?.data ?? [] : tempData;
      searchController.text = "";
    } else {
      auditPlanListdata = _auditPlanListSearchModel?.data?.data ?? [];
      searchController.text = "";
    }
    updateUI();
    resetPage();
    state = ViewState.idle;
  }

  void onScrollEnding() {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((_auditPlanListSearchModel?.data?.meta?.lastPage ?? 0) > searchPage) {
        searchPage++;
        loadMoreData();
      } else {
        helperFunction.logger(searchPage.toString());
      }
    } else {
      if ((_auditPlanListModel?.data?.meta?.lastPage ?? 0) > page) {
        page++;
        loadMoreData();
      }
    }
  }

  Future<APIResponse<AuditPlanListResponseModel?>?> performSearch(String value,
      {bool? isPaginating = false}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _auditPlanListSearchModel = await _auditorRepository.getAuditPlanListData(
          search: value, page: searchPage.toString());
      if (_auditPlanListSearchModel?.isSuccess == true) {
        _auditPlanListSearchModel?.data = AuditPlanListResponseModel.fromJson(
            _auditPlanListSearchModel?.completeResponse);
        if (isPaginating == true) {
          auditPlanListdata
              ?.addAll(_auditPlanListSearchModel?.data?.data ?? []);
        } else {
          auditPlanListdata = _auditPlanListSearchModel?.data?.data ?? [];
        }
      } else {
        helperFunction.logger("No response");
      }
    } catch (err) {
      helperFunction.logger("$err");
    }
    state = ViewState.idle;
    return _auditPlanListSearchModel;
  }

  void loadMoreData() async {
    state = ViewState.parallelBusy;
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      await performSearch(searchController.text, isPaginating: true);
    } else {
      await getAuditPlanList(isPaginating: true);
      if ((auditPlanListdata?.length ?? 0) >= 1) {
        tempData.clear();
        auditPlanListdata?.forEach((e) {
          tempData.add(AuditPlanListData(
            address: e.address,
            district: e.district,
            endDate: e.endDate,
            financialYear: e.financialYear,
            gstin: e.gstin,
            id: e.id,
            legalName: e.legalName,
            quarter: e.quarter,
            regNum: e.regNum,
            startDate: e.startDate,
            state: e.state,
            status: e.status,
            statusPercentage: e.statusPercentage,
            type: e.type,
            unitName: e.unitName,
            userId: e.userId,
          ));
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
