import 'dart:io';
import 'dart:math';

import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/auditor/auditor_repository.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form1_request_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/file_size_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_player/video_player.dart';

class RecyclerFormViewModel extends BaseViewModel {
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
  TextEditingController aContactController = TextEditingController();
  TextEditingController aContactRemarksController = TextEditingController();
  TextEditingController aVerifiedController = TextEditingController();
  TextEditingController aVerifiedRemakrsController = TextEditingController();
  TextEditingController aNotVerifiedController = TextEditingController();
  TextEditingController bContactController = TextEditingController();
  TextEditingController bContactRemarksController = TextEditingController();
  TextEditingController bVerifiedController = TextEditingController();
  TextEditingController bVerifiedRemakrsController = TextEditingController();
  TextEditingController bNotVerifiedController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController remakrsInvoiceController = TextEditingController();
  TextEditingController buyersController = TextEditingController();
  TextEditingController remakrsBuyerController = TextEditingController();
  TextEditingController etpCapacityController = TextEditingController();
  TextEditingController etpRemarksInstalledController = TextEditingController();
  TextEditingController etpRemarksCapacityController = TextEditingController();
  TextEditingController summmaryRemakrController = TextEditingController();

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
  String radioxy = 'confirmed';
  String radiocd = 'confirmed';
  String radioAContact = 'confirmed';
  String radioAVerified = 'confirmed';
  String radioBContact = 'confirmed';
  String radioBVerified = 'confirmed';
  String radioInvoice = 'confirmed';
  String radioBuyer = 'confirmed';
  String radioInstalled = 'confirmed';
  String radioCapacity = 'confirmed';

  String? installDropdownValue;
  List installList = <String>[];

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
  String? fileSize;
  double? fileSizeNum;

  String? aadharFileName;
  String? panNoFileName;
  String? plantFileName;
  String? powerFileName;
  String? pollutionFileName;
  String? videoFileName;
  String? machineFileName;

  FileSizeModel? aadharFileSizeModel;
  FileSizeModel? panNoFileSizeModel;
  FileSizeModel? plantFileSizeModel;
  FileSizeModel? powerFileSizeModel;
  FileSizeModel? pollutionFileSizeModel;
  FileSizeModel? videoFileSizeModel;
  FileSizeModel? machineFileSizeModel;

  int count = 1;
  Position? currentLocation;
  Duration? videoDuration;
  int videoSize = 0;

  final imageConstants = ImageConstants();
  TextEditingController uploadInvoiceController = TextEditingController();
  List<TextEditingController> controllerList = [];
  List<TextEditingController> uploadControllerList = [];
  List<FileSizeModel> fileSizeModelList = [];
  APIResponse<AuditorRecyclerFormResponseModel?>? _auditorRecyclerResponseModel;
  APIResponse<AuditorRecyclerFormResponseModel?>?
      get auditorRecyclerResponseModel => _auditorRecyclerResponseModel;
  GeneralInfoResponse? generalInfoResponseData;
  EndProducts? endProductsData;
  final AuditorRepository auditorRepository = AuditorRepository();

  Future<APIResponse<AuditorRecyclerFormResponseModel?>?> getRecyclerData(
      BuildContext context,
      {String? url}) async {
    state = ViewState.busy;

    try {
      _auditorRecyclerResponseModel =
          await auditorRepository.getRecyclerData(url: url);
      if (_auditorRecyclerResponseModel?.isSuccess == true) {
        _auditorRecyclerResponseModel?.data =
            AuditorRecyclerFormResponseModel.fromJson(
                _auditorRecyclerResponseModel?.completeResponse);
        generalInfoResponseData =
            _auditorRecyclerResponseModel?.data?.generalInfo;
        endProductsData = _auditorRecyclerResponseModel?.data?.endProducts;
      } else {
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, MessageConstant().somethingWentWrong);
        }
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;

    return _auditorRecyclerResponseModel;
  }

