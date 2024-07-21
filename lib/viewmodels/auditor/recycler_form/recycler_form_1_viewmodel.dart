import 'dart:io';
import 'dart:math';

import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/auditor/auditor_repository.dart';
import 'package:cpcb_tyre/models/request/auditor/document_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form1_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form4_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form5_request_model.dart';
import 'package:cpcb_tyre/models/response/auditor/document_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form1_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form2_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form3_reponse_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form4_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form5_response_model.dart';
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
  String radioxy = '1';
  String radiocd = '1';
  String radioAContact = '1';
  String radioAVerified = '1';
  String radioBContact = '1';
  String radioBVerified = '1';
  String radioInvoice = '1';
  String radioBuyer = '1';
  String radioInstalled = '1';
  String radioCapacity = '1';

  String? installDropdownValue;
  String? endProductDropdownValue;
  String? installDropdownError;
  String? endProductDropDownError;

  List installList = <String>[];
  List<String> typeOfEndProduct = [];

  MultipartFile? aadharFile;
  MultipartFile? panNoFile;
  MultipartFile? powerFile;
  MultipartFile? pollutionFile;
  MultipartFile? videoFile;
  List<MultipartFile?> machineFile = [];

  String? aadharFilePath;
  String? panNoFilePath;
  String? plantFilePath;
  String? powerFilePath;
  String? pollutionFilePath;
  String? videoFilePath;
  List<String?> machineFilePath = [];

  String? fileError;
  String? fileSize;
  List<String?> machineFileSize = [];
  double? fileSizeNum;

  String? aadharFileName;
  String? panNoFileName;
  String? plantFileName;
  String? powerFileName;
  String? pollutionFileName;
  String? videoFileName;
  List<String?> machineFileName = [];

  FileSizeModel? aadharFileSizeModel;
  FileSizeModel? panNoFileSizeModel;
  FileSizeModel? plantFileSizeModel;
  FileSizeModel? powerFileSizeModel;
  FileSizeModel? pollutionFileSizeModel;
  FileSizeModel? videoFileSizeModel;
  List<FileSizeModel?> machineFileSizeModel = [];

  int count = 1;
  Position? currentLocation;
  Duration? videoDuration;
  int videoSize = 0;

  final imageConstants = ImageConstants();
  TextEditingController uploadInvoiceController = TextEditingController();
  List<TextEditingController> controllerList = [];
  List<TextEditingController> uploadControllerList = [];
  List<TextEditingController> plantMachineryControllerList = [];
  List<String> plantMachineyRadioList = [];
  List<FileSizeModel> fileSizeModelList = [];
  List<OmRequest> omRequestList = [];

  APIResponse<AuditorRecyclerForm1ResponseModel?>?
      _auditorRecycler1ResponseModel;
  APIResponse<AuditorRecyclerForm1ResponseModel?>?
      get auditorRecycler1ResponseModel => _auditorRecycler1ResponseModel;
  APIResponse<AuditorRecyclerForm2ResponseModel?>?
      _auditorRecycler2ResponseModel;
  APIResponse<AuditorRecyclerForm2ResponseModel?>?
      get auditorRecycler2ResponseModel => _auditorRecycler2ResponseModel;

  APIResponse<AuditorRecyclerForm3ResponseModel?>?
      _auditorRecycler3ResponseModel;
  APIResponse<AuditorRecyclerForm3ResponseModel?>?
      get auditorRecycler3ResponseModel => _auditorRecycler3ResponseModel;

  APIResponse<AuditorRecyclerForm4ResponseModel?>?
      _auditorRecycler4ResponseModel;
  APIResponse<AuditorRecyclerForm4ResponseModel?>?
      get auditorRecycler4ResponseModel => _auditorRecycler4ResponseModel;

  APIResponse<AuditorRecyclerForm5ResponseModel?>?
      _auditorRecycler5ResponseModel;
  APIResponse<AuditorRecyclerForm5ResponseModel?>?
      get auditorRecycler5ResponseModel => _auditorRecycler5ResponseModel;

  GeneralInfoStep1Data? generalInfoResponseData;
  EndProducts? endProductsData;
  WasteWaterGenerationAndDisposal? wasteWaterGenerationAndDisposal;
  ProductionInfo? productionInfo;
  List<EprDatum>? eprData;
  List<Nw>? nw = [];
  ProcurementInfo? procurementInfo;
  List<ProcurementDatum>? procurementData;
  PlanCapacityAssesment? planCapacityAssesment;
  CAndDComparable? cAndDComparable;
  ElectricityVerification? electricityVerification;
  ValueComparable? valueComparable;

  final AuditorRepository auditorRepository = AuditorRepository();

  DocumentData? aadharDocument;
  DocumentData? authorizedPersonPanDocument;
  DocumentData? lastYearElectricityBillDocument;
  DocumentData? airPollutionControlDevicesDocument;
  DocumentData? otherMachineriesDocument;
  DocumentData? geoTaggedVideoUploadDocument;

  List<String> recyclerHeadingList = [
    "Name of Plant Machinery",
    "Capacity of Plant Machinery",
    "Power of Plant Machinery",
    "Action",
    "Remarks",
  ];

  String invoiceAuditConfirmedStatusError = "";
  String invoiceAdditionalDataNumberOfSuppliersContactedError = "";
  String invoiceAuditRemarkError = "";
  String buyersAuditConfirmedStatusError = "";
  String buyersAdditionalDataNumberOfBuyersContactedError = "";
  String buyersAuditRemarkError = "";
  String summaryAuditRemarkError = "";
  String gstNoAuditRemarkError = "";
  String companyPanAuditRemarkError = "";
  String ctoAuditRemarkError = "";
  String authorizationUnderHomwRulesAuditRemarkError = "";
  String addressLine1AuditRemarkError = "";
  String gpsLocationAuditorAdditionalDataLatError = "";
  String gpsLocationAuditorAdditionalDataLongError = "";
  String gpsLocationAuditorAuditRemarkError = "";
  String lastYearElectricityBillAuditDocumentError = "";
  String lastYearElectricityBillAuditRemarkError = "";
  String geoTaggedVideoUploadAuditDocumentError = "";
  String geoTaggedVideoUploadAuditRemarkError = "";

  Future<APIResponse<AuditorRecyclerForm1ResponseModel?>?> getRecycler1Data(
      BuildContext context,
      {String userId = "",
      bool isRetreader = false}) async {
    state = ViewState.busy;

    try {
      _auditorRecycler1ResponseModel = await auditorRepository.getRecyclerForm1Data(
          isRetreader: isRetreader,
          userId:
              "eyJpdiI6ImJYVTE0SDl6TXAwNE1HUEFqbmhoTEE9PSIsInZhbHVlIjoieXI3aHFvOW1CV2NLR2kxS3hvd1R6Zz09IiwibWFjIjoiZmI4OTVmNmY3Y2E2N2NlMTU2Mzg2OTIwMzllMmUwZjVjYzk3Mjk2MmJlMmI0YWZjMzBkNDZkNGQ1ZDY1ODI1MyIsInRhZyI6IiJ9");
      if (_auditorRecycler1ResponseModel?.isSuccess == true) {
        _auditorRecycler1ResponseModel?.data =
            AuditorRecyclerForm1ResponseModel.fromJson(
                _auditorRecycler1ResponseModel?.completeResponse);
        generalInfoResponseData =
            _auditorRecycler1ResponseModel?.data?.data?.generalInfo;
        List<Om>? machineList = _auditorRecycler1ResponseModel?.data?.data
                ?.auditSummary?.otherMachineries?.additionalData?.om ??
            [];

        count = machineList.length;
        updatePlantMachine();
        disableFormView();
        summaryFormView();
        for (int i = 0; i < machineList.length; i++) {
          uploadControllerList[i].text = machineList[i].auditDocument ?? '';
          controllerList[i].text = machineList[i].value ?? '';
        }
        updateUI();
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

    return _auditorRecycler1ResponseModel;
  }

  void updatePlantMachine() {
    for (int i = count; i > 1; i--) {
      TextEditingController tempController = TextEditingController();
      TextEditingController tempUploadController = TextEditingController();

      controllerList.add(tempController);
      uploadControllerList.add(tempUploadController);
      updateUI();
    }
  }

  Future<APIResponse<AuditorRecyclerForm2ResponseModel?>?> getRecycler2Data(
      BuildContext context,
      {String userId = "",
      bool isRetreader = false}) async {
    state = ViewState.busy;

    try {
      _auditorRecycler2ResponseModel = await auditorRepository.getRecyclerForm2Data(
          isRetreader: isRetreader,
          userId:
              "eyJpdiI6IkRzVzY2SENNOUF0dDM4bnZDK2t2N1E9PSIsInZhbHVlIjoiYk1VRm1ZWnQ0eXJHdWxoZW1TaGpXZz09IiwibWFjIjoiZDRlOGE5YTM5MzA0MjJmYzYzMGZjNDE2MzM2ZWJiNzg4YmJhZTcyMWNlNGMxNGY0ZTdlMzExYTQwZTlhZmJkZiIsInRhZyI6IiJ9");
      if (_auditorRecycler2ResponseModel?.isSuccess == true) {
        _auditorRecycler2ResponseModel?.data =
            AuditorRecyclerForm2ResponseModel.fromJson(
                _auditorRecycler2ResponseModel?.completeResponse);
        endProductsData =
            _auditorRecycler2ResponseModel?.data?.data?.endProducts;

        planCapacityAssesment = _auditorRecycler2ResponseModel
            ?.data?.data?.processingCapacity?.planCapacityAssesment;
        cAndDComparable = _auditorRecycler2ResponseModel
            ?.data?.data?.processingCapacity?.cAndDComparable;
        electricityVerification = _auditorRecycler2ResponseModel
            ?.data?.data?.processingCapacity?.electricityVerification;
        valueComparable = _auditorRecycler2ResponseModel
            ?.data?.data?.processingCapacity?.valueComparable;
        totalQuantitySalesController.text =
            "${_auditorRecycler2ResponseModel?.data?.data?.quantityOfSales ?? ""}";
        summaryForm2View();
        updateUI();
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

    return _auditorRecycler2ResponseModel;
  }

  Future<APIResponse<AuditorRecyclerForm3ResponseModel?>?> getRecycler3Data(
      BuildContext context,
      {String userId = "",
      bool isRetreader = false}) async {
    state = ViewState.busy;

    try {
      _auditorRecycler3ResponseModel = await auditorRepository.getRecyclerForm3Data(
          isRetreader: isRetreader,
          userId:
              "eyJpdiI6IkM3MlV2dWJ4d24xKzd0OHR0Mzh1NVE9PSIsInZhbHVlIjoiV0drbnlDRHFlRXY1TDJ6M2MzRVBGdz09IiwibWFjIjoiNDM0NDE0NzhmOTRiYmFiMWU5NjQ2NmNhNzU2NjI5YmY4NmFhMGU3Yzc5OTFlYzRhNzg5ZmQ4ZjVkZGFmMmE5YiIsInRhZyI6IiJ9");
      if (_auditorRecycler3ResponseModel?.isSuccess == true) {
        _auditorRecycler3ResponseModel?.data =
            AuditorRecyclerForm3ResponseModel.fromJson(
                _auditorRecycler3ResponseModel?.completeResponse);
        procurementInfo =
            _auditorRecycler3ResponseModel?.data?.data?.procurementInfo;
        procurementData =
            _auditorRecycler3ResponseModel?.data?.data?.procurementData;
        summaryForm3View();
        updateUI();
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

    return _auditorRecycler3ResponseModel;
  }

  Future<APIResponse<AuditorRecyclerForm4ResponseModel?>?> getRecycler4Data(
      BuildContext context,
      {String userId = "",
      bool isRetreader = false}) async {
    state = ViewState.busy;
    try {
      _auditorRecycler4ResponseModel = await auditorRepository.getRecyclerForm4Data(
          isRetreader: isRetreader,
          userId:
              "eyJpdiI6IkM3MlV2dWJ4d24xKzd0OHR0Mzh1NVE9PSIsInZhbHVlIjoiV0drbnlDRHFlRXY1TDJ6M2MzRVBGdz09IiwibWFjIjoiNDM0NDE0NzhmOTRiYmFiMWU5NjQ2NmNhNzU2NjI5YmY4NmFhMGU3Yzc5OTFlYzRhNzg5ZmQ4ZjVkZGFmMmE5YiIsInRhZyI6IiJ9");
      if (_auditorRecycler4ResponseModel?.isSuccess == true) {
        _auditorRecycler4ResponseModel?.data =
            AuditorRecyclerForm4ResponseModel.fromJson(
                _auditorRecycler4ResponseModel?.completeResponse);
        productionInfo =
            _auditorRecycler4ResponseModel?.data?.data?.productionInfo;
        eprData = _auditorRecycler4ResponseModel?.data?.data?.eprData;
        summaryForm4View();
        updateUI();
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
    return _auditorRecycler4ResponseModel;
  }

  Future<APIResponse<AuditorRecyclerForm5ResponseModel?>?> getRecycler5Data(
      BuildContext context,
      {String userId = "",
      bool isRetreader = false}) async {
    state = ViewState.busy;
    try {
      _auditorRecycler5ResponseModel = await auditorRepository.getRecyclerForm5Data(
          isRetreader: isRetreader,
          userId:
              "eyJpdiI6IkM3MlV2dWJ4d24xKzd0OHR0Mzh1NVE9PSIsInZhbHVlIjoiV0drbnlDRHFlRXY1TDJ6M2MzRVBGdz09IiwibWFjIjoiNDM0NDE0NzhmOTRiYmFiMWU5NjQ2NmNhNzU2NjI5YmY4NmFhMGU3Yzc5OTFlYzRhNzg5ZmQ4ZjVkZGFmMmE5YiIsInRhZyI6IiJ9");
      if (_auditorRecycler5ResponseModel?.isSuccess == true) {
        _auditorRecycler5ResponseModel?.data =
            AuditorRecyclerForm5ResponseModel.fromJson(
                _auditorRecycler5ResponseModel?.completeResponse);
        wasteWaterGenerationAndDisposal = _auditorRecycler5ResponseModel
            ?.data?.data?.wasteWaterGenerationAndDisposal;
        summaryForm5View();
        updateUI();
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
    return _auditorRecycler5ResponseModel;
  }

  String? emptyValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return messageConstant.pleaseProvideValue;
    }
    return null;
  }

  void initalizeGroupValues() {
    radioGst = stringConstants.radioValue2;
    radioPanOfCompany = stringConstants.radioValue2;
    radioIec = stringConstants.radioValue2;
    radioCto = stringConstants.radioValue2;
    radioAuthorization = stringConstants.radioValue2;
    radioRecyclingDetails = stringConstants.radioValue2;
    radioGps = stringConstants.radioValue2;
    radioAadharCard = stringConstants.radioValue2;
    radioPanNo = stringConstants.radioValue2;
    radioPowerConsumption = stringConstants.radioValue2;
    radioPollution = stringConstants.radioValue2;
    radioPlant = stringConstants.radioValue2;
  }

  void addController() {
    if (count == controllerList.length + 1 &&
        count == uploadControllerList.length + 1) {
      TextEditingController tempController = TextEditingController();
      TextEditingController tempUploadController = TextEditingController();
// MultipartFile? multiPartFile=
      controllerList.add(tempController);
      uploadControllerList.add(tempUploadController);
      updateUI();
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
    if ((controllerList[count - 1].text.isNotEmpty &&
        uploadControllerList[count - 1].text.isNotEmpty)) {
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
    state = ViewState.busy;
    Position? position = await determinePosition();
    currentLocation = position;
    gpsAuditorLatitude.text = "${currentLocation?.longitude}";
    gpsAuditorLongitude.text = "${currentLocation?.latitude}";
    HelperFunctions().logger("${currentLocation?.longitude ?? 0}");
    HelperFunctions().logger("${currentLocation?.latitude ?? 0}");
    state = ViewState.idle;
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
  ) async {
    if (controller.text.isEmpty) {
      var res = await openFileManager(context, fieldName);

      if (res != null) {
        controller.text = res.files.isEmpty ? "" : res.files.first.name;
        switch (fieldName) {
          case RecyclerForm1.aadhar:
            aadharFile = await MultipartFile.fromFile(
                res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.panNo:
            panNoFile = await MultipartFile.fromFile(res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.pollution:
            pollutionFile = await MultipartFile.fromFile(
                res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.power:
            powerFile = await MultipartFile.fromFile(res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.video:
            videoFile = await MultipartFile.fromFile(res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
        }

        DocumentRequestModel requestModel = DocumentRequestModel(
          aaddhar: aadharFile,
          airPollutionControlDevices: pollutionFile,
          authorizedPersonPan: panNoFile,
          geoTaggedVideoUpload: videoFile,
          lastYearElectricityBill: powerFile,
        );
        if (context.mounted) {
          await postDocumentData(context, requestModel, fieldName);
        }
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
      }

      updateUI();
    }

    updateUI();
  }

  void handleOnTap(
    BuildContext context,
    RecyclerForm1 fieldName,
    TextEditingController controller,
  ) async {
    if (controller.text.isEmpty) {
      var res = await openFileManager(context, fieldName);

      if (res != null) {
        controller.text = res.files.isEmpty ? "" : res.files.first.name;
        switch (fieldName) {
          case RecyclerForm1.aadhar:
            aadharFile = await MultipartFile.fromFile(
                res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.panNo:
            panNoFile = await MultipartFile.fromFile(res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.pollution:
            pollutionFile = await MultipartFile.fromFile(
                res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.power:
            powerFile = await MultipartFile.fromFile(res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
          case RecyclerForm1.video:
            videoFile = await MultipartFile.fromFile(res.files.first.path ?? '',
                filename: res.files.first.name);
            break;
        }
      }
    } else {
      switch (fieldName) {
        case RecyclerForm1.aadhar:
          helperFunctions.openFile(aadharFilePath ?? '');
          break;
        case RecyclerForm1.panNo:
          helperFunctions.openFile(panNoFilePath ?? '');
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
        // case RecyclerForm1.machine:
        //   helperFunctions.openFile(machineFilePath ?? '');
        //   break;
      }
    }
  }

  void disableFormView() {
    gstController.text = generalInfoResponseData?.gstNo ?? '';
    companyPanController.text = generalInfoResponseData?.companyPan ?? '';
    companyIECController.text = generalInfoResponseData?.companyIec ?? '';
    recyclerCTOController.text = generalInfoResponseData?.cto ?? '';
    authorizationController.text =
        generalInfoResponseData?.authorizationUnderHomwRules ?? '';
    recyclingDetailsController.text =
        generalInfoResponseData?.addressLine1 ?? '';
    gpsRecyclerLatitude.text = generalInfoResponseData?.lat ?? '';
    gpsRecyclerLongitude.text = generalInfoResponseData?.long ?? '';
    aadharController.text =
        generalInfoResponseData?.authorizedPersonAdhar ?? '';
    panNoController.text = generalInfoResponseData?.authorizedPersonPan ?? "";
    pollutionController.text =
        generalInfoResponseData?.airPollutionControlDevices ?? '';
  }

  void summaryFormView() {
    if (_auditorRecycler1ResponseModel != null) {
      Map<String, dynamic>? data = _auditorRecycler1ResponseModel
          ?.data?.data?.generalInfo?.detailsOfMachinery;
      data?.entries.forEach(
        (element) {
          nw?.add(Nw.fromJson(element.value));
          plantMachineryControllerList.add(TextEditingController());
          plantMachineyRadioList.add("1");
          updateUI();
        },
      );
      HelperFunctions().logger(nw.toString());
      HelperFunctions().logger(data.toString());
    }
    updateUI();
    final data = _auditorRecycler1ResponseModel?.data?.data?.auditSummary;
    gstRemarkController.text = data?.gstNo?.auditRemark ?? '';
    companyPanRemarkController.text = data?.companyPan?.auditRemark ?? '';
    companyRemarkIECController.text = data?.companyIec?.auditRemark ?? '';
    recyclerRemakrCTOController.text = data?.cto?.auditRemark ?? '';
    remarkAuthorizationController.text =
        data?.authorizationUnderHomwRules?.auditRemark ?? '';

    remarkRecyclingDetailsController.text =
        data?.addressLine1?.auditRemark ?? '';

    gpsAuditorLatitude.text =
        data?.gpsLocationAuditor?.additionalData?.lat ?? '';
    gpsAuditorLongitude.text =
        data?.gpsLocationAuditor?.additionalData?.long ?? '';
    gpsAuditorRemarkController.text =
        data?.gpsLocationAuditor?.auditRemark ?? '';

    remarkAadharController.text =
        data?.authorizedPersonAdhar?.auditRemark ?? '';
    uploadAadharController.text =
        data?.authorizedPersonAdhar?.auditDocument ?? '';
    remarkPanNoController.text = data?.authorizedPersonPan?.auditRemark ?? '';
    uploadPanNoController.text = data?.authorizedPersonPan?.auditDocument ?? '';

    uploadPowerController.text =
        data?.lastYearElectricityBill?.auditDocument ?? '';
    remarkPowerController.text =
        data?.lastYearElectricityBill?.auditRemark ?? '';

    remakrsPollutionController.text =
        data?.airPollutionControlDevices?.auditRemark ?? '';
    uploadPollutionController.text =
        data?.airPollutionControlDevices?.auditDocument ?? '';

    remarkVideoController.text = data?.geoTaggedVideoUpload?.auditRemark ?? '';
    uploadVideoController.text = data?.geoTaggedVideoUpload?.auditRemark ?? '';
    radioGst = "${data?.gstNo?.auditConfirmedStatus ?? ''}";
    radioPanOfCompany = "${data?.companyPan?.auditConfirmedStatus ?? ''}";
    radioIec = "${data?.companyIec?.auditConfirmedStatus ?? ''}";
    radioCto = "${data?.cto?.auditConfirmedStatus ?? ''}";
    radioAuthorization =
        "${data?.authorizationUnderHomwRules?.auditConfirmedStatus ?? ''}";
    radioRecyclingDetails = "${data?.addressLine1?.auditConfirmedStatus ?? ''}";
    radioGps = "${data?.gpsLocationAuditor?.auditConfirmedStatus ?? ''}";
    radioAadharCard =
        "${data?.authorizedPersonAdhar?.auditConfirmedStatus ?? ''}";
    radioPanNo = "${data?.companyPan?.auditConfirmedStatus ?? ''}";
    radioPowerConsumption =
        "${data?.lastYearElectricityBill?.auditConfirmedStatus ?? ''}";
    radioPollution =
        "${data?.airPollutionControlDevices?.auditConfirmedStatus ?? ''}";
    radioPlant = "${data?.geoTaggedVideoUpload?.auditConfirmedStatus ?? ''}";
  }

  void summaryForm2View() {
    if (endProductsData != null) {
      typeOfEndProduct.add(endProductsData?.scrumRubber ?? '');
      typeOfEndProduct.add(endProductsData?.crumRubber ?? '');
      typeOfEndProduct.add(endProductsData?.crmb ?? '');
      typeOfEndProduct.add(endProductsData?.recoveredCarbon ?? '');
      typeOfEndProduct.add(endProductsData?.pyrolisisOilBatch ?? '');
      typeOfEndProduct.add(endProductsData?.pyrolisisOilContinuous ?? '');
    }
    typeOfProductController.text =
        planCapacityAssesment?.additionalData?.typeOfEndProduct?.first ?? '';
    // endProductDropdownValue =
    //     planCapacityAssesment?.additionalData?.typeOfEndProduct?.first;
    plantProductionCapacityController.text =
        planCapacityAssesment?.additionalData?.plantProductionCapacity ?? '';

    endProductProducedController.text =
        planCapacityAssesment?.additionalData?.endProductProducedOnAuditDay ??
            '';
//daysPlantOperational is plantOperationalPerYear
    daysPlantOperationalController.text =
        planCapacityAssesment?.additionalData?.plantOperationalPerYear ?? '';
//hoursPlantOperational is plantOperationalPerShift
    hoursPlantOperationalController.text =
        planCapacityAssesment?.additionalData?.plantOperationalPerShift ?? '';
//shiftPlantOperational is PlantOperationalPerDay
    shiftPlantOperationalController.text =
        planCapacityAssesment?.additionalData?.plantOperationalPerDay ?? '';

    actualProcessingCapacityController.text =
        "${planCapacityAssesment?.additionalData?.actualProcessingCapacityDerived ?? ''}";

    differenceInActualProccessingController.text =
        "${valueComparable?.additionalData?.differenceInActualProcessing ?? ''}";

    uploadSalesController.text =
        "${valueComparable?.additionalData?.differenceInActualProcessing ?? ''}";
    powerConsumptionController.text =
        electricityVerification?.additionalData?.powerOnAuditDay ?? '';
    actualAverageAnnualController.text =
        "${electricityVerification?.additionalData?.annualPowerConsumption ?? ''}";

    totalElectricityController.text =
        electricityVerification?.additionalData?.totalElectricityConsumption ??
            '';
    areValuedCandDController.text = cAndDComparable?.auditRemark ?? '';
    radioxy = "${valueComparable?.auditConfirmedStatus ?? ''}";
    radiocd = "${cAndDComparable?.auditConfirmedStatus ?? ''}";
  }

  void summaryForm3View() {
    aContactController.text = procurementInfo?.contacted?.auditValue ?? '';
    aContactRemarksController.text =
        procurementInfo?.contacted?.auditRemark ?? '';
    aVerifiedController.text = procurementInfo?.verified?.auditValue ?? '';
    aVerifiedRemakrsController.text =
        procurementInfo?.verified?.auditRemark ?? '';
    bContactController.text =
        procurementInfo?.physicallyContacted?.auditValue ?? '';
    bContactRemarksController.text =
        procurementInfo?.physicallyContacted?.auditRemark ?? '';
    bVerifiedController.text =
        procurementInfo?.physicallyVerified?.auditValue ?? '';
    bVerifiedRemakrsController.text =
        procurementInfo?.physicallyVerified?.auditRemark ?? '';
    radioAContact = "${procurementInfo?.contacted?.auditConfirmedStatus ?? ''}";
    radioAVerified = "${procurementInfo?.verified?.auditConfirmedStatus ?? ''}";
    radioBContact =
        "${procurementInfo?.physicallyContacted?.auditConfirmedStatus ?? ''}";
    radioBVerified =
        "${procurementInfo?.physicallyContacted?.auditConfirmedStatus ?? ''}";
  }

  void summaryForm4View() {
    invoiceController.text = productionInfo?.invoice?.auditValue ?? '';
    remakrsInvoiceController.text = productionInfo?.invoice?.auditRemark ?? '';
    buyersController.text = productionInfo?.invoice?.auditValue ?? '';
    remakrsBuyerController.text = productionInfo?.buyers?.auditRemark ?? '';
    radioBuyer = "${productionInfo?.buyers?.auditConfirmedStatus ?? ''}";
    radioInvoice = "${productionInfo?.buyers?.auditConfirmedStatus ?? ''}";
  }

  void summaryForm5View() {
    etpRemarksInstalledController.text =
        wasteWaterGenerationAndDisposal?.etpInstalled?.auditRemark ?? '';
    radioInstalled =
        "${wasteWaterGenerationAndDisposal?.etpInstalled?.auditConfirmedStatus ?? ''}";
    etpCapacityController.text =
        wasteWaterGenerationAndDisposal?.etpCapacity?.auditValue ?? '';
    radioCapacity =
        "${wasteWaterGenerationAndDisposal?.etpCapacity?.auditConfirmedStatus ?? ''}";
    etpRemarksCapacityController.text =
        wasteWaterGenerationAndDisposal?.etpCapacity?.auditRemark ?? '';
    summmaryRemakrController.text =
        wasteWaterGenerationAndDisposal?.summary?.auditRemark ?? '';
  }

  Future<FilePickerResult?> openFileManager(
      BuildContext context, RecyclerForm1 fieldName) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["JPEG", "PNG"]);
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
          FilePickerResult? res = await pickVideo();
          final file = File(res?.files.single.path ?? '');
          videoFilePath = file.path;
          videoFileSizeModel = await getFileSize(videoFilePath ?? "", 1);
          fileSize = videoFileSizeModel?.fileSize ?? "0 B";
          videoFileName = file.path.split('/').last;
          updateUI();
          break;
        // case RecyclerForm1.machine:
        //   for (int i = count; i > 1; i++) {
        //     final file = File(result.files.single.path ?? "");
        //     machineFilePath = file.path;
        //     machineFileSizeModel[i] =
        //         await getFileSize(machineFilePath ?? "", 1);
        //     fileSize = machineFileSizeModel[i]?.fileSize ?? "0 B";
        //     machineFileName[i] = file.path.split('/').last;
        //     updateUI();
        //   }
        //   break;
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

  Future<FilePickerResult?> pickVideo() async {
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
    return result;
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

  void endProductChangeDropDown(newValue) {
    endProductDropdownValue = newValue;
    if (endProductDropdownValue == null) {
      endProductDropDownError = messageConstant.mandatoryTypeRawMaterial;
    }
    updateUI();
  }

  void installChangeDropdownValue(newValue) {
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

  Future<void> postDocumentData(BuildContext context,
      DocumentRequestModel request, RecyclerForm1 type) async {
    state = ViewState.busy;
    APIResponse<DocumentResponseModel?>? response;
    try {
      helperFunctions.logger("message >>>> ${request.toJson()}");
      response = await auditorRepository.postDocumentRequest(request);
      if (response?.isSuccess == true) {
        response?.data =
            DocumentResponseModel.fromJson(response.completeResponse);
        if (context.mounted) {
          state = ViewState.idle;
          setUploadFileData(type, response);
        }
      }
    } catch (e) {
      helperFunctions.logger('$e');
    }
    state = ViewState.idle;
  }

  void setUploadFileData(
      RecyclerForm1 type, APIResponse<DocumentResponseModel?>? response) {
    switch (type) {
      case RecyclerForm1.aadhar:
        aadharDocument = response?.data?.data;
        break;
      case RecyclerForm1.pollution:
        airPollutionControlDevicesDocument = response?.data?.data;
        break;
      case RecyclerForm1.panNo:
        authorizedPersonPanDocument = response?.data?.data;
        break;
      case RecyclerForm1.video:
        geoTaggedVideoUploadDocument = response?.data?.data;
        break;
      case RecyclerForm1.power:
        lastYearElectricityBillDocument = response?.data?.data;
        break;
    }
  }

  void formValidation(BuildContext context, String? userType) {
    if (formKey.currentState?.validate() ?? false) {
      onNextButton(context, userType);
    } else {}
  }

  Future<void> handleOnMachineSuffixTap(
    BuildContext context,
    TextEditingController controller,
  ) async {
    if (controller.text.isEmpty) {
      if (context.mounted) {
        var res = await openMachineFileManager(context);
        if (res != null) {
          controller.text = res.files.isEmpty ? "" : res.files.first.name;
          updateUI();
          helperFunctions.logger(uploadControllerList.length.toString());

          for (int i = 0; i < count; i++) {
            machineFile.add(await MultipartFile.fromFile(
                res.files.first.path ?? '',
                filename: res.files.first.name));
          }
        }
      }

      // for (int i = count; i > 1; i--) {
      //   DocumentRequestModel requestModel = DocumentRequestModel(
      //       aaddhar: aadharFile,
      //       airPollutionControlDevices: pollutionFile,
      //       authorizedPersonPan: panNoFile,
      //       geoTaggedVideoUpload: videoFile,
      //       lastYearElectricityBill: powerFile,
      //       otherMachineries: machineFile[i]);
      //   if (context.mounted) {
      //    await postDocumentData(context, requestModel, type);
      //   }
      // }
    } else {
      controller.text = "";
      machineFilePath = [];

      updateUI();
    }
  }

  Future<FilePickerResult?> openMachineFileManager(
    BuildContext context,
  ) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["JPEG", "PNG"]);
    for (int i = 0; i < count; i++) {
      if (result != null) {
        final file = File(result.files.single.path ?? "");
        machineFilePath.add(file.path);
        machineFileSizeModel
            .add(await getFileSize(machineFilePath[i] ?? "", 1));
        machineFileSize.add(machineFileSizeModel[i]?.fileSize ?? "0 B");
        machineFileName.add(file.path.split('/').last);
        updateUI();
        return result;
      } else {
        fileError = messageConstant.pleaseSelectFile;
        updateUI();
      }
    }
    return null;
  }

  List<OmRequest> getOmRequest() {
    for (int i = 0; i < controllerList.length; i++) {
      OmRequest omRequest = OmRequest(
          auditDocument: uploadControllerList[i].text,
          value: controllerList[i].text);
      omRequestList.add(omRequest);
    }
    return omRequestList;
  }

//Submit is "SavedAsDraft" to post data as Save as Draft, anyother value means submit
  Future<void> postForm1Data(BuildContext context,
      {String userId = "",
      bool isRetreader = false,
      String submit = "SaveAsDraft"}) async {
    AuditorRecyclerForm1RequestModel requestModel =
        AuditorRecyclerForm1RequestModel(
            submit: submit,
            generalInfo: GenerralInfoRequest(
                gstNo: AddressLine(
                    auditConfirmedStatus: radioGst,
                    auditRemark: gstRemarkController.text),
                companyPan: AddressLine(
                    auditConfirmedStatus: radioPanOfCompany,
                    auditRemark: companyPanRemarkController.text),
                companyIec: AddressLine(
                    auditConfirmedStatus: radioIec,
                    auditRemark: companyRemarkIECController.text),
                cto: AddressLine(
                    auditConfirmedStatus: radioCto,
                    auditRemark: recyclerRemakrCTOController.text),
                authorizationUnderHomwRules: AddressLine(
                    auditConfirmedStatus: radioAuthorization,
                    auditRemark: remarkAuthorizationController.text),
                addressLine1: AddressLine(
                    auditConfirmedStatus: radioRecyclingDetails,
                    auditRemark: remarkRecyclingDetailsController.text),
                gpsLocationRecycler:
                    GpsLocationRecycler(auditConfirmedStatus: radioGps),
                gpsLocationAuditor: GpsLocationAuditorRequest(
                  auditConfirmedStatus: radioGps,
                  auditRemark: gpsAuditorRemarkController.text,
                  additionalData: GpsLocationAuditorAdditionalDataRequest(
                      lat: gpsAuditorLatitude.text,
                      long: gpsAuditorLongitude.text),
                ),
                //TODO File Upload changes
                authorizedPersonAdhar: AirPollutionControlDevicesRequest(
                    auditRemark: remarkAadharController.text,
                    auditConfirmedStatus: radioAadharCard,
                    auditDocument: aadharFileName,
                    additionalData:
                        AirPollutionControlDevicesAdditionalDataRequest()),
                authorizedPersonPan: AirPollutionControlDevicesRequest(
                    auditRemark: remarkPanNoController.text,
                    auditConfirmedStatus: radioPanNo,
                    auditDocument: panNoFileName,
                    additionalData:
                        AirPollutionControlDevicesAdditionalDataRequest()),
                otherMachineries: OtherMachineriesRequest(
                    additionalData: OtherMachineriesAdditionalDataRequest(
                        om: getOmRequest())),
                lastYearElectricityBill: AirPollutionControlDevicesRequest(
                    auditRemark: remarkPowerController.text,
                    auditConfirmedStatus: radioPowerConsumption,
                    auditDocument: powerFileName,
                    additionalData:
                        AirPollutionControlDevicesAdditionalDataRequest()),
                airPollutionControlDevices: AirPollutionControlDevicesRequest(
                    auditRemark: remakrsPollutionController.text,
                    auditConfirmedStatus: radioPollution,
                    auditDocument: pollutionFileName,
                    additionalData:
                        AirPollutionControlDevicesAdditionalDataRequest()),
                geoTaggedVideoUpload: AirPollutionControlDevicesRequest(
                    auditRemark: remarkVideoController.text,
                    auditConfirmedStatus: radioPlant,
                    auditDocument: videoFileName,
                    additionalData:
                        AirPollutionControlDevicesAdditionalDataRequest())));

    state = ViewState.busy;
    try {
      final res = await auditorRepository.postRecyclerForm1Data(requestModel,
          userId: userId, isRetreader: isRetreader);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions()
              .commonSuccessSnackBar(context, res?.data?.message ?? "");
          await getRecycler2Data(context,
              isRetreader: isRetreader, userId: userId);
        }
      } else {
        final apiError = res?.error?.errorsList;

        gstNoAuditRemarkError =
            (apiError?.generalInfoGstNoAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.generalInfoGstNoAuditRemark?.first ?? "";
        companyPanAuditRemarkError =
            (apiError?.generalInfoCompanyPanAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.generalInfoCompanyPanAuditRemark?.first ?? "";
        ctoAuditRemarkError =
            (apiError?.generalInfoCtoAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.generalInfoCtoAuditRemark?.first ?? "";
        authorizationUnderHomwRulesAuditRemarkError =
            (apiError?.generalInfoAuthorizationUnderHomwRulesAuditRemark ?? [])
                    .isEmpty
                ? ""
                : apiError?.generalInfoAuthorizationUnderHomwRulesAuditRemark
                        ?.first ??
                    "";
        addressLine1AuditRemarkError =
            (apiError?.generalInfoAddressLine1AuditRemark ?? []).isEmpty
                ? ""
                : apiError?.generalInfoAddressLine1AuditRemark?.first ?? "";
        gpsLocationAuditorAdditionalDataLatError =
            (apiError?.generalInfoGpsLocationAuditorAdditionalDataLat ?? [])
                    .isEmpty
                ? ""
                : apiError?.generalInfoGpsLocationAuditorAdditionalDataLat
                        ?.first ??
                    "";
        gpsLocationAuditorAdditionalDataLongError =
            (apiError?.generalInfoGpsLocationAuditorAdditionalDataLong ?? [])
                    .isEmpty
                ? ""
                : apiError?.generalInfoGpsLocationAuditorAdditionalDataLong
                        ?.first ??
                    "";
        gpsLocationAuditorAuditRemarkError =
            (apiError?.generalInfoGpsLocationAuditorAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.generalInfoGpsLocationAuditorAuditRemark?.first ??
                    "";
        lastYearElectricityBillAuditDocumentError =
            (apiError?.generalInfoLastYearElectricityBillAuditDocument ?? [])
                    .isEmpty
                ? ""
                : apiError?.generalInfoLastYearElectricityBillAuditDocument
                        ?.first ??
                    "";
        gpsLocationAuditorAuditRemarkError =
            (apiError?.generalInfoGpsLocationAuditorAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.generalInfoGpsLocationAuditorAuditRemark?.first ??
                    "";
        lastYearElectricityBillAuditRemarkError =
            (apiError?.generalInfoLastYearElectricityBillAuditRemark ?? [])
                    .isEmpty
                ? ""
                : apiError?.generalInfoLastYearElectricityBillAuditRemark
                        ?.first ??
                    "";
        geoTaggedVideoUploadAuditDocumentError =
            (apiError?.generalInfoGeoTaggedVideoUploadAuditDocument ?? [])
                    .isEmpty
                ? ""
                : apiError
                        ?.generalInfoGeoTaggedVideoUploadAuditDocument?.first ??
                    "";
        geoTaggedVideoUploadAuditRemarkError =
            (apiError?.generalInfoGeoTaggedVideoUploadAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.generalInfoGeoTaggedVideoUploadAuditRemark?.first ??
                    "";
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, stringConstants.somethingWentWrong);
      }
    }
    updateUI();
    state = ViewState.idle;
  }

  Future<void> postForm4Data(BuildContext context,
      {String userId = "",
      bool isRetreader = false,
      String submit = "SaveAsDraft"}) async {
    AuditorRecyclerForm4RequestModel requestModel =
        AuditorRecyclerForm4RequestModel(
            productionInfo: ProductionInfoRequest(
              invoice: InvoiceRequest(
                  auditConfirmedStatus: radioInvoice,
                  auditRemark: remakrsInvoiceController.text,
                  additionalData: InvoiceAdditionalRequestData(
                      numberOfSuppliersContacted: invoiceController.text)),
              buyers: BuyersRequest(
                  auditConfirmedStatus: radioBuyer,
                  auditRemark: remakrsBuyerController.text,
                  additionalData: BuyersAdditionalRequestData(
                      numberOfBuyersContacted: buyersController.text)),
            ),
            submit: submit);
    state = ViewState.busy;
    try {
      final res = await auditorRepository.postRecyclerForm4Data(requestModel,
          userId: userId, isRetreader: isRetreader);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions()
              .commonSuccessSnackBar(context, res?.data?.message ?? "");
          await getRecycler5Data(context, isRetreader: isRetreader);
        }
      } else {
        final apiError = res?.error?.errorsList;
        invoiceAuditConfirmedStatusError =
            (apiError?.productionInfoInvoiceAuditConfirmedStatus ?? []).isEmpty
                ? ""
                : apiError?.productionInfoInvoiceAuditConfirmedStatus?.first ??
                    "";
        invoiceAdditionalDataNumberOfSuppliersContactedError = (apiError
                        ?.productionInfoInvoiceAdditionalDataNumberOfSuppliersContacted ??
                    [])
                .isEmpty
            ? ""
            : apiError
                    ?.productionInfoInvoiceAdditionalDataNumberOfSuppliersContacted
                    ?.first ??
                "";
        invoiceAuditRemarkError =
            (apiError?.productionInfoInvoiceAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.productionInfoInvoiceAuditRemark?.first ?? "";
        buyersAuditConfirmedStatusError =
            (apiError?.productionInfoBuyersAuditConfirmedStatus ?? []).isEmpty
                ? ""
                : apiError?.productionInfoBuyersAuditConfirmedStatus?.first ??
                    "";

        buyersAdditionalDataNumberOfBuyersContactedError =
            (apiError?.productionInfoInvoiceAuditConfirmedStatus ?? []).isEmpty
                ? ""
                : apiError?.productionInfoInvoiceAuditConfirmedStatus?.first ??
                    "";
        buyersAuditRemarkError =
            (apiError?.productionInfoBuyersAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.productionInfoBuyersAuditRemark?.first ?? "";
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, stringConstants.somethingWentWrong);
      }
    }
    updateUI();
    state = ViewState.idle;
  }

  Future<void> postForm5Data(BuildContext context,
      {String userId = "",
      bool isRetreader = false,
      String submit = "SaveAsDraft"}) async {
    AuditorRecyclerForm5RequestModel requestModel =
        AuditorRecyclerForm5RequestModel(
            submit: submit,
            wasteWaterGenerationAndDisposal:
                InvoiceAdditionalRequestDataRequest(
                    etpInstalled: EtpInstalledRequest(
                        auditConfirmedStatus: radioInstalled,
                        auditRemark: etpRemarksInstalledController.text,
                        additionalData: EtpInstalledAdditionalDataRequest(
                            operational: installDropdownValue)),
                    etpCapacity: EtpCapacityRequest(
                        auditConfirmedStatus: radioCapacity,
                        auditRemark: etpRemarksCapacityController.text,
                        additionalData: EtpCapacityAdditionalDataRequest(
                            capacity: etpCapacityController.text)),
                    summary: SummaryRequest(
                        auditRemark: summmaryRemakrController.text)));
    state = ViewState.busy;
    try {
      final res = await auditorRepository.postRecyclerForm5Data(requestModel);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions()
              .commonSuccessSnackBar(context, res?.data?.message ?? "");
        }
      } else {
        final apiError = res?.error?.errorsList;
        summaryAuditRemarkError =
            (apiError?.wasteWaterGenerationAndDisposalSummaryAuditRemark ?? [])
                    .isEmpty
                ? ""
                : apiError?.wasteWaterGenerationAndDisposalSummaryAuditRemark
                        ?.first ??
                    "";
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, stringConstants.somethingWentWrong);
      }
    }
    updateUI();
    state = ViewState.idle;
  }
}

class Details {
  final Nw? nw;
  Details(this.nw);
}
