import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/controllers/recycler/recycler_repository.dart';
import 'package:cpcb_tyre/models/request/recycler/add_recycler_data_request_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../constants/routes_constant.dart';
import '../../models/response/base_response_model.dart';
import '../../models/response/recycler/get_recycler_add_data_constants.dart';
import '../material_app_viewmodel.dart';

class RecyclerAddDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final _recyclerRepo = RecyclerRepository();
  String? yearDropdownValue;
  String? yearDropdownError;
  String? changeDropdown;
  String? rawMaterialChangeDropDown;

  String newText = '';
  TextEditingController nameOfWasteTyreSupplierController =
      TextEditingController();
  TextEditingController contactDetailsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeOfRawMaterialController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityProcessedController = TextEditingController();
  TextEditingController quantityProducedController = TextEditingController();
  TextEditingController quantityOfWasteGeneratedController =
      TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime? date;
  String financialYearError = "";
  String producedQtyError = "";
  String processedQtyError = "";
  String retreadedDateError = "";
  String wasteTyreSupplierNameError = '';
  String wasteTyreSupplierContactError = '';
  String wasteTyreSupplierAddressError = '';
  String typeOfRecycledMaterialError = '';
  String wasteTyreSupplierGstError = '';
  String wasteGeneratedQtyError = '';
  String recycledDateError = '';

  List financialYearList = <String>[];
  List tyreOfRecyclerMaterialList = <String>[];
  String? tyreOfRecyclerMaterialDropdownValue;
  String? tyreOfRecyclerMaterialDropdownError;

  Future<APIResponse<AddRecyclerDataConstantsResponseModel?>?>
      getRecyclerDataConstants() async {
    state = ViewState.busy;
    var response = await _recyclerRepo.getRecyclerDataConstants();

    if (response?.isSuccess == true) {
      response?.data = AddRecyclerDataConstantsResponseModel.fromJson(
          response.completeResponse);
      financialYearList.addAll(response?.data?.data?.financialYear ?? []);
      tyreOfRecyclerMaterialList
          .addAll(response?.data?.data?.tyreOfRecyclerMaterial ?? []);
    }
    state = ViewState.idle;
    return response;
  }

  String? nameValidation() {
    return Validations().validateName(nameOfWasteTyreSupplierController.text);
  }

  void addYear() {
    for (int i = 0; i < 5; i++) {
      financialYearList
          .add("${DateTime.now().year + (i)}-${DateTime.now().year + (i + 1)}");
    }
  }

  void changeRawMaterialDropdownValue(newValue) {
    rawMaterialChangeDropDown = newValue;
    updateUI();
    if (changeDropdown == null) {
      tyreOfRecyclerMaterialDropdownError =
          MessageConstant().mandatoryTypeRawMaterial;
    }
  }

  String? financialYearDropdownValue;
  void changeFinancialDropdownValue(newValue) {
    financialYearDropdownValue = newValue;
    if (financialYearDropdownValue != null) {
      String startYear = financialYearDropdownValue!.split('-').first;
      int year = int.parse(startYear);
      startDate = DateTime(year, 4, 1);
      updateUI();
    }
    updateUI();
    if (financialYearDropdownValue == null) {
      yearDropdownError = MessageConstant().mandatoryFinancialYear;
    }
  }

  dateTimeConvert() {
    if (date != null) {
      dateController.text = HelperFunctions().getFormattedDate(date: date!);
    }
    HelperFunctions().logger(dateController.text);
  }

  String? quantityProcessedValidation() {
    if (quantityProcessedController.text.isEmpty) {
      return MessageConstant().quantityProcessed;
    }
    return null;
  }

  String? contactDetailsValidation() {
    return Validations().validatePhone(contactDetailsController.text);
  }

  String? quantityOfWasteGeneratedValidation() {
    if (quantityOfWasteGeneratedController.text.isEmpty) {
      return MessageConstant().mandatoryToAddWasteGenerated;
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
      return MessageConstant().mandatoryToAddQuantityProduced;
    }
    return null;
  }

  void addRecyclerData(BuildContext context) {
    String recyclerDate = '$date';
    AddRecyclerDataRequestModel? request = AddRecyclerDataRequestModel(
        financialYear: changeDropdown,
        wasteTyreSupplierName: nameOfWasteTyreSupplierController.text,
        wasteTyreSupplierContact: contactDetailsController.text,
        wasteTyreSupplierAddress: addressController.text,
        typeOfRecycledMaterial: rawMaterialChangeDropDown,
        wasteTyreSupplierGst: gstController.text,
        processedQty: double.parse(quantityProcessedController.text),
        producedQty: double.parse(quantityProducedController.text),
        wasteGeneratedQty:
            double.parse(quantityOfWasteGeneratedController.text),
        recycledDate: recyclerDate.split(' ').first
        );
    postRecyclerData(request, context);
  }

  void formValidation(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
    } else {
      if (financialYearDropdownValue == null) {
        changeFinancialDropdownValue(null);
      }
      if (rawMaterialChangeDropDown == null) {
        changeRawMaterialDropdownValue(null);
      }
    }
  }

  Future postRecyclerData(
      AddRecyclerDataRequestModel? request, BuildContext context) async {
    state = ViewState.busy;
    try {
      var res = await _recyclerRepo.addRecyclerData(request);
      if (res?.isSuccess == true) {
        state = ViewState.idle;
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, MessageConstant().successfullySubmitted);
          MaterialAppViewModel.selectedPageIndex = 2;
          Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.recyclerHomeScreenRoute,
              ModalRoute.withName(AppRoutes.recyclerHomeScreenRoute));
        } else {}
      } else {
        state = ViewState.idle;
        final apiError = res?.error?.errorsList;
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
        wasteTyreSupplierNameError =
            (apiError?.wasteTyreSupplierName ?? []).isEmpty
                ? ""
                : apiError?.wasteTyreSupplierName?.first ?? "";

        wasteTyreSupplierAddressError =
            (apiError?.wasteTyreSupplierAddress ?? []).isEmpty
                ? ""
                : apiError?.wasteTyreSupplierAddress?.first ?? "";
        typeOfRecycledMaterialError =
            (apiError?.typeOfRecycledMaterial ?? []).isEmpty
                ? ""
                : apiError?.typeOfRecycledMaterial?.first ?? "";
        wasteGeneratedQtyError = (apiError?.wasteGeneratedQty ?? []).isEmpty
            ? ""
            : apiError?.wasteGeneratedQty?.first ?? "";
        wasteTyreSupplierGstError =
            (apiError?.wasteTyreSupplierGst ?? []).isEmpty
                ? ""
                : apiError?.wasteTyreSupplierGst?.first ?? "";
        recycledDateError = (apiError?.recycledDate ?? []).isEmpty
            ? ""
            : apiError?.recycledDate?.first ?? "";
        wasteTyreSupplierContactError =
            (apiError?.wasteTyreSupplierContact ?? []).isEmpty
                ? ""
                : apiError?.wasteTyreSupplierContact?.first ?? "";
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions().commonErrorSnackBar(context, '');
      }
    }
  }
}
