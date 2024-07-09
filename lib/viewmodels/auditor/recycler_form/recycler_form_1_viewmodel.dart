import 'dart:io';
import 'dart:math';

import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/response/common/file_size_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RecyclerForm1ViewModel extends BaseViewModel {
  final stringConstants = StringConstants();
  final messageConstant = MessageConstant();
  final helperFunctions = HelperFunctions();

  TextEditingController gstController = TextEditingController();
  TextEditingController gstRemarkController = TextEditingController();
  TextEditingController companyPanController = TextEditingController();
  TextEditingController companyPanRemarkController = TextEditingController();
  TextEditingController companyIECController = TextEditingController();
  TextEditingController companyRemarkIECController = TextEditingController();
  TextEditingController recyclerCTOController = TextEditingController();
  TextEditingController recyclerRemakrCTOController = TextEditingController();
  TextEditingController authorizationController = TextEditingController();
  TextEditingController remarkAuthorizationController = TextEditingController();

  TextEditingController recyclingDetailsController = TextEditingController();
  TextEditingController remarkRecyclingDetailsController =
      TextEditingController();
  TextEditingController gpsRecyclerLatitude = TextEditingController();
  TextEditingController gpsRecyclerLongitude = TextEditingController();
  TextEditingController gpsAuditorLatitude = TextEditingController();
  TextEditingController gpsAuditorLongitude = TextEditingController();
  TextEditingController gpsAuditorRemarkController = TextEditingController();

  TextEditingController aadharController = TextEditingController();
  TextEditingController remarkAadharController = TextEditingController();
  TextEditingController uploadAadharController = TextEditingController();
  TextEditingController panNoController = TextEditingController();
  TextEditingController remarkPanNoController = TextEditingController();
  TextEditingController uploadPanNoController = TextEditingController();

  TextEditingController uploadPowerController = TextEditingController();
  TextEditingController remarkPowerController = TextEditingController();

  TextEditingController pollutionController = TextEditingController();
  TextEditingController remakrsPollutionController = TextEditingController();
  TextEditingController uploadPollutionController = TextEditingController();

  TextEditingController remarkVideoController = TextEditingController();
  TextEditingController uploadVideoController = TextEditingController();

  String radioGst = "";
  String radioPanOfCompany = "";
  String radioIec = "";
  String radioCto = "";
  String radioAuthorization = "";
  String radioRecyclingDetails = "";
  String radioGps = "";
  String radioAadharCard = "";
  String radioPanNo = "";
  String radioPowerConsumption = "";
  String radioPollution = "";
  String radioPlant = "";

  MultipartFile? aadharFile;
  MultipartFile? panNoFile;
  MultipartFile? plantFile;
  MultipartFile? powerFile;
  MultipartFile? pollutionFile;
  MultipartFile? videoFile;
  MultipartFile? machineFile;

  String? aadharFilePath;
  String? panNoFilePath;
  String? plantFilePath;
  String? powerFilePath;
  String? pollutionFilePath;
  String? videoFilePath;
  String? machineFilePath;

  String? fileError;
  FileSizeModel? fileSizeModel;
  String? fileSize;
  double? fileSizeNum;

  String? aadharFileName;
  String? panNoFileName;
  String? plantFileName;
  String? powerFileName;
  String? pollutionFileName;
  String? videoFileName;
  String? machineFileName;

  int count = 1;
  Position? currentLocation;

  final imageConstants = ImageConstants();
  TextEditingController uploadInvoiceController = TextEditingController();
  List<TextEditingController> controllerList = [];
  List<TextEditingController> uploadControllerList = [];

  void initalizeGroupValues() {
    radioGst = stringConstants.confirmed;
    radioPanOfCompany = stringConstants.confirmed;
    radioIec = stringConstants.confirmed;
    radioCto = stringConstants.confirmed;
    radioAuthorization = stringConstants.confirmed;
    radioRecyclingDetails = stringConstants.confirmed;
    radioGps = stringConstants.confirmed;
    radioAadharCard = stringConstants.confirmed;
    radioPanNo = stringConstants.confirmed;
    radioPowerConsumption = stringConstants.confirmed;
    radioPollution = stringConstants.confirmed;
    radioPlant = stringConstants.confirmed;
  }

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
    if (controllerList[count - 1].text.isNotEmpty &&
        uploadControllerList[count - 1].text.isNotEmpty) {
      count++;
      addController();
      HelperFunctions().logger(controllerList.length.toString());
    }
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

  void handleOnSuffixTap(
    BuildContext context,
    RecyclerForm1 fieldName,
    TextEditingController controller,
    MultipartFile? selectedFileName,
  ) async {
    if (controller.text.isEmpty) {
      var res = await openFileManager(context, fieldName);

      if (res != null) {
        controller.text = res.files.isEmpty ? "" : res.files.first.name;
        selectedFileName = await MultipartFile.fromFile(
            res.files.first.path ?? '',
            filename: "uploadInvoice.pdf");
      }
    } else {
      switch (fieldName) {
        case RecyclerForm1.aadhar:
          controller.text = "";
          aadharFilePath = null;
          break;
        case RecyclerForm1.panNo:
          controller.text = "";
          panNoFilePath = null;
          break;
        case RecyclerForm1.plant:
          controller.text = "";
          plantFilePath = null;
          break;
        case RecyclerForm1.pollution:
          controller.text = "";
          pollutionFilePath = null;
          break;
        case RecyclerForm1.power:
          controller.text = "";
          powerFilePath = null;
          break;
        case RecyclerForm1.video:
          controller.text = "";
          videoFilePath = null;
          break;
        case RecyclerForm1.machine:
          controller.text = "";
          machineFilePath = null;
          break;
      }

      updateUI();
    }
  }

  void handleOnTap(
    BuildContext context,
    RecyclerForm1 fieldName,
    TextEditingController controller,
    MultipartFile? selectedFileName,
  ) async {
    if (controller.text.isEmpty) {
      var res = await openFileManager(context, fieldName);

      if (res != null) {
        controller.text = res.files.isEmpty ? "" : res.files.first.name;
        selectedFileName = await MultipartFile.fromFile(
            res.files.first.path ?? '',
            filename: "uploadInvoice.pdf");
      }
    } else {
      switch (fieldName) {
        case RecyclerForm1.aadhar:
          helperFunctions.openFile(aadharFilePath ?? '');
          break;
        case RecyclerForm1.panNo:
          helperFunctions.openFile(panNoFilePath ?? '');
          break;
        case RecyclerForm1.plant:
          helperFunctions.openFile(plantFilePath ?? '');

          break;
        case RecyclerForm1.pollution:
          helperFunctions.openFile(panNoFilePath ?? '');
          break;
        case RecyclerForm1.power:
          helperFunctions.openFile(powerFilePath ?? '');
          break;
        case RecyclerForm1.video:
          helperFunctions.openFile(videoFilePath ?? '');
          break;
        case RecyclerForm1.machine:
          helperFunctions.openFile(machineFilePath ?? '');
          break;
      }
    }
  }

  Future<FilePickerResult?> openFileManager(
      BuildContext context, RecyclerForm1 fieldName) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result != null) {
      switch (fieldName) {
        case RecyclerForm1.aadhar:
          final file = File(result.files.single.path ?? "");
          aadharFilePath = file.path;
          fileSizeModel = await getFileSize(aadharFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          aadharFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.panNo:
          final file = File(result.files.single.path ?? "");
          panNoFilePath = file.path;
          fileSizeModel = await getFileSize(panNoFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          panNoFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.plant:
          final file = File(result.files.single.path ?? "");
          plantFilePath = file.path;
          fileSizeModel = await getFileSize(plantFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          plantFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.pollution:
          final file = File(result.files.single.path ?? "");
          pollutionFilePath = file.path;
          fileSizeModel = await getFileSize(plantFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          pollutionFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.power:
          final file = File(result.files.single.path ?? "");
          powerFilePath = file.path;
          fileSizeModel = await getFileSize(powerFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          powerFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.video:
          final file = File(result.files.single.path ?? "");
          videoFilePath = file.path;
          fileSizeModel = await getFileSize(videoFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          videoFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.machine:
          final file = File(result.files.single.path ?? "");
          machineFilePath = file.path;
          fileSizeModel = await getFileSize(machineFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          machineFileName = file.path.split('/').last;
          updateUI();
          break;
      }
    } else {
      fileError = messageConstant.pleaseSelectFile;
      updateUI();
    }
    return result;
  }

  Future<FileSizeModel> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) {
      return FileSizeModel(fileSize: "0 B", fileSizeNum: 0);
    }
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    fileSizeNum = bytes / pow(1024, i);
    return FileSizeModel(
        fileSize:
            '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}',
        fileSizeNum: fileSizeNum ?? 0);
  }
}
