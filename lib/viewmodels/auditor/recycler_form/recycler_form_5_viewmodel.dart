import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';

class RecyclerForm5ViewModel extends BaseViewModel {
  TextEditingController etpCapacityController = TextEditingController();
  TextEditingController etpRemarksInstalledController = TextEditingController();
  TextEditingController etpRemarksCapacityController = TextEditingController();
  TextEditingController summmaryRemakrController = TextEditingController();

  String radioInstalled = 'confirmed';
  String radioCapacity = 'confirmed';
}
