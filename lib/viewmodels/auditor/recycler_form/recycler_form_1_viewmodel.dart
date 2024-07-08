import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RecyclerForm1ViewModel extends BaseViewModel {
  int count = 1;
  Position? currentLocation;
  final imageConstants = ImageConstants();
  TextEditingController uploadInvoiceController = TextEditingController();
  List<TextEditingController> controllerList = [];
  List<TextEditingController> uploadControllerList = [];

  void addController() {
    if (count == controllerList.length + 1 &&
        count == uploadControllerList.length + 1) {
      TextEditingController tempController = TextEditingController();
      TextEditingController tempUploadController = TextEditingController();
      controllerList.add(tempController);
      uploadControllerList.add(tempUploadController);
    }
  }

  void removeController() {
    if (controllerList.length > 1) {
      controllerList.removeLast();
    }
    if (uploadControllerList.length > 1) {
      uploadControllerList.removeLast();
    }
  }

  void onAdd() {
    count++;
    addController();
    HelperFunctions().logger(controllerList.length.toString());
    updateUI();
  }

  void onDelete() {
    removeController();
    if (count > 1) {
      count--;
    }
    updateUI();
  }

  Future<void> getCurrentLocation() async {
    Position? position = await determinePosition();
    currentLocation = position;
    HelperFunctions().logger("${currentLocation?.longitude ?? 0}");
    HelperFunctions().logger("${currentLocation?.latitude ?? 0}");

    updateUI();
  }

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
    }
    if (permission == LocationPermission.whileInUse) {
      return await Geolocator.getCurrentPosition();
    }
    if (permission == LocationPermission.always) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }
}