  String? emptyValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

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
    gpsAuditorLatitude.text = "${currentLocation?.longitude}";
    gpsAuditorLongitude.text = "${currentLocation?.latitude}";
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
          aadharFileSizeModel = await getFileSize(aadharFilePath ?? "", 1);
          fileSize = aadharFileSizeModel?.fileSize ?? "0 B";
          aadharFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.panNo:
          final file = File(result.files.single.path ?? "");
          panNoFilePath = file.path;
          panNoFileSizeModel = await getFileSize(panNoFilePath ?? "", 1);
          fileSize = panNoFileSizeModel?.fileSize ?? "0 B";
          panNoFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.plant:
          final file = File(result.files.single.path ?? "");
          plantFilePath = file.path;
          plantFileSizeModel = await getFileSize(plantFilePath ?? "", 1);
          fileSize = plantFileSizeModel?.fileSize ?? "0 B";
          plantFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.pollution:
          final file = File(result.files.single.path ?? "");
          pollutionFilePath = file.path;
          pollutionFileSizeModel =
              await getFileSize(pollutionFilePath ?? "", 1);
          fileSize = pollutionFileSizeModel?.fileSize ?? "0 B";
          pollutionFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.power:
          final file = File(result.files.single.path ?? "");
          powerFilePath = file.path;
          powerFileSizeModel = await getFileSize(powerFilePath ?? "", 1);
          fileSize = powerFileSizeModel?.fileSize ?? "0 B";
          powerFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.video:
          final file = File(result.files.single.path ?? "");
          videoFilePath = file.path;
          videoFileSizeModel = await getFileSize(videoFilePath ?? "", 1);
          fileSize = videoFileSizeModel?.fileSize ?? "0 B";
          videoFileName = file.path.split('/').last;
          updateUI();
          break;
        case RecyclerForm1.machine:
          final file = File(result.files.single.path ?? "");
          machineFilePath = file.path;
          machineFileSizeModel = await getFileSize(machineFilePath ?? "", 1);
          fileSize = machineFileSizeModel?.fileSize ?? "0 B";
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

