import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/theme/app_color.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/views/widgets/app_components/status_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/state_enums.dart';
import '../../constants/message_constant.dart';
import '../../constants/routes_constant.dart';
import '../../controllers/auditor/auditor_repository.dart';
import '../../models/response/auditor/audit_list_response_model.dart';
import '../../models/response/auditor/audit_plan_detail_response_model.dart';
import '../../models/response/base_response_model.dart';
import '../../models/response/filter/checkbox_filter_model.dart';
import '../../models/screen_or_widegt_arguments/user_type_and_summary.dart';
import '../../utils/helper/debouncing_helper.dart';

class AuditorListViewModel extends BaseViewModel {
// Filter

  bool isFilterApplied = false;
  String filterString = "";

  bool isSearchActive = false;

  bool isUnitTypeChecked = false;
  bool isUnitTypeShowHide = false;

  bool isCurrentStatusChecked = false;
  bool isCurrentStatusShowHide = false;

  List<AuditPlanListData>? filterDataList;
  List<AuditPlanListData> filterTempData = [];

  List<CheckboxFilterModel> unitTypeList = [
    CheckboxFilterModel(title: "Producer"),
    CheckboxFilterModel(title: "Recycler"),
    CheckboxFilterModel(title: "Retreader"),
  ];
  List<CheckboxFilterModel> currentStatusList = [
    CheckboxFilterModel(title: "assigned"),
    CheckboxFilterModel(title: "acknowledged"),
    CheckboxFilterModel(title: "started"),
    CheckboxFilterModel(title: "continue"),
    CheckboxFilterModel(title: "completed"),
  ];

  List<String> selectedUnitTypeList = [];
  List<String> selectedCurrentStatusList = [];
  List<int> selectedcurrentStatusCodeList = [];

  List<String> tempSelectedUnitTypeList = [];
  List<String> tempSelectedCurrentStatusList = [];
  List<String> tempSelectedunitTypeList = [];
  List<String> tempSelectedcurrentStatusList = [];

  Future<void> onCloseClicked() async {
    tempSelectedUnitTypeList = List.from(selectedUnitTypeList);
    tempSelectedCurrentStatusList = List.from(selectedCurrentStatusList);

    helperFunction
        .logger("On Close Unit Type >>>> ${selectedUnitTypeList.toString()}");
    helperFunction.logger(
        " On Close Status >>>> ${selectedCurrentStatusList.toString()}");
    updateUI();
  }

  Future<void> onApplyClicked(BuildContext context) async {
    filterString = "";
    selectedcurrentStatusCodeList.clear();

    selectedUnitTypeList = List.generate(tempSelectedUnitTypeList.length,
        (index) => tempSelectedUnitTypeList[index]).toList();

    selectedCurrentStatusList = List.generate(
        tempSelectedCurrentStatusList.length,
        (index) => tempSelectedCurrentStatusList[index]).toList();

    if (selectedUnitTypeList.isNotEmpty || selectedUnitTypeList.isNotEmpty) {
      isFilterApplied = true;
    } else {
      isFilterApplied = false;
    }
    updateUI();

    for (var element in selectedCurrentStatusList) {
      if (element == "Assigned") {
        selectedcurrentStatusCodeList.add(1);
      } else if (element == "Acknowledged") {
        selectedcurrentStatusCodeList.add(2);
      } else if (element == "Started") {
        selectedcurrentStatusCodeList.add(3);
      } else if (element == "Continue") {
        selectedcurrentStatusCodeList.add(4);
      } else if (element == "Completed") {
        selectedcurrentStatusCodeList.add(5);
      }
    }

    if (isSearchActive == true) {
      searchPage = 1;
      await searchAuditorPlanList(
          value: searchController.text, filterString: filterString);
    } else {
      page = 1;
      await getAuditPlanList(context, filterString: filterString);
    }

    helperFunction.logger("Unit Type >>>> ${selectedUnitTypeList.toString()}");
    helperFunction
        .logger("Status >>>> ${selectedCurrentStatusList.toString()}");
  }

