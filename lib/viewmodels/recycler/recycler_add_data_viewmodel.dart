import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerAddDataViewModel extends BaseViewModel {
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

  void formValidation() {
    if (changeDropdown == null) {
      changeDropdownValue(null);
    }
    if (formKey.currentState?.validate() ?? false) {}
  }
}