  String? videoValidation() {
    if (uploadVideoController.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    if (videoSize > 100 * 1024 * 1024) {
      return 'Selected video is larger than 100 MB. Please select another video.';
    } else if (videoDuration != null && videoDuration!.inSeconds > 30) {
      return 'Selected video is longer than 30 seconds. Please select another video.';
    }
    return null;
  }

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      String path = result.files.single.path!;
      File file = File(path);

      videoSize = await file.length();

      videoDuration = await _getVideoDuration(path);
      updateUI();
    }
  }

  Future<Duration?> _getVideoDuration(String videoPath) async {
    final VideoPlayerController controller =
        VideoPlayerController.file(File(videoPath));
    await controller.initialize();
    final duration = controller.value.duration;
    controller.dispose();
    return duration;
  }

  String? uploadValidation(FileSizeModel? fileSizeModel,
      {TextEditingController? controller}) {
    if (controller?.text.isEmpty ?? false) {
      return messageConstant.pleaseProvideValue;
    }
    if (fileSizeModel?.fileSize.contains("MB") ?? false) {
      if (fileSizeModel!.fileSizeNum > 2.0) {
        return messageConstant.maxFileSize;
      }
    }
    return null;
  }

  void textForm2Listener() {
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

  void textForm3Listener() {
    aContactController.addListener(() {
      totalValueA();
    });
    aVerifiedController.addListener(() {
      totalValueA();
    });
    bContactController.addListener(() {
      totalValueB();
    });
    bVerifiedController.addListener(() {
      totalValueB();
    });
  }

  void totalValueA() {
    int supplierContact = int.parse(
        aContactController.text.isEmpty ? "0" : aContactController.text);
    int verified = int.parse(
        aVerifiedController.text.isEmpty ? "0" : aVerifiedController.text);
    if (aContactController.text.isNotEmpty ||
        aVerifiedController.text.isNotEmpty) {
      aNotVerifiedController.text = (supplierContact - verified).toString();
    }
  }

  void totalValueB() {
    int supplierContact = int.parse(
        bContactController.text.isEmpty ? "0" : bContactController.text);
    int verified = int.parse(
        bVerifiedController.text.isEmpty ? "0" : bVerifiedController.text);
    if (bContactController.text.isNotEmpty ||
        bVerifiedController.text.isNotEmpty) {
      bNotVerifiedController.text = (supplierContact - verified).toString();
    }
  }

  String? summaryValidation() {
    if (summmaryRemakrController.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

  void changeDropdownValue(newValue) {
    installDropdownValue = newValue;
    updateUI();
  }

  final formKey = GlobalKey<FormState>();
  int index = 1;

  int totalIndex = 0;
  void getUser(String? user) {
    switch (user) {
      case "Producer":
        totalIndex = 3;
        break;
      case "Recycler":
        totalIndex = 5;
        break;
      default:
        totalIndex = 3;
        break;
    }
    updateUI();
  }

  void onBackButton(BuildContext context) {
    if (index > 1) {
      index--;
      updateUI();
    } else {
      Navigator.pop(context);
    }
  }

  void onNextButton(BuildContext context, String? user) {
    switch (user) {
      case "Producer":
        if (index < 3) {
          index++;
          updateUI();
        }
        break;
      case "Recycler":
        if (index < 5) {
          index++;
          updateUI();
        }
        break;
      default:
        if (index < 5) {
          index++;
          updateUI();
        }
        break;
    }
  }

  void addData() {
    AuditorRecyclerForm1RequestModel recyclerForm1RequestModel =
        AuditorRecyclerForm1RequestModel(
            generalInfo: GeneralInfo(
                gstNo: AddressLine1(
                    auditConfirmedStatus: radioGst,
                    auditRemark: gstRemarkController.text),
                companyPan: AddressLine1(
                    auditConfirmedStatus: radioPanOfCompany,
                    auditRemark: companyPanRemarkController.text),
                companyIec: AddressLine1(
                    auditConfirmedStatus: radioIec,
                    auditRemark: companyRemarkIECController.text),
                cto: AddressLine1(
                    auditConfirmedStatus: radioCto,
                    auditRemark: recyclerRemakrCTOController.text),
                authorizationUnderHomwRules: AddressLine1(
                    auditConfirmedStatus: radioAuthorization,
                    auditRemark: remarkAuthorizationController.text),
                addressLine1: AddressLine1(
                    auditConfirmedStatus: radioRecyclingDetails,
                    auditRemark: remarkRecyclingDetailsController.text),
                gpsLocationRecycler:
                    GpsLocationRecycler(auditConfirmedStatus: radioGps),
                gpsLocationAuditor: GpsLocationAuditor(
                  auditConfirmedStatus: radioGps,
                  auditRemark: gpsAuditorRemarkController.text,
                  additionalData: GpsLocationAuditorAdditionalData(
                      lat: gpsAuditorLatitude.text,
                      long: gpsAuditorLongitude.text),
                ),
                //TODO File Upload changes
                authorizedPersonAdhar: AirPollutionControlDevices(
                    auditRemark: remarkAadharController.text,
                    auditConfirmedStatus: radioAadharCard,
                    auditDocument: aadharFileName,
                    additionalData: AirPollutionControlDevicesAdditionalData()),
                authorizedPersonPan: AirPollutionControlDevices(
                    auditRemark: remarkPanNoController.text,
                    auditConfirmedStatus: radioPanNo,
                    auditDocument: panNoFileName,
                    additionalData: AirPollutionControlDevicesAdditionalData()),
                //TODO
                otherMachineries: OtherMachineries(
                    additionalData: OtherMachineriesAdditionalData(om: [Om()])),
                lastYearElectricityBill: AirPollutionControlDevices(
                    auditRemark: remarkPowerController.text,
                    auditConfirmedStatus: radioPowerConsumption,
                    auditDocument: powerFileName,
                    additionalData: AirPollutionControlDevicesAdditionalData()),
                airPollutionControlDevices: AirPollutionControlDevices(
                    auditRemark: remakrsPollutionController.text,
                    auditConfirmedStatus: radioPollution,
                    auditDocument: pollutionFileName,
                    additionalData: AirPollutionControlDevicesAdditionalData()),
                geoTaggedVideoUpload: AirPollutionControlDevices(
                    auditRemark: remarkVideoController.text,
                    auditConfirmedStatus: radioPlant,
                    auditDocument: videoFileName,
                    additionalData:
                        AirPollutionControlDevicesAdditionalData())));
  }

  void formValidation(BuildContext context, String? userType) {
    if (formKey.currentState?.validate() ?? false) {
      onNextButton(context, userType);
    } else {}
  }
}
