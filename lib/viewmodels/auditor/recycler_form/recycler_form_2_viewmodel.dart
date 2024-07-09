import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerForm2ViewModel extends BaseViewModel {
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
}
