import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/producer/producer_repository.dart';
import 'package:cpcb_tyre/models/request/producer/add_sales_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/models/response/producer/producer_constant_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

class SalesDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  StringConstants stringConstants = StringConstants();

  String? producerDropdownError;
  String? tyreDropdownError;
  String? yearDropdownError;
  String? monthDropdownError;
  String? producerDropdownValue;
  String? tyreDropdownValue;
  String? yearDropdownValue;
  String? monthDropdownValue;
  String? changeDropdown;
  final ScrollController scrollController = ScrollController();
  TextEditingController motorcycleController = TextEditingController();
  TextEditingController passengerCarController = TextEditingController();
  TextEditingController scooterController = TextEditingController();
  TextEditingController truckController = TextEditingController();
  TextEditingController busController = TextEditingController();
  TextEditingController lcvController = TextEditingController();
  TextEditingController tRearController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  List financialYearList = <String>[];
  List producerList = <String>[];
  List tyreList = <String>[];
  List monthList = <String>[];
  List listController = [];
  final _producerRepo = ProducerRepository();
  Map<String, String> producerTypeMap = {};

  String financialYearError = "";
  String producerError = "";
  String tyreError = "";
  String monthError = "";
  String totalError = "";

  Future<APIResponse<ProducerConstantResponseModel?>?> getProducerDataConstants(
      context) async {
    state = ViewState.busy;
    var response = await _producerRepo.getProducerDataConstants();

    if (response?.isSuccess == true) {
      response?.data =
          ProducerConstantResponseModel.fromJson(response.completeResponse);
      final responseData = response?.data?.data;
      financialYearList.addAll(responseData?.financialYear ?? []);
      producerList.addAll(responseData?.producerType?.values.toList() ?? []);
      tyreList.addAll(responseData?.tyreType?.values.toList() ?? []);
      monthList.addAll(responseData?.months ?? []);
      producerTypeMap = responseData?.producerType ?? {};
    } else {
      HelperFunctions()
          .commonErrorSnackBar(context, MessageConstant().somethingWentWrong);
    }
    state = ViewState.idle;
    return response;
  }

  String? getProducerType() {
    String? selectedValue = producerDropdownValue;
    String? selectedKey;

    producerTypeMap.forEach((key, value) {
      if (value == selectedValue) {
        selectedKey = key;
      }
    });

    return selectedKey;
  }

  Future<APIResponse<AddDataResponseModel?>?> postProducerData(context) async {
    String? producerKey = getProducerType();
    ProducerAddSalesRequestModel request = ProducerAddSalesRequestModel(
      producerType: producerKey,
      financialYear: yearDropdownValue,
      lcv: int.parse(lcvController.text),
      motorCycle: int.parse(motorcycleController.text),
      total: int.parse(totalController.text),
      typeOfTyreManufacture: tyreDropdownValue,
      month: getMonthValue(),
      passengerCar: int.parse(passengerCarController.text),
      scooter: int.parse(scooterController.text),
      truck: int.parse(truckController.text),
      bus: int.parse(busController.text),
      tRear: int.parse(tRearController.text),
      other: int.parse(otherController.text),
    );

    state = ViewState.busy;
    try {
      if (formKey.currentState?.validate() ?? false) {
        APIResponse<AddDataResponseModel?>? response =
            await _producerRepo.postProducerSalesData(request);
        if (response?.isSuccess == true) {
          if (context.mounted) {
            state = ViewState.idle;
            HelperFunctions().commonSuccessSnackBar(
                context, MessageConstant().successfullySubmitted);
            MaterialAppViewModel.selectedPageIndex = 1;
            Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.producerHomeScreenRoute,
                ModalRoute.withName(AppRoutes.producerHomeScreenRoute));
          }
        } else {
          final apiError = response?.error?.errorsList;
          financialYearError = (apiError?.financialYear ?? []).isEmpty
              ? ""
              : apiError?.financialYear?.first ?? "";
          tyreError = (apiError?.typeOfTyreManufacture ?? []).isEmpty
              ? ""
              : apiError?.typeOfTyreManufacture?.first ?? "";
          producerError = (apiError?.producerType ?? []).isEmpty
              ? ""
              : apiError?.producerType?.first ?? "";
          monthError = (apiError?.month ?? []).isEmpty
              ? ""
              : apiError?.month?.first ?? "";
          totalError = (apiError?.total ?? []).isEmpty
              ? ""
              : apiError?.total?.first ?? "";
        }
      } else {
        HelperFunctions()
            .commonErrorSnackBar(context, MessageConstant().somethingWentWrong);
      }
    } catch (e) {
      HelperFunctions().logger('$e');
    }
    state = ViewState.idle;
    return null;
  }

  final Map<String, int> monthMap = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12,
  };

  int? getMonthValue() {
    int? month = monthMap[monthDropdownValue ?? ''];
    return month;
  }

  void addYear() {
    for (int i = 0; i < 5; i++) {
      financialYearList
          .add("${DateTime.now().year + (i)}-${DateTime.now().year + (i + 1)}");
    }
  }

  bool isTotalValidated = false;
  void validateTotal(bool val) {
    isTotalValidated = val;

    updateUI();
  }

  String? totalValidation() {
    if ((totalController.text.isEmpty
        // || totalController.text == "0"
        )) {
      return MessageConstant().pleaseEnterDataInField;
    }

    return null;
  }

  void textFormListener() {
    motorcycleController.addListener(() {
      totalValue();
    });
    passengerCarController.addListener(() {
      totalValue();
    });
    scooterController.addListener(() {
      totalValue();
    });
    truckController.addListener(() {
      totalValue();
    });
    busController.addListener(() {
      totalValue();
    });
    lcvController.addListener(() {
      totalValue();
    });
    tRearController.addListener(() {
      totalValue();
    });
    otherController.addListener(() {
      totalValue();
    });
  }

  void dropDownValidation() {
    if (changeDropdown == null) {
      changeDropdownValue(SalesDataDropdown.month, null);
      changeDropdownValue(SalesDataDropdown.producerType, null);
      changeDropdownValue(SalesDataDropdown.typeOfTyre, null);
      changeDropdownValue(SalesDataDropdown.financialYear, null);
    }
  }

  void formValidation(context) {
    if (changeDropdown == null) {
      dropDownValidation();
    }

    if (formKey.currentState?.validate() ?? false) {
      listController = [
        motorcycleController,
        passengerCarController,
        scooterController,
        truckController,
        busController,
        lcvController,
        tRearController,
        otherController
      ];
      for (TextEditingController controller in listController) {
        if (controller.text.isEmpty) {
          controller.text = "0";
        }
      }

      validateTotal(false);
    } else {
      validateTotal(true);
      totalValue();
      scrollController.jumpTo(scrollController.position.maxScrollExtent + 80);
    }
  }

  void totalValue() {
    int motorcycle = int.parse(
        motorcycleController.text.isEmpty ? "0" : motorcycleController.text);
    int passenger = int.parse(passengerCarController.text.isEmpty
        ? "0"
        : passengerCarController.text);
    int scooter = int.parse(
        scooterController.text.isEmpty ? "0" : scooterController.text);
    int truck =
        int.parse(truckController.text.isEmpty ? "0" : truckController.text);
    int bus = int.parse(busController.text.isEmpty ? "0" : busController.text);
    int lcv = int.parse(lcvController.text.isEmpty ? "0" : lcvController.text);
    int tRear =
        int.parse(tRearController.text.isEmpty ? "0" : tRearController.text);
    int other =
        int.parse(otherController.text.isEmpty ? "0" : otherController.text);
    int total =
        motorcycle + passenger + scooter + truck + bus + lcv + tRear + other;
    if (motorcycleController.text.isNotEmpty ||
        passengerCarController.text.isNotEmpty ||
        scooterController.text.isNotEmpty ||
        truckController.text.isNotEmpty ||
        busController.text.isNotEmpty ||
        lcvController.text.isNotEmpty ||
        tRearController.text.isNotEmpty ||
        otherController.text.isNotEmpty) {
      totalController.text = total.toString();
    }
    notifyListeners();
  }

  void changeDropdownValue(dropdownValue, newValue) {
    changeDropdown = newValue;
    updateUI();
    switch (dropdownValue) {
      case SalesDataDropdown.producerType:
        producerDropdownValue = changeDropdown;
        producerDropdownError = MessageConstant().pleaseSelectValue;
        updateUI();
        break;
      case SalesDataDropdown.typeOfTyre:
        tyreDropdownValue = changeDropdown;
        tyreDropdownError = MessageConstant().pleaseSelectValue;
        updateUI();
        break;
      case SalesDataDropdown.financialYear:
        yearDropdownValue = changeDropdown;
        yearDropdownError = MessageConstant().pleaseSelectValue;
        updateUI();
        break;
      case SalesDataDropdown.month:
        monthDropdownValue = changeDropdown;
        monthDropdownError = MessageConstant().pleaseSelectValue;
        updateUI();
        break;
      default:
        updateUI();
    }
  }
}
