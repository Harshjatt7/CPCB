import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/routes_constant.dart';
import 'package:cpcb_tyre/controllers/retreader/retreader_repository.dart';
import 'package:cpcb_tyre/models/request/retreader/retreader_view_request_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:flutter/material.dart';

class RetreadedAddDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

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

  Future<void> addRetreadedData(
      BuildContext context, RetreaderRequestModel request) async {
    var res;
    if (formKey.currentState?.validate() ?? false) {
      state = ViewState.busy;
      res = await _retreaderRepo.postRetreaderData(request);
      if (context.mounted) {
        HelperFunctions()
            .commonSuccessSnackBar(context, "Data added successfully");

        state = ViewState.idle;
        MaterialAppViewModel.selectedPageIndex = 2;
        Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.retraderHomeScreenRoute,
            ModalRoute.withName(AppRoutes.retraderHomeScreenRoute));
       
      }
    } else {
      HelperFunctions().commonErrorSnackBar(context, res);
      state = ViewState.idle;
    }

     
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
      yearDropdownError = "It is mandatory to select Financial year";
    }
  }

  String? quantityProcessedValidation() {
    if (quantityProcessedController.text.isEmpty) {
      return "It is mandatory to add Quantity Processed";
    }
    return null;
  }

  String? contactDetailsValidation() {
    return Validations().validatePhone(contactDetailsController.text);
  }

  String? quantityOfWasteGeneratedValidation() {
    if (quantityOfWasteGeneratedController.text.isEmpty) {
      return "It is mandatory to add waste generated";
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
      return "It is mandatory to add Quantity Produced";
    }
    if (quantityProducedController.text.isNotEmpty &&
        quantityProcessedController.text.isNotEmpty) {
      int quantityProcessed = int.parse(quantityProcessedController.text);
      int quantityProduced = int.parse(quantityProducedController.text);
      if (quantityProduced > quantityProcessed) {
        return "Quantity Produced can't be more than quantity processed";
      }
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
