import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/utils/validation/validation_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerForm2ViewModel extends BaseViewModel {
  final MessageConstant messageConstant = MessageConstant();
  TextEditingController typeOfProductController = TextEditingController();
  TextEditingController plantProductionCapacityController =
      TextEditingController();
  TextEditingController endProductProducedController = TextEditingController();
  TextEditingController daysPlantOperationalController =
      TextEditingController();
  TextEditingController hoursPlantOperationalController =
      TextEditingController();
  TextEditingController shiftPlantOperationalController =
      TextEditingController();
  TextEditingController actualProcessingCapacityController =
      TextEditingController();
  TextEditingController differenceInActualProccessingController =
      TextEditingController();
  TextEditingController totalQuantitySalesController = TextEditingController();
  TextEditingController uploadSalesController = TextEditingController();
  TextEditingController powerConsumptionController = TextEditingController();
  TextEditingController actualAverageAnnualController = TextEditingController();
  TextEditingController totalElectricityController = TextEditingController();
  TextEditingController areValuedCandDController = TextEditingController();

  String radioxy = 'confirmed';
  String radiocd = 'confirmed';

  String? numericValidation(TextEditingController controller) {
    return Validations().numberValidation(controller.text);
  }

  String? invoicesRemarkValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

  void textFormListener() {
    plantProductionCapacityController.addListener(() {
      actualProcessingValue();
    });
    endProductProducedController.addListener(() {
      actualProcessingValue();
    });
    daysPlantOperationalController.addListener(() {
      actualProcessingValue();
    });
    hoursPlantOperationalController.addListener(() {
      actualProcessingValue();
    });
    shiftPlantOperationalController.addListener(() {
      actualProcessingValue();
    });
    actualProcessingCapacityController.addListener(() {
      differenceInActualProcessingValue();
    });
    powerConsumptionController.addListener(() {
      actualAveragePowerValue();
    });
  }

  void actualAveragePowerValue() {
    int a = int.parse(powerConsumptionController.text.isEmpty
        ? "1"
        : powerConsumptionController.text);
    int b = int.parse(endProductProducedController.text.isEmpty
        ? "1"
        : endProductProducedController.text);
    int z = int.parse(totalQuantitySalesController.text.isEmpty
        ? "1"
        : totalQuantitySalesController.text);

    if (powerConsumptionController.text.isNotEmpty ||
        endProductProducedController.text.isNotEmpty ||
        totalQuantitySalesController.text.isNotEmpty) {
      actualAverageAnnualController.text = (a / b - z).toString();
    }
  }

  void differenceInActualProcessingValue() {
    int y = int.parse(actualProcessingCapacityController.text.isEmpty
        ? "1"
        : actualProcessingCapacityController.text);
    int z = int.parse(totalQuantitySalesController.text.isEmpty
        ? "1"
        : totalQuantitySalesController.text);

    if (differenceInActualProccessingController.text.isNotEmpty) {
      uploadSalesController.text = (y - 1.05 * z).toString();
    }
  }

  void actualProcessingValue() {
    int endProduct = int.parse(endProductProducedController.text.isEmpty
        ? "1"
        : endProductProducedController.text);
    int daysPlant = int.parse(daysPlantOperationalController.text.isEmpty
        ? "1"
        : daysPlantOperationalController.text);
    int hoursPlant = int.parse(hoursPlantOperationalController.text.isEmpty
        ? "1"
        : hoursPlantOperationalController.text);
    int shiftPlant = int.parse(shiftPlantOperationalController.text.isEmpty
        ? "1"
        : shiftPlantOperationalController.text);

    if (plantProductionCapacityController.text.isNotEmpty ||
        endProductProducedController.text.isNotEmpty ||
        daysPlantOperationalController.text.isNotEmpty ||
        hoursPlantOperationalController.text.isNotEmpty ||
        shiftPlantOperationalController.text.isNotEmpty) {
      actualProcessingCapacityController.text =
          (endProduct * daysPlant * hoursPlant * shiftPlant).toString();
    }
  }
}
