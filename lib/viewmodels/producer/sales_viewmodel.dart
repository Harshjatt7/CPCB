import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/controllers/producer/producer_repository.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/producer/sales_data_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

class SalesViewModel extends BaseViewModel {
  final _producerRepo = ProducerRepository();
  UserTypes? currentUser;
  APIResponse<SalesDataResponseModel?>? _salesDateResponseModel;
  APIResponse<SalesDataResponseModel?>? get salesDataResponseModel =>
      _salesDateResponseModel;

  List<SalesData>? data;
  List<SalesData> tempData = [];
  int page = 1;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  void getCurrentUserType(BuildContext context) {
    currentUser = MaterialAppViewModel.userTypeEnum;
  }

  void onScrollEnding() {
    if ((_salesDateResponseModel?.data?.meta?.lastPage ?? 0) > page) {
      page++;
      loadMoreData();
    }
  }

  void loadMoreData() async {
    state = ViewState.busy;

    await getSalesData(isPaginating: true);
    tempData.clear();
    data?.forEach((e) {
      tempData.add(SalesData(
        bus: e.bus,
        lcv: e.lcv,
        month: e.month,
        motorCycle: e.motorCycle,
        other: e.other,
        passengerCar: e.passengerCar,
        producerType: e.producerType,
        scooter: e.scooter,
        tRear: e.tRear,
        total: e.total,
        truck: e.truck,
        typeOfTyreManufacture: e.typeOfTyreManufacture,
        financialYear: e.financialYear,
      ));
    });

    state = ViewState.idle;
    updateUI();
  }

  Future<APIResponse<SalesDataResponseModel?>?> getSalesData(
      {bool? isPaginating = false}) async {
    state = ViewState.busy;
    try {
      _salesDateResponseModel = await _producerRepo.getSalesData(page: "$page");
      if (_salesDateResponseModel?.isSuccess == true) {
        _salesDateResponseModel?.data = SalesDataResponseModel.fromJson(
            _salesDateResponseModel?.completeResponse);
        if (isPaginating == true) {
          data?.addAll(_salesDateResponseModel?.data?.data ?? []);
        } else {
          data = _salesDateResponseModel?.data?.data ?? [];
        }
      } else {
        HelperFunctions().logger("No response");
      }
    } catch (err) {
      HelperFunctions().logger("$err");
    }
    state = ViewState.idle;
    return _salesDateResponseModel;
  }
}
