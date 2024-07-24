import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/admin/admin_repository.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/producer_epr_oblications_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../models/response/admin/admin_application_response_model.dart';
import '../../models/response/admin/summary_response_model.dart';

class AdminDashBoardViewmodel extends BaseViewModel {
  final StringConstants stringConstants = StringConstants();
  final HelperFunctions helperFunctions = HelperFunctions();
  final _adminRepo = AdminRepository();
  APIResponse<EprApplicationResponseModel?>? _eprApplicationResponseModel;
  APIResponse<EprApplicationResponseModel?>? get eprApplicationResponseModel =>
      _eprApplicationResponseModel;
  APIResponse<ProducerEprOblicationsResponseModel?>?
      _eprOblicationResponseModel;
  APIResponse<ProducerEprOblicationsResponseModel?>?
      get eproblicationResponseModel => _eprOblicationResponseModel;

  APIResponse<EprOblicationsResponseModel?>? _commonEprOblicationsResponseModel;
  APIResponse<EprOblicationsResponseModel?>?
      get commonEprOblicationsResponseModel =>
          _commonEprOblicationsResponseModel;

  EPRApplicationData? producerData;
  EPRApplicationData? recyclerData;
  EPRApplicationData? retraderData;
  EprOblicationsData? producerEprOblicationsData;
  CommonEprOblicationData? retreaderEprOblicationData;
  CommonEprOblicationData? recyclerEprOblicationData;
  int page = 1;
  List financialYearList = <String>[];
  List<ApplicationResponsedData>? data;
  String? yearDropdownValue;
  String? yearDropdownError;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  APIResponse<AdminApplicationResponseModel?>? _adminApplicationResponseModel;
  APIResponse<AdminApplicationResponseModel?>?
      get adminApplicationResponseModel => _adminApplicationResponseModel;
  APIResponse<AdminSummaryResponseData?>? _adminSummaryResponseModel;
  APIResponse<AdminSummaryResponseData?>? get adminSummaryResponseModel =>
      _adminSummaryResponseModel;
  SummaryDataResponse? summaryData;
  bool isDashboard = true;
  String? dashboardDropdownValue;
  String? summaryDropdownValue;