  Future<void> handleAuditStatus(
      BuildContext context, AuditPlanDetailData? auditPlanDetail) async {
    state = ViewState.busy;
    if (auditPlanDetail?.status == "assigned") {
      await AuditorRepository()
          .getAuditStatus(status: "assigned", id: auditPlanDetail?.id);
      if (context.mounted) {
        await getAuditPlanDetail(context, id: auditPlanDetail?.id);
      }
      final updatedDetail = auditPlanDetaildata?[0];
      if (context.mounted) {
        viewBottomSheet(context, auditPlanDetail: updatedDetail);
      }
    } else if (auditPlanDetail?.status == "acknowledged") {
      await AuditorRepository()
          .getAuditStatus(status: "acknowledged", id: auditPlanDetail?.id);

      if (context.mounted) {
        getIndex(auditPlanDetail?.statusPercentage);
        navigateToStepperScreen(
          context,
          auditPlanDetail,
          index,
        );
        await getAuditPlanDetail(context, id: auditPlanDetail?.id);
      }
    } else {
      if (context.mounted) {
        getIndex(auditPlanDetail?.statusPercentage);
        navigateToStepperScreen(context, auditPlanDetail, index);
        await getAuditPlanDetail(context, id: auditPlanDetail?.id);
      }
    }
    state = ViewState.idle;
    updateUI();
  }

  int index = 1;
  void getIndex(num? statusPercentage) {
    switch (statusPercentage) {
      case 0:
        index = 1;
        break;
      case 33:
        index = 2;
        break;
      case 66 || 100:
        index = 3;
        break;
      default:
        index = 1;
    }
    updateUI();
  }

  Future<dynamic> viewBottomSheet(BuildContext context,
      {AuditPlanDetailData? auditPlanDetail,
      VoidCallback? onPressed,
      bool? isDismissible}) {
    return showModalBottomSheet(
        isDismissible: isDismissible ?? true,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        builder: (ctx) {
          return StatusBottomSheet(
            auditPlanDetail: auditPlanDetail,
            onPressed: () {
              Navigator.pop(context);
              handleAuditStatus(context, auditPlanDetail);
            },
          );
        });
  }

  void navigateToStepperScreen(
      BuildContext context, AuditPlanDetailData? auditPlanDetail, num? index) {
    if (context.mounted) {
      Navigator.pushNamed(
        context,
        auditPlanDetail?.legalName == 'Producer'
            ? AppRoutes.auditorProducerStepperScreen
            : AppRoutes.auditorRecyclerStepperScreen,
        arguments: CheckUserAndSummaryScreen(
          id: auditPlanDetail?.id,
          userType: auditPlanDetail?.legalName,
          progress: auditPlanDetail?.statusPercentage,
          index: index,
        ),
      );
    }
  }

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
  final debouncer = Debouncer(milliseconds: 500);

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
    BuildContext context, {
    bool? isPaginating = false,
    String? filterString,
  }) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;

    try {
      _auditPlanListModel = await _auditorRepository.getAuditPlanListData(
          page: "$page",
          statusList: selectedCurrentStatusList,
          unitTypeList: selectedUnitTypeList);
      if (_auditPlanListModel?.isSuccess == true) {
        _auditPlanListModel?.data = AuditPlanListResponseModel.fromJson(
            _auditPlanListModel?.completeResponse);

        if (isPaginating == true) {
          auditPlanListdata?.addAll(_auditPlanListModel?.data?.data ?? []);
        } else {
          auditPlanListdata = _auditPlanListModel?.data?.data;
        }
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

  Future<void> searchAuditorPlanList(
      {String? value, String? filterString}) async {
    debouncer.run(() async {
      if ((value?.length ?? 0) >= 3) {
        await performSearch(value ?? "", filterString: filterString).then((_) {
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

  void onScrollEnding(BuildContext context) {
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      if ((_auditPlanListSearchModel?.data?.meta?.lastPage ?? 0) > searchPage) {
        searchPage++;
        loadMoreData(context);
      } else {
        helperFunction.logger(searchPage.toString());
      }
    } else {
      if ((_auditPlanListModel?.data?.meta?.lastPage ?? 0) > page) {
        page++;
        loadMoreData(context);
      }
    }
  }

  Future<APIResponse<AuditPlanListResponseModel?>?> performSearch(String value,
      {bool? isPaginating = false, String? filterString}) async {
    state = isPaginating == true ? ViewState.parallelBusy : ViewState.busy;
    try {
      _auditPlanListSearchModel = await _auditorRepository.getAuditPlanListData(
          search: value,
          page: searchPage.toString(),
          statusList: selectedCurrentStatusList,
          unitTypeList: selectedUnitTypeList);
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

  void loadMoreData(BuildContext context) async {
    state = ViewState.parallelBusy;
    if (isSearchExpanded == true && searchController.text.isNotEmpty) {
      await performSearch(searchController.text,
          isPaginating: true, filterString: filterString);
    } else {
      await getAuditPlanList(context,
          isPaginating: true, filterString: filterString);
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
    updateUI();
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
