import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class SalesDataViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
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
  bool isClear = false;
  void clearMethod() {
    isClear = true;

    updateUI();
  }

  String? totalValidation() {
    if (totalController.text.isEmpty || totalController.text == "0") {
      return "Please enter data in atleast one of the above fields";
    }
    return null;
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
    totalController.text = total.toString();
    HelperFunctions().logger(total.toString());

    clearMethod();
    notifyListeners();
  }

  void changeDropdownValue(dropdownValue, newValue) {
    changeDropdown = newValue;
    updateUI();
    if (changeDropdown == null) {
      switch (dropdownValue) {
        case "producer":
          producerDropdownError = "Please select the value";
          updateUI();
          break;
        case "tyre":
          tyreDropdownError = "Please select the value";
          updateUI();
          break;
        case "year":
          yearDropdownError = "Please select the value";
          updateUI();
          break;
        case "month":
          monthDropdownError = "Please select the value";
          updateUI();
          break;
        default:
          updateUI();
      }
    }
  }
}