  Future<APIResponse<AdminSummaryResponseData?>?> getSummary(
      BuildContext context) async {
    state = ViewState.busy;
    yearDropdownValue = summaryDropdownValue ?? financialYearList.last;
    try {
      _adminSummaryResponseModel = await _adminRepo
          .getSummaryData(summaryDropdownValue ?? financialYearList.last);
      if (_adminSummaryResponseModel?.isSuccess == true) {
        _adminSummaryResponseModel?.data = AdminSummaryResponseData.fromJson(
            _adminSummaryResponseModel?.completeResponse);
        summaryData = _adminSummaryResponseModel?.data?.data;
      } else {
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _adminSummaryResponseModel;
  }

  void addYear() {
    int year = 2022;
    int currentYear = DateTime.now().year;
    while (year <= currentYear) {
      financialYearList.add('$year-${year + 1}');
      year++;
    }
  }

  void changeDropdownValue(newValue) {
    if (isDashboard == true) {
      dashboardDropdownValue = newValue ?? financialYearList.last;
      summaryDropdownValue = newValue ?? financialYearList.last;
    } else {
      summaryDropdownValue = newValue ?? financialYearList.last;
    }
    if (summaryDropdownValue != null || dashboardDropdownValue != null) {
      String startYear = summaryDropdownValue!.split('-').first;
      String lastYear = summaryDropdownValue!.split('-').last;
      int stYear = int.parse(startYear);
      int edYear = int.parse(lastYear);
      startDate = DateTime(stYear, 4, 1);
      endDate = startYear == DateTime.now().year.toString()
          ? DateTime.now()
          : DateTime(edYear, 3, 31);
      updateUI();
    }
    updateUI();
    if (summaryDropdownValue == null || dashboardDropdownValue == null) {
      yearDropdownError = MessageConstant().pleaseSelectDropdownValue;
    }
  }

  Future<APIResponse<EprApplicationResponseModel?>?> getAdminDashBoardData(
      BuildContext context) async {
    state = ViewState.busy;
    try {
      APIResponse<EprApplicationResponseModel?>? producerRes =
          await _adminRepo.getAdminDashBoard(AdminUserTypes.producer.text);
      var recyclerRes =
          await _adminRepo.getAdminDashBoard(AdminUserTypes.recycler.text);
      var retraderRes =
          await _adminRepo.getAdminDashBoard(AdminUserTypes.retreader.text);

      if (producerRes?.isSuccess == true) {
        producerRes?.data =
            EprApplicationResponseModel.fromJson(producerRes.completeResponse);

        producerData = producerRes?.data?.eprApplicationData;
      }

      if (recyclerRes?.isSuccess == true) {
        recyclerRes?.data =
            EprApplicationResponseModel.fromJson(recyclerRes.completeResponse);

        recyclerData = recyclerRes?.data?.eprApplicationData;
      }
      if (retraderRes?.isSuccess == true) {
        retraderRes?.data =
            EprApplicationResponseModel.fromJson(retraderRes.completeResponse);

        retraderData = retraderRes?.data?.eprApplicationData;
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;
    return _eprApplicationResponseModel;
  }

  Future<APIResponse<ProducerEprOblicationsResponseModel?>?> getEprOblications(
      BuildContext context) async {
    state = ViewState.busy;
    yearDropdownValue = dashboardDropdownValue ?? financialYearList.last;
    try {
      _eprOblicationResponseModel =
          await _adminRepo.getEprOblications(yearDropdownValue.toString());
      if (_eprOblicationResponseModel?.isSuccess == true) {
        _eprOblicationResponseModel?.data =
            ProducerEprOblicationsResponseModel.fromJson(
                _eprOblicationResponseModel?.completeResponse);
        producerEprOblicationsData = _eprOblicationResponseModel?.data?.data;
      } else {
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _eprOblicationResponseModel;
  }

  Future<APIResponse<EprOblicationsResponseModel?>?> getCommonEprOblications(
      BuildContext context) async {
    state = ViewState.busy;
    try {
      APIResponse<EprOblicationsResponseModel?>? recyclerRes = await _adminRepo
          .getCommonEprOblications("recycler", yearDropdownValue.toString());
      var retraderRes = await _adminRepo.getCommonEprOblications(
          "retreader", yearDropdownValue.toString());

      if (recyclerRes?.isSuccess == true) {
        recyclerRes?.data =
            EprOblicationsResponseModel.fromJson(recyclerRes.completeResponse);

        recyclerEprOblicationData = recyclerRes?.data?.data;
      }
      if (retraderRes?.isSuccess == true) {
        retraderRes?.data =
            EprOblicationsResponseModel.fromJson(retraderRes.completeResponse);

        retreaderEprOblicationData = retraderRes?.data?.data;
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _commonEprOblicationsResponseModel;
  }

  num? totalEprObligations() {
    final data = producerEprOblicationsData;
    num? total = (data?.newTyreImported ?? 0) +
        (data?.wasteTyreImported ?? 0) +
        (data?.newTyreImportedAndImportedVehicles ?? 0) +
        (data?.newTyreImportedExclusivelyForNewVehiclesManufacturedDomestically ??
            0) +
        (data?.newTyreManufacturers ?? 0) +
        (data?.newTyreProducedDomestically ?? 0);
    if (total == 0) {
      return null;
    }

    return total;
  }

  num? totalRecyclerGenerated() {
    final data = recyclerEprOblicationData;
    num? total = (data?.crumbRubber?.earnedCredit ?? 0) +
        (data?.crumbRubberModifiedBitumenCrmb?.earnedCredit ?? 0) +
        (data?.reclaimedRubber?.earnedCredit ?? 0) +
        (data?.recoverCarbon?.earnedCredit ?? 0) +
        (data?.retreadedTyre?.earnedCredit ?? 0) +
        (data?.tpoChar?.earnedCredit ?? 0);
    return total;
  }

  num? totalRecyclerTransferred() {
    final data = recyclerEprOblicationData;
    num? total = (data?.crumbRubber?.creditTransfered ?? 0) +
        (data?.crumbRubberModifiedBitumenCrmb?.creditTransfered ?? 0) +
        (data?.reclaimedRubber?.creditTransfered ?? 0) +
        (data?.recoverCarbon?.creditTransfered ?? 0) +
        (data?.retreadedTyre?.creditTransfered ?? 0) +
        (data?.tpoChar?.creditTransfered ?? 0);
    return total;
  }
}
