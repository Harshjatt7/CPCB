import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/retreader/retreader_repository.dart';
import 'package:cpcb_tyre/models/request/retreader/retreader_view_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

class RetreadedAddDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final StringConstants stringConstants = StringConstants();
  final MessageConstant messageConstant = MessageConstant();
  final HelperFunctions helperFunctions = HelperFunctions();

  String? yearDropdownValue;
  String? yearDropdownError;
  String? changeDropdown;
  String newText = '';

  TextEditingController nameOfWasteTyreSupplierController =
      TextEditingController();
  TextEditingController contactDetailsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeOfRawMaterialController =
      TextEditingController(text: "Retreaded Tyre");
  TextEditingController gstController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityProcessedController = TextEditingController();
  TextEditingController quantityProducedController = TextEditingController();
  TextEditingController quantityOfWasteGeneratedController =
      TextEditingController();

  List financialYearList = <String>[];
  final _retreaderRepo = RetreaderRepository();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime? date;
  String dynamicError = "";
  String financialYearError = "";
  String producedQtyError = "";
  String processedQtyError = "";
  String retreadedDateError = "";

  Future<void> addRetreadedData(BuildContext context) async {
    APIResponse<AddDataResponseModel?>? apiResponse;
    RetreaderRequestModel readerRequestModel = RetreaderRequestModel(
      financialYear: changeDropdown,
      supplierName: nameOfWasteTyreSupplierController.text,
      supplierMobile: contactDetailsController.text,
      supplierAddress: addressController.text,
      typeOfRawMaterial: typeOfRawMaterialController.text,
      supplierGstNo: gstController.text,
      processedQty: quantityProcessedController.text,
      producedQty: quantityProducedController.text,
      wasteGeneratedQty: quantityOfWasteGeneratedController.text,
      retreadedDate: dateController.text,
    );
    if (formKey.currentState?.validate() ?? false) {
      state = ViewState.busy;
      apiResponse = await _retreaderRepo.postRetreaderData(readerRequestModel);
      if (apiResponse?.isSuccess == true) {
        apiResponse?.data =
            AddDataResponseModel.fromJson(apiResponse.completeResponse);
        if (context.mounted) {
          helperFunctions.commonSuccessSnackBar(
              context,
              apiResponse?.data?.message ??
                  messageConstant.successfullySubmitted);
          state = ViewState.idle;
          MaterialAppViewModel.selectedPageIndex = 2;
          Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.retraderHomeScreenRoute,
              ModalRoute.withName(AppRoutes.retraderHomeScreenRoute));
        }
      } else {
        final apiError = apiResponse?.error?.errorsList;
        financialYearError = (apiError?.financialYear ?? []).isEmpty
            ? ""
            : apiError?.financialYear?.first ?? "";
        processedQtyError = (apiError?.processedQty ?? []).isEmpty
            ? ""
            : apiError?.processedQty?.first ?? "";
        producedQtyError = (apiError?.producedQty ?? []).isEmpty
            ? ""
            : apiError?.producedQty?.first ?? "";
        retreadedDateError = (apiError?.retreadedDate ?? []).isEmpty
            ? ""
            : apiError?.retreadedDate?.first ?? "";
      }
    } else {
      helperFunctions.commonErrorSnackBar(context, "Something went wrong...");
      state = ViewState.idle;
    }
    state = ViewState.idle;
  }

  void addYear() {
    int year = 2022;
    int currentYear = DateTime.now().year;
    while (year <= currentYear) {
      financialYearList.add('$year-${year + 1}');
      year++;
    }
  }

  String? nameValidation() {
    return Validations().validateName(nameOfWasteTyreSupplierController.text);
  }

  void dateTimeConvert() {
    if (date != null) {
      dateController.text = helperFunctions.getFormattedDate(date: date!);
    }
    helperFunctions.logger(dateController.text);
  }

  void changeDropdownValue(newValue) {
    changeDropdown = newValue;
    if (changeDropdown != null) {
      String startYear = changeDropdown!.split('-').first;
      String lastYear = changeDropdown!.split('-').last;
      int stYear = int.parse(startYear);
      int edYear = int.parse(lastYear);
      startDate = DateTime(stYear, 4, 1);
      endDate = startYear == DateTime.now().year.toString()
          ? DateTime.now()
          : DateTime(edYear, 3, 31);

      updateUI();
    }
    updateUI();
    if (changeDropdown == null) {
      yearDropdownError = messageConstant.pleaseSelectDropdownValue;
    }
  }

  String? quantityProcessedValidation() {
    if (quantityProcessedController.text.isEmpty) {
      return messageConstant.quantityProcessedValidation;
    }
    return null;
  }

  String? contactDetailsValidation() {
    return Validations().validatePhone(contactDetailsController.text);
  }

  String? quantityOfWasteGeneratedValidation() {
    if (quantityOfWasteGeneratedController.text.isEmpty) {
      return messageConstant.wasteGeneratedValidation;
    }
    return null;
  }

  String? dateValidation() {
    return Validations().dateValidation(dateController.text);
  }

  String? gstNumberValidation() {
    return Validations().gstValidation(gstController.text);
  }

  String? quantityProducedValidation() {
    if (quantityProducedController.text.isEmpty) {
      return messageConstant.quantityProducedValidation;
    }
    return null;
  }

  void formValidation() {
    if (changeDropdown == null) {
      changeDropdownValue(null);
    }
    if (formKey.currentState?.validate() ?? false) {}
  }
}
