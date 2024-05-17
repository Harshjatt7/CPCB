import 'package:cpcb_tyre/constants/enums/enums.dart';
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
  List typesOfTyreList = <String>["Radials", "Bias Ply", "Solid"];
  List producerCategoryList = <String>["P1", "P2", "P3", "P4", "P5", "P6"];
  List financialYearList = <String>[];
  List listController = [];
  List monthList = <String>[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

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
    if ((totalController.text.isEmpty || totalController.text == "0")) {
      return "Please enter data in atleast one of the above fields";
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

  void formValidation() {
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
    totalController.text = total.toString();

    notifyListeners();
  }

  void changeDropdownValue(dropdownValue, newValue) {
    changeDropdown = newValue;

    updateUI();
    if (changeDropdown == null) {
      switch (dropdownValue) {
        case SalesDataDropdown.producerType:
          producerDropdownError = "Please select the value";

          updateUI();
          break;
        case SalesDataDropdown.typeOfTyre:
          tyreDropdownError = "Please select the value";
          updateUI();
          break;
        case SalesDataDropdown.financialYear:
          yearDropdownError = "Please select the value";
          updateUI();
          break;
        case SalesDataDropdown.month:
          monthDropdownError = "Please select the value";
          updateUI();
          break;
        default:
          updateUI();
      }
    }
  }
}
