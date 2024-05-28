import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/controllers/recycler/recycler_repository.dart';
import 'package:cpcb_tyre/models/request/recycler/add_recycler_data_request_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

      
  void addYear() {
    for (int i = 0; i < 5; i++) {
      financialYearList
          .add("${DateTime.now().year + (i)}-${DateTime.now().year + (i + 1)}");
    }
  }

  void changeDropdownValue(newValue) {
    changeDropdown = newValue;
    updateUI();
    if (changeDropdown == null) {
      yearDropdownError = MessageConstant().mandatoryFinancialYear;
    }
  }

  void changeRawMaterialDropdownValue(newValue) {
    changeDropdown = newValue;
    updateUI();
    if (changeDropdown == null) {
      tyreOfRecyclerMaterialDropdownError =
          MessageConstant().mandatoryTypeRawMaterial;
    }
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

  void onDateChange() {
    String text = dateController.text;
    if (text.length < newText.length) {
      newText = text;
    } else if (text.isNotEmpty && text != newText) {
      String tempText = text.replaceAll("-", "");
      if (tempText.length == 2 || tempText.length == 4) {
        newText = '$text-';
        dateController.text = newText;
      }
    }
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
    if (quantityProducedController.text.isNotEmpty &&
        quantityProcessedController.text.isNotEmpty) {
      int quantityProcessed = int.parse(quantityProcessedController.text);
      int quantityProduced = int.parse(quantityProducedController.text);
      if (quantityProduced > quantityProcessed) {
        return MessageConstant().quantityProducedError;
      }
    }
    return null;
  }

  void formValidation(BuildContext context) {
    if (changeDropdown == null) {
      changeDropdownValue(null);
      changeRawMaterialDropdownValue(null);
    }
    if (formKey.currentState?.validate() ?? false) {
      AddRecyclerDataRequestModel? request = AddRecyclerDataRequestModel(
          financialYear: yearDropdownValue,
          wasteTyreSupplierName: nameOfWasteTyreSupplierController.text,
          wasteTyreSupplierContact: contactDetailsController.text,
          wasteTyreSupplierAddress: addressController.text,
          typeOfRecycledMaterial: tyreOfRecyclerMaterialDropdownValue,
          wasteTyreSupplierGst: gstController.text,
          processedQty: double.parse(quantityProcessedController.text ),
          producedQty: double.parse(quantityProducedController.text ),
          wasteGeneratedQty:
              double.parse(quantityOfWasteGeneratedController.text),
          recycledDate: DateFormat('yyyy-mm-dd').format(DateTime.now()));
      addRecyclerData(request, context);
    }
  }

  Future addRecyclerData(
      AddRecyclerDataRequestModel? request, BuildContext context) async {
    state = ViewState.busy;

    var res = await _recyclerRepo.addRecyclerData(request);
    if (res?.isSuccess == true) {
      state = ViewState.idle;
      if (context.mounted) {
        HelperFunctions().commonSuccessSnackBar(
            context, MessageConstant().successfullySubmitted);
        MaterialAppViewModel.selectedPageIndex = 1;
        Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.retraderHomeScreenRoute,
            ModalRoute.withName(AppRoutes.retraderHomeScreenRoute));
      }
    } else {
      state = ViewState.idle;
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, MessageConstant().somethingWentWrong);
      }
    }
  }
}
