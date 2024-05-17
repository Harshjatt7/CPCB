import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
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
      TextEditingController(text: "Retreaded tyre");
  TextEditingController gstController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityProcessedController = TextEditingController();
  TextEditingController quantityProducedController = TextEditingController();
  TextEditingController quantityOfWasteGeneratedController =
      TextEditingController();

  List financialYearList = <String>[];

  void addYear() {
    for (int i = 0; i < 50; i++) {
      financialYearList.add("${DateTime.now().year + (i)}");
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

  String? contactValidation() {
    return Validations()
        .validatePhoneWithCountryCode(contactDetailsController.text);
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
    if (formKey.currentState?.validate() ?? false) {}
  }
}
