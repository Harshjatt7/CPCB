import 'dart:io';
import 'dart:math';

import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/enums/state_enums.dart';
import 'package:cpcb_tyre/constants/image_constants.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/store_key_constants.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/controllers/auditor/auditor_repository.dart';
import 'package:cpcb_tyre/models/request/auditor/auditor_post_request_model.dart';
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
import 'package:localization/localization.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/routes_constant.dart';
import '../../../models/request/auditor/recycler/recycler_form_2_request_model.dart';
import '../../../models/request/auditor/recycler/recycler_form_3_request_model.dart';
import '../../../models/response/filter/checkbox_filter_model.dart';
import '../../material_app_viewmodel.dart';

class RecyclerFormViewModel extends BaseViewModel {
  final stringConstants = StringConstants();
  final messageConstant = MessageConstant();
  final storeKeyConstants = StoreKeyConstants();
  final helperFunctions = HelperFunctions();
  TextEditingController? endProductDataListController;
  List<CheckboxFilterModel> endProductsList = [];
  List<String> selectedEndProductsData = [];
  List<String> emptyendProductsList = [];
  void updateCheckBox(bool val, int index) {
    endProductsList[index].isChecked =
        !(endProductsList[index].isChecked ?? false);

    if (val == true) {
      if (!(selectedEndProductsData.contains(endProductsList[index].title))) {
        selectedEndProductsData.add(endProductsList[index].title);
      }
    } else {
      if ((selectedEndProductsData.contains(endProductsList[index].title))) {
        selectedEndProductsData.remove(endProductsList[index].title);
      }
    }
    endProductDataListController?.text =
        selectedEndProductsData.join(",").i18n();
  }

  TextEditingController? gstController;
  TextEditingController? gstRemarkController;
  TextEditingController? companyPanController;
  TextEditingController? companyPanRemarkController;
  TextEditingController? companyIECController;
  TextEditingController? companyRemarkIECController;
  TextEditingController? recyclerCTOController;
  TextEditingController? recyclerRemakrCTOController;
  TextEditingController? authorizationController;
  TextEditingController? remarkAuthorizationController;

  TextEditingController? recyclingDetailsController;
  TextEditingController? remarkRecyclingDetailsController =
      TextEditingController();
  TextEditingController? gpsRecyclerLatitude;
  TextEditingController? gpsRecyclerLongitude;
  TextEditingController? gpsAuditorLatitude;
  TextEditingController? gpsAuditorLongitude;
  TextEditingController? gpsAuditorRemarkController;

  TextEditingController? aadharController;
  TextEditingController? remarkAadharController;
  TextEditingController? uploadAadharController;
  TextEditingController? panNoController;
  TextEditingController? remarkPanNoController;
  TextEditingController? uploadPanNoController;

  TextEditingController? uploadPowerController;
  TextEditingController? remarkPowerController;

  TextEditingController? pollutionController;
  TextEditingController? remakrsPollutionController;
  TextEditingController? uploadPollutionController;

  TextEditingController? remarkVideoController;
  TextEditingController? uploadVideoController;
  TextEditingController? typeOfProductController;
  TextEditingController? plantProductionCapacityController;
  TextEditingController? endProductProducedController;
  TextEditingController? daysPlantOperationalController;
  TextEditingController? hoursPlantOperationalController;
  TextEditingController? shiftPlantOperationalController;
  TextEditingController? actualProcessingCapacityController;
  TextEditingController? differenceInActualProccessingController;
  TextEditingController? totalQuantitySalesController;
  TextEditingController? uploadSalesController;
  TextEditingController? powerConsumptionController;
  TextEditingController? actualAverageAnnualController;
  TextEditingController? totalElectricityController;
  TextEditingController? areValuedCandDController;
  TextEditingController? procurementInfoContact;
  TextEditingController? procurementInfoContactRemarks;
  TextEditingController? procurementInfoAuditVerified;
  TextEditingController? procurmentInfoVerifiedRemark;
  TextEditingController? aNotVerifiedController;
  TextEditingController? physicallyContactedValue;
  TextEditingController? physicallyContactedRemark;
  TextEditingController? physicallyVerifiedValue;
  TextEditingController? physicallyVerifiedRemark;
  TextEditingController? bNotVerifiedController;
  TextEditingController? invoiceController;
  TextEditingController? remakrsInvoiceController;
  TextEditingController? buyersController;
  TextEditingController? remakrsBuyerController;
  TextEditingController? etpCapacityController;
  TextEditingController? etpRemarksInstalledController;
  TextEditingController? etpRemarksCapacityController;
  TextEditingController? summmaryRemakrController;
  TextEditingController? selectDropDownController;

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
  String radioProcurementInfoContact = '1';
  String radioProcurementInfoVerified = '1';
  String radioProcurementInfoPhysicallyContacted = '1';
  String radioProcurementInfoPhysicallyVerified = '1';
  String radioInvoice = '1';
  String radioBuyer = '1';
  String radioInstalled = '1';
  String radioCapacity = '1';

  String? installDropdownValue;
  String? endProductDropdownValue;
  String? installDropdownError;
  String? endProductDropDownError;

  List installList = <String>[];
  List<String> typeOfEndProduct = ["Select"];

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

  List<Om> machineList = [];

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
  Position? position;

  void initializeForm1TextEditingControllers() async {
    gstController = TextEditingController();
    gstRemarkController = TextEditingController();
    companyPanController = TextEditingController();
    companyPanRemarkController = TextEditingController();
    companyIECController = TextEditingController();
    companyRemarkIECController = TextEditingController();
    recyclerCTOController = TextEditingController();
    recyclerRemakrCTOController = TextEditingController();
    authorizationController = TextEditingController();
    remarkAuthorizationController = TextEditingController();

    recyclingDetailsController = TextEditingController();
    remarkRecyclingDetailsController = TextEditingController();

    gpsRecyclerLatitude = TextEditingController();
    gpsRecyclerLongitude = TextEditingController();
    gpsAuditorLatitude = TextEditingController();
    gpsAuditorLongitude = TextEditingController();
    gpsAuditorRemarkController = TextEditingController();

    aadharController = TextEditingController();
    remarkAadharController = TextEditingController();
    uploadAadharController = TextEditingController();
    panNoController = TextEditingController();
    remarkPanNoController = TextEditingController();
    uploadPanNoController = TextEditingController();

    uploadPowerController = TextEditingController();
    remarkPowerController = TextEditingController();

    pollutionController = TextEditingController();
    remakrsPollutionController = TextEditingController();
    uploadPollutionController = TextEditingController();

    remarkVideoController = TextEditingController();
    uploadVideoController = TextEditingController();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await getCurrentLocation();
    // });
  }

  void initializeForm2TextEditingController() {
    areValuedCandDController = TextEditingController();
    endProductDataListController = TextEditingController();
    typeOfProductController = TextEditingController();
    totalElectricityController = TextEditingController();
    actualAverageAnnualController = TextEditingController();
    powerConsumptionController = TextEditingController();
    uploadSalesController = TextEditingController();
    totalQuantitySalesController = TextEditingController();
    differenceInActualProccessingController = TextEditingController();
    actualProcessingCapacityController = TextEditingController();
    shiftPlantOperationalController = TextEditingController();
    hoursPlantOperationalController = TextEditingController();
    daysPlantOperationalController = TextEditingController();
    endProductProducedController = TextEditingController();
    plantProductionCapacityController = TextEditingController();
    textForm2Listener();
  }

  void initializeForm3TextEditingController() {
    physicallyVerifiedValue = TextEditingController();
    physicallyContactedValue = TextEditingController();
    procurementInfoAuditVerified = TextEditingController();
    procurementInfoContact = TextEditingController();
    bNotVerifiedController = TextEditingController();
    physicallyVerifiedRemark = TextEditingController();
    physicallyContactedRemark = TextEditingController();
    procurmentInfoVerifiedRemark = TextEditingController();
    procurementInfoContactRemarks = TextEditingController();
    aNotVerifiedController = TextEditingController();
    textForm3Listener();
  }

  void initializeForm4TextEditingController() {
    remakrsBuyerController = TextEditingController();
    buyersController = TextEditingController();
    remakrsInvoiceController = TextEditingController();
    invoiceController = TextEditingController();
  }

  void initializeForm5TextEditingController() {
    summmaryRemakrController = TextEditingController();
    etpRemarksCapacityController = TextEditingController();
    etpCapacityController = TextEditingController();
    etpRemarksInstalledController = TextEditingController();
    selectDropDownController = TextEditingController();
  }

  final imageConstants = ImageConstants();
  TextEditingController? uploadInvoiceController;
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
  List<MachineryResponse>? detailOfMachineryList = [];
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
  List<DocumentData?> otherMachineriesDocument = [];
  DocumentData? geoTaggedVideoUploadDocument;

  //Form1
  String? gstNoAuditRemarkError = "";
  String? detailsOfMachineryRemarkError = "";
  String? companyPanAuditRemarkError = "";
  String? ctoAuditRemarkError = "";
  String? authorizationUnderHomwRulesAuditRemarkError = "";
  String? addressLine1AuditRemarkError = "";
  String? gpsLocationAuditorAdditionalDataLatError = "";
  String? gpsLocationAuditorAdditionalDataLongError = "";
  String? gpsLocationAuditorAuditRemarkError = "";
  String? lastYearElectricityBillAuditDocumentError = "";
  String? lastYearElectricityBillAuditRemarkError = "";
  String? geoTaggedVideoUploadAuditDocumentError = "";
  String? geoTaggedVideoUploadAuditRemarkError = "";
  String? otherMachineriesError = "";
  String? aadhaarcardError = "";
  String? authorizedPersonPanError = "";
  String? lastYearElectricityBillError = "";
  String? airPollutionControlDevicesError = "";
  String? geoTaggedVideoUploadError = "";

//Form 2
  String? contactedSuppliersError;
  String? contactedAuditRemarkError;
  String? verifiedSuppliersError;
  String? verifiedAuditRemarkError;
  String? physicallyContactedSuppliersError;
  String? physicallyContactedAuditRemarkError;
  String? physicallyVerifiedSuppliersError;
  String? physicallyVerifiedAuditRemarkError;

//Form 3
  String? capacityTypeofEndProductError;
  String? plantProductionCapacityError;
  String? endProductProducedAuditDayError;
  String? plantPerYearError;
  String? plantPerDayError;
  String? plantPerShiftError;
  String? actualProcessingCapacityError;
  String? powerOnAuditDayError;
  String? totalElectricityConsumptionError;

  //Form4
  String? invoiceAuditConfirmedStatusError = "";
  String? invoiceAdditionalDataNumberOfSuppliersContactedError = "";
  String? invoiceAuditRemarkError = "";
  String? buyersAuditConfirmedStatusError = "";
  String? buyersAdditionalDataNumberOfBuyersContactedError = "";
  String? buyersAuditRemarkError = "";
  String? numberOfBuyerContactedError = "";

  //Form5
  String summaryAuditRemarkError = "";

  int index = 1;

  Future<void> onNextButton(
      BuildContext context, String id, bool isRetreader) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (index < 5) {
        index++;
        switch (index) {
          case 1:
            await getRecycler1Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 2:
            await getRecycler2Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 3:
            await getRecycler3Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 4:
            await getRecycler4Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 5:
            await getRecycler5Data(context,
                userId: id, isRetreader: isRetreader);
            break;
        }
        updateUI();
      } else {
        Navigator.pop(context);
      }
    });
  }

  void onBackButton(BuildContext context, String id, bool isRetreader) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (index > 1) {
        index--;
        switch (index) {
          case 1:
            await getRecycler1Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 2:
            await getRecycler2Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 3:
            await getRecycler3Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 4:
            await getRecycler4Data(context,
                userId: id, isRetreader: isRetreader);
            break;
          case 5:
            await getRecycler5Data(context,
                userId: id, isRetreader: isRetreader);
            break;
        }
      } else {
        MaterialAppViewModel.selectedPageIndex = 1;
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.auditorHomeScreen,
            ModalRoute.withName(AppRoutes.auditorHomeScreen));
      }
    });

    updateUI();
  }

  void getIndex(num? progress) {
    switch (progress) {
      case 0:
        index = 1;
        break;
      case 20:
        index = 2;
        break;
      case 40:
        index = 3;
        break;
      case 60:
        index = 4;
        break;
      case 80:
        index = 5;
        break;
      default:
        index = 1;
    }
    updateUI();
  }

  Future<void> recyclerPostForm2Data(BuildContext context,
      {String? id, bool? isRetreader, String? saveAsDraft}) async {
    state = ViewState.busy;
    RecyclerForm2RequestModel requestModel = RecyclerForm2RequestModel(
      processingCapacity: ProcessingCapacityRequest(
        planCapacityAssesment: PlanCapacityAssesmentRequest(
          additionalData: PlanCapacityAssesmentRequestAdditionalData(
            typeOfEndProduct: selectedEndProductsData,
            plantProductionCapacity: plantProductionCapacityController?.text,
            endProductProducedOnAuditDay: endProductProducedController?.text,
            plantOperationalPerYear: hoursPlantOperationalController?.text,
            plantOperationalPerDay: daysPlantOperationalController?.text,
            plantOperationalPerShift: shiftPlantOperationalController?.text,
            actualProcessingCapacityRequestDerived:
                actualProcessingCapacityController?.text.isNotEmpty ?? false
                    ? double.parse(
                        actualProcessingCapacityController?.text ?? "",
                      )
                    : 0,
          ),
        ),
        valueComparable: ValueComparableRequest(
          auditConfirmedStatus: radioxy,
          additionalData: ValueComparableRequestAdditionalData(
            actualProcessingCapacityRequest:
                actualProcessingCapacityController?.text,
            differenceInActualProcessing:
                differenceInActualProccessingController?.text.isNotEmpty ??
                        false
                    ? double.parse(
                        differenceInActualProccessingController?.text ?? "")
                    : 0,
          ),
        ),
        electricityVerification: ElectricityVerificationRequest(
          additionalData: ElectricityVerificationRequestAdditionalData(
            powerOnAuditDay: powerConsumptionController?.text,
            totalElectricityConsumption: totalElectricityController?.text,
            annualPowerConsumption:
                actualAverageAnnualController?.text.isNotEmpty ?? false
                    ? double.parse(actualAverageAnnualController?.text ?? "")
                    : 0,
          ),
        ),
        cAndDComparable: CAndDComparableRequest(
          auditConfirmedStatus: radiocd,
          auditRemark: areValuedCandDController?.text,
        ),
      ),
      auditPlanId: id,
      submit: saveAsDraft ?? "",
    );

    try {
      final res = await auditorRepository.postRecyclerForm2Data(requestModel,
          isRetreader: isRetreader);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
          if (saveAsDraft == null) {
            if (context.mounted) {
              onNextButton(context, id ?? "", isRetreader ?? false);
            }
          }
        }
      } else {
        final apiError = res?.error?.errorsList;

        capacityTypeofEndProductError =
            (apiError?.capacityTypeofEndProduct ?? []).isEmpty
                ? ""
                : apiError?.capacityTypeofEndProduct?.first ?? "";
        plantProductionCapacityError =
            (apiError?.plantProductionCapacity ?? []).isEmpty
                ? ""
                : apiError?.plantProductionCapacity?.first ?? "";
        endProductProducedAuditDayError =
            (apiError?.endProductProducedAuditDay ?? []).isEmpty
                ? ""
                : apiError?.endProductProducedAuditDay?.first ?? "";
        plantPerYearError = (apiError?.plantPerYear ?? []).isEmpty
            ? ""
            : apiError?.plantPerYear?.first ?? "";
        plantPerDayError = (apiError?.plantPerDay ?? []).isEmpty
            ? ""
            : apiError?.plantPerDay?.first ?? "";
        plantPerShiftError = (apiError?.plantPerShift ?? []).isEmpty
            ? ""
            : apiError?.plantPerShift?.first ?? "";
        actualProcessingCapacityError =
            (apiError?.actualProcessingCapacity ?? []).isEmpty
                ? ""
                : apiError?.actualProcessingCapacity?.first ?? "";
        powerOnAuditDayError = (apiError?.powerOnAuditDay ?? []).isEmpty
            ? ""
            : apiError?.powerOnAuditDay?.first ?? "";
        totalElectricityConsumptionError =
            (apiError?.totalElectricityConsumption ?? []).isEmpty
                ? ""
                : apiError?.totalElectricityConsumption?.first ?? "";
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

  Future<void> recyclerPostForm3Data(BuildContext context,
      {String? id, bool? isRetreader, String? saveAsDraft}) async {
    state = ViewState.busy;
    RecyclerForm3RequestModel requestModel = RecyclerForm3RequestModel(
      procurementInfo: ProcurementInfoRequest(
        contacted: ContactedRequest(
          additionalData: ContactedRequestAdditionalData(
              suppliers: procurementInfoContact?.text.isNotEmpty ?? false
                  ? double.parse(procurementInfoContact?.text ?? "")
                  : null),
          auditConfirmedStatus: radioProcurementInfoContact,
          auditRemark: procurementInfoContactRemarks?.text,
        ),
        physicallyContacted: ContactedRequest(
            auditConfirmedStatus: radioProcurementInfoVerified,
            auditRemark: procurmentInfoVerifiedRemark?.text,
            additionalData: ContactedRequestAdditionalData(
                suppliers: physicallyContactedValue?.text.isNotEmpty ?? false
                    ? double.parse(physicallyContactedValue?.text ?? "")
                    : null)),
        physicallyVerified: VerifiedRequest(
          auditConfirmedStatus: radioProcurementInfoPhysicallyVerified,
          auditRemark: physicallyVerifiedRemark?.text,
          additionalData: PhysicallyVerifiedRequestAdditionalData(
            suppliers: physicallyVerifiedValue?.text.isNotEmpty ?? false
                ? double.parse(physicallyVerifiedValue?.text ?? "")
                : null,
            suppliersNotVerifiedRequest:
                bNotVerifiedController?.text.isNotEmpty ?? false
                    ? double.parse(bNotVerifiedController?.text ?? "")
                    : null,
          ),
        ),
        verified: VerifiedRequest(
          auditConfirmedStatus: radioProcurementInfoPhysicallyContacted,
          auditRemark: physicallyContactedRemark?.text,
          additionalData: PhysicallyVerifiedRequestAdditionalData(
            suppliers: procurementInfoAuditVerified?.text.isNotEmpty ?? false
                ? double.parse(procurementInfoAuditVerified?.text ?? "")
                : null,
            suppliersNotVerifiedRequest:
                bNotVerifiedController?.text.isNotEmpty ?? false
                    ? double.parse(bNotVerifiedController?.text ?? "")
                    : null,
          ),
        ),
      ),
      auditPlanId: id,
      submit: saveAsDraft ?? "",
    );
    try {
      final res = await auditorRepository.postRecyclerForm3Data(requestModel,
          isRetreader: isRetreader);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
          if (saveAsDraft == null) {
            if (context.mounted) {
              onNextButton(context, id ?? "", isRetreader ?? false);
            }
          }
        }
      } else {
        final apiError = res?.error?.errorsList;

        contactedSuppliersError = (apiError?.contactedSuppliers ?? []).isEmpty
            ? ""
            : apiError?.contactedSuppliers?.first ?? "";
        contactedAuditRemarkError =
            (apiError?.contactedAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.contactedAuditRemark?.first ?? "";
        verifiedSuppliersError = (apiError?.verifiedSuppliers ?? []).isEmpty
            ? ""
            : apiError?.verifiedSuppliers?.first ?? "";
        verifiedAuditRemarkError = (apiError?.verifiedAuditRemark ?? []).isEmpty
            ? ""
            : apiError?.verifiedAuditRemark?.first ?? "";
        physicallyContactedSuppliersError =
            (apiError?.physicallyContactedSuppliers ?? []).isEmpty
                ? ""
                : apiError?.physicallyContactedSuppliers?.first ?? "";
        physicallyContactedAuditRemarkError =
            (apiError?.physicallyContactedAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.physicallyContactedAuditRemark?.first ?? "";
        physicallyVerifiedSuppliersError =
            (apiError?.physicallyVerifiedSuppliers ?? []).isEmpty
                ? ""
                : apiError?.physicallyVerifiedSuppliers?.first ?? "";
        physicallyVerifiedAuditRemarkError =
            (apiError?.physicallyVerifiedAuditRemark ?? []).isEmpty
                ? ""
                : apiError?.physicallyVerifiedAuditRemark?.first ?? "";
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

  List<String> recyclerHeadingList = [
    "Name of Plant Machinery",
    "Capacity of Plant Machinery",
    "Power of Plant Machinery",
    "Action",
    "Remarks",
  ];

  Future<APIResponse<AuditorRecyclerForm1ResponseModel?>?> getRecycler1Data(
      BuildContext context,
      {String userId = "",
      bool isRetreader = false}) async {
    state = ViewState.busy;
    gstNoAuditRemarkError = null;
    detailsOfMachineryRemarkError = null;
    companyPanAuditRemarkError = null;
    ctoAuditRemarkError = null;
    authorizationUnderHomwRulesAuditRemarkError = null;
    addressLine1AuditRemarkError = null;
    gpsLocationAuditorAdditionalDataLatError = null;
    gpsLocationAuditorAdditionalDataLongError = null;
    gpsLocationAuditorAuditRemarkError = null;
    lastYearElectricityBillAuditDocumentError = null;
    lastYearElectricityBillAuditRemarkError = null;
    geoTaggedVideoUploadAuditDocumentError = null;
    geoTaggedVideoUploadAuditRemarkError = null;

    try {
      _auditorRecycler1ResponseModel = await auditorRepository
          .getRecyclerForm1Data(AuditorPostModel(auditPlanId: userId),
              isRetreader: isRetreader);
      if (_auditorRecycler1ResponseModel?.isSuccess == true) {
        await getCurrentLocation();
        _auditorRecycler1ResponseModel?.data =
            AuditorRecyclerForm1ResponseModel.fromJson(
                _auditorRecycler1ResponseModel?.completeResponse);

        generalInfoResponseData =
            _auditorRecycler1ResponseModel?.data?.data?.generalInfo;
        machineList = _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.otherMachineries?.additionalData?.om ??
            [];

        count = machineList.isEmpty ? 1 : machineList.length;
        updatePlantMachine();
        disableFormView();
        summaryFormView();
        for (int i = 0; i < machineList.length; i++) {
          uploadControllerList[i].text = machineList[i].auditDocument ?? '';
          controllerList[i].text = machineList[i].value ?? '';
          otherMachineriesDocument.add(DocumentData(
              fileName: machineList[i].auditDocument,
              fileKey: machineList[i].fileKey,
              fileUrl: machineList[i].fileLink));
          machineFileSizeModel.add(FileSizeModel(fileSize: '', fileSizeNum: 0));
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
    if (machineList.isNotEmpty) {
      for (int i = 0; i < machineList.length; i++) {
        TextEditingController? tempController = TextEditingController();
        TextEditingController? tempUploadController = TextEditingController();

        controllerList.add(tempController);
        uploadControllerList.add(tempUploadController);
        updateUI();
      }
    } else {
      addController();
    }
  }

  Future<APIResponse<AuditorRecyclerForm2ResponseModel?>?> getRecycler2Data(
      BuildContext context,
      {String userId = "",
      bool isRetreader = false}) async {
    state = ViewState.busy;
    contactedSuppliersError = "";
    contactedAuditRemarkError = "";
    verifiedSuppliersError = "";
    verifiedAuditRemarkError = "";
    physicallyContactedSuppliersError = "";
    physicallyContactedAuditRemarkError = "";
    physicallyVerifiedSuppliersError = "";
    physicallyVerifiedAuditRemarkError = "";

    try {
      _auditorRecycler2ResponseModel = await auditorRepository
          .getRecyclerForm2Data(AuditorPostModel(auditPlanId: userId),
              isRetreader: isRetreader);
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
        totalQuantitySalesController?.text =
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
    capacityTypeofEndProductError = "";
    plantProductionCapacityError = "";
    endProductProducedAuditDayError = "";
    plantPerYearError = "";
    plantPerDayError = "";
    plantPerShiftError = "";
    actualProcessingCapacityError = "";
    powerOnAuditDayError = "";
    totalElectricityConsumptionError = "";

    try {
      _auditorRecycler3ResponseModel = await auditorRepository
          .getRecyclerForm3Data(AuditorPostModel(auditPlanId: userId),
              isRetreader: isRetreader);
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
    invoiceAuditConfirmedStatusError = null;
    invoiceAdditionalDataNumberOfSuppliersContactedError = null;
    invoiceAuditRemarkError = null;
    buyersAuditConfirmedStatusError = null;
    buyersAdditionalDataNumberOfBuyersContactedError = null;
    buyersAuditRemarkError = null;
    numberOfBuyerContactedError = null;

    try {
      _auditorRecycler4ResponseModel = await auditorRepository
          .getRecyclerForm4Data(AuditorPostModel(auditPlanId: userId),
              isRetreader: isRetreader);
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
    summaryAuditRemarkError = '';
    try {
      _auditorRecycler5ResponseModel = await auditorRepository
          .getRecyclerForm5Data(AuditorPostModel(auditPlanId: userId),
              isRetreader: isRetreader);
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

  String? emptyValidation(TextEditingController? controller) {
    if (controller?.text.isEmpty ?? false) {
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
      TextEditingController? tempController = TextEditingController();
      TextEditingController? tempUploadController = TextEditingController();
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
    if (((controllerList[count - 1].text.isNotEmpty) &&
        (uploadControllerList[count - 1].text.isNotEmpty))) {
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
    position = await determinePosition();
    currentLocation = position;
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

  void handleOnSuffixTap(BuildContext context, RecyclerForm1 fieldName,
      TextEditingController? controller,
      {bool isVideo = false, bool isPdf = false}) async {
    if (controller?.text.isEmpty ?? false) {
      var res = await openFileManager(context, fieldName,
          isVideo: isVideo, isPdf: isPdf);

      if (res != null) {
        controller?.text = res.files.isEmpty ? "" : res.files.first.name;
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
          await postDocumentData(context, requestModel, type: fieldName);
        }
      }
    } else {
      switch (fieldName) {
        case RecyclerForm1.aadhar:
          controller?.text = "";
          aadharFilePath = null;
          break;
        case RecyclerForm1.panNo:
          controller?.text = "";
          panNoFilePath = null;
          break;
        case RecyclerForm1.pollution:
          controller?.text = "";
          pollutionFilePath = null;
          break;
        case RecyclerForm1.power:
          controller?.text = "";
          powerFilePath = null;
          break;
        case RecyclerForm1.video:
          controller?.text = "";
          videoFilePath = null;
          break;
      }
    }

    updateUI();
  }

  void handleOnTap(BuildContext context, RecyclerForm1 fieldName,
      TextEditingController? controller,
      {bool isVideo = false, bool isPdf = false}) async {
    if (controller?.text.isEmpty ?? false) {
      var res = await openFileManager(context, fieldName,
          isVideo: isVideo, isPdf: isPdf);

      if (res != null) {
        controller?.text = res.files.isEmpty ? "" : res.files.first.name;
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
          if (_auditorRecycler1ResponseModel != null) {
            getAuditorFile(context, aadharDocument?.fileKey ?? '');
          } else {
            helperFunctions.openFile(aadharFilePath ?? '');
          }
          break;
        case RecyclerForm1.panNo:
          if (_auditorRecycler1ResponseModel != null) {
            getAuditorFile(context, authorizedPersonPanDocument?.fileKey ?? '');
          } else {
            helperFunctions.openFile(panNoFilePath ?? '');
          }
          break;
        case RecyclerForm1.pollution:
          if (_auditorRecycler1ResponseModel != null) {
            getAuditorFile(
                context, airPollutionControlDevicesDocument?.fileKey ?? '');
          } else {
            helperFunctions.openFile(pollutionFilePath ?? '');
          }
          break;
        case RecyclerForm1.power:
          if (_auditorRecycler1ResponseModel != null) {
            getAuditorFile(
                context, lastYearElectricityBillDocument?.fileKey ?? '');
          } else {
            helperFunctions.openFile(powerFilePath ?? '');
          }
          break;
        case RecyclerForm1.video:
          if (_auditorRecycler1ResponseModel != null) {
            getAuditorFile(
                context, geoTaggedVideoUploadDocument?.fileKey ?? '');
          } else {
            helperFunctions.openFile(videoFilePath ?? '');
          }
          break;
      }
    }
  }

  void handleOnMachineTap(BuildContext context,
      TextEditingController? controller, int index) async {
    if (controller?.text.isEmpty ?? false) {
      var res = await openMachineFileManager(context);

      if (res != null) {
        controller?.text = res.files.isEmpty ? "" : res.files.first.name;
        updateUI();
        helperFunctions.logger(uploadControllerList.length.toString());

        machineFile.add(await MultipartFile.fromFile(res.files.first.path ?? '',
            filename: res.files.first.name));
      }
    } else {
      if (_auditorRecycler1ResponseModel?.data?.data?.auditSummary
              ?.otherMachineries?.additionalData?.om !=
          null) {
        getAuditorFile(context, otherMachineriesDocument[index]?.fileKey ?? '');
      } else {
        helperFunctions.openFile(machineFilePath[index] ?? '');
      }
    }
  }

  void disableFormView() {
    gstController?.text = generalInfoResponseData?.gstNo ?? '';
    companyPanController?.text = generalInfoResponseData?.companyPan ?? '';
    companyIECController?.text = generalInfoResponseData?.companyIec ?? '';
    recyclerCTOController?.text = generalInfoResponseData?.cto ?? '';
    authorizationController?.text =
        generalInfoResponseData?.authorizationUnderHomwRules ?? '';
    recyclingDetailsController?.text =
        generalInfoResponseData?.addressLine1 ?? '';
    gpsRecyclerLatitude?.text = generalInfoResponseData?.lat ?? '';
    gpsRecyclerLongitude?.text = generalInfoResponseData?.long ?? '';
    aadharController?.text =
        generalInfoResponseData?.authorizedPersonAdhar ?? '';
    panNoController?.text = generalInfoResponseData?.authorizedPersonPan ?? "";
    pollutionController?.text =
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

      Map<String, dynamic>? otherMachineSummaryData =
          _auditorRecycler1ResponseModel?.data?.data?.auditSummary
              ?.detailsOfMachinery?.additionalData?.machinery;
      otherMachineSummaryData?.entries.forEach((element) {
        detailOfMachineryList?.add(MachineryResponse.fromJson(element.value));
        for (int i = 0; i < plantMachineryControllerList.length; i++) {
          plantMachineryControllerList[i].text =
              detailOfMachineryList?[i].auditRemark ?? '';
        }
        for (int i = 0; i < plantMachineyRadioList.length; i++) {
          plantMachineyRadioList[i] =
              detailOfMachineryList?[i].auditConfirmedStatus ?? '';
        }
        helperFunctions.logger(otherMachineSummaryData.toString());
        helperFunctions.logger(detailOfMachineryList.toString());
      });
    }
    updateUI();
    aadharDocument = DocumentData(
        fileKey: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.authorizedPersonAdhar?.additionalData?.fileKey ??
            '',
        fileName: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.authorizedPersonAdhar?.auditDocument ??
            '',
        fileUrl: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.authorizedPersonAdhar?.additionalData?.fileLink ??
            '');
    lastYearElectricityBillDocument = DocumentData(
        fileKey: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.lastYearElectricityBill?.additionalData?.fileKey ??
            '',
        fileName: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.lastYearElectricityBill?.auditDocument ??
            '',
        fileUrl: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.lastYearElectricityBill?.additionalData?.fileLink ??
            '');
    authorizedPersonPanDocument = DocumentData(
        fileKey: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.authorizedPersonPan?.additionalData?.fileKey ??
            '',
        fileName: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.authorizedPersonPan?.auditDocument ??
            '',
        fileUrl: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.authorizedPersonPan?.additionalData?.fileLink ??
            '');
    airPollutionControlDevicesDocument = DocumentData(
        fileKey: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.airPollutionControlDevices?.additionalData?.fileKey ??
            '',
        fileName: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.airPollutionControlDevices?.auditDocument ??
            '',
        fileUrl: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.airPollutionControlDevices?.additionalData?.fileLink ??
            '');
    geoTaggedVideoUploadDocument = DocumentData(
        fileKey: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.geoTaggedVideoUpload?.additionalData?.fileKey ??
            '',
        fileName: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.geoTaggedVideoUpload?.auditDocument ??
            '',
        fileUrl: _auditorRecycler1ResponseModel?.data?.data?.auditSummary
                ?.geoTaggedVideoUpload?.additionalData?.fileLink ??
            '');
    // gpsAuditorLatitude?.text = "${currentLocation?.longitude}";
    // gpsAuditorLongitude?.text = "${currentLocation?.latitude}";

    final data = _auditorRecycler1ResponseModel?.data?.data?.auditSummary;
    gstRemarkController?.text = data?.gstNo?.auditRemark ?? '';
    companyPanRemarkController?.text = data?.companyPan?.auditRemark ?? '';
    companyRemarkIECController?.text = data?.companyIec?.auditRemark ?? '';
    recyclerRemakrCTOController?.text = data?.cto?.auditRemark ?? '';
    remarkAuthorizationController?.text =
        data?.authorizationUnderHomwRules?.auditRemark ?? '';

    remarkRecyclingDetailsController?.text =
        data?.addressLine1?.auditRemark ?? '';
    gpsAuditorLatitude?.text =
        data?.gpsLocationAuditor?.additionalData?.lat != null
            ? data?.gpsLocationAuditor?.additionalData?.lat ?? ''
            : "${currentLocation?.latitude}";
    gpsAuditorLongitude?.text =
        data?.gpsLocationAuditor?.additionalData?.long != null
            ? data?.gpsLocationAuditor?.additionalData?.long ?? ''
            : "${currentLocation?.longitude}";
    gpsAuditorRemarkController?.text =
        data?.gpsLocationAuditor?.auditRemark ?? '';

    remarkAadharController?.text =
        data?.authorizedPersonAdhar?.auditRemark ?? '';
    uploadAadharController?.text =
        data?.authorizedPersonAdhar?.auditDocument ?? '';
    remarkPanNoController?.text = data?.authorizedPersonPan?.auditRemark ?? '';
    uploadPanNoController?.text =
        data?.authorizedPersonPan?.auditDocument ?? '';

    uploadPowerController?.text =
        data?.lastYearElectricityBill?.auditDocument ?? '';
    remarkPowerController?.text =
        data?.lastYearElectricityBill?.auditRemark ?? '';

    remakrsPollutionController?.text =
        data?.airPollutionControlDevices?.auditRemark ?? '';
    uploadPollutionController?.text =
        data?.airPollutionControlDevices?.auditDocument ?? '';

    remarkVideoController?.text = data?.geoTaggedVideoUpload?.auditRemark ?? '';
    uploadVideoController?.text =
        data?.geoTaggedVideoUpload?.auditDocument ?? '';

    radioGst = "${data?.gstNo?.auditConfirmedStatus ?? '1'}";

    radioPanOfCompany = "${data?.companyPan?.auditConfirmedStatus ?? '1'}";
    radioIec = "${data?.companyIec?.auditConfirmedStatus ?? '1'}";
    radioCto = "${data?.cto?.auditConfirmedStatus ?? '1'}";
    radioAuthorization =
        "${data?.authorizationUnderHomwRules?.auditConfirmedStatus ?? '1'}";
    radioRecyclingDetails =
        "${data?.addressLine1?.auditConfirmedStatus ?? '1'}";
    radioGps = "${data?.gpsLocationAuditor?.auditConfirmedStatus ?? '1'}";
    radioAadharCard =
        "${data?.authorizedPersonAdhar?.auditConfirmedStatus ?? '1'}";
    radioPanNo = "${data?.companyPan?.auditConfirmedStatus ?? '1'}";
    radioPowerConsumption =
        "${data?.lastYearElectricityBill?.auditConfirmedStatus ?? '1'}";
    radioPollution =
        "${data?.airPollutionControlDevices?.auditConfirmedStatus ?? '1'}";
    radioPlant = "${data?.geoTaggedVideoUpload?.auditConfirmedStatus ?? '1'}";
  }

  void summaryForm2View() {
    typeOfEndProduct.clear();
    if (endProductsData != null) {
      typeOfEndProduct.add(endProductsData?.scrumRubber ?? '');
      typeOfEndProduct.add(endProductsData?.crumRubber ?? '');
      typeOfEndProduct.add(endProductsData?.crmb ?? '');
      typeOfEndProduct.add(endProductsData?.recoveredCarbon ?? '');
      typeOfEndProduct.add(endProductsData?.pyrolisisOilBatch ?? '');
      typeOfEndProduct.add(endProductsData?.pyrolisisOilContinuous ?? '');
    }
    if (endProductsData != null) {
      endProductsList
          .add(CheckboxFilterModel(title: endProductsData?.scrumRubber ?? ''));
      endProductsList
          .add(CheckboxFilterModel(title: endProductsData?.crumRubber ?? ''));
      endProductsList
          .add(CheckboxFilterModel(title: endProductsData?.crmb ?? ''));
      endProductsList.add(
          CheckboxFilterModel(title: endProductsData?.recoveredCarbon ?? ''));
      endProductsList.add(
          CheckboxFilterModel(title: endProductsData?.pyrolisisOilBatch ?? ''));
      endProductsList.add(CheckboxFilterModel(
          title: endProductsData?.pyrolisisOilContinuous ?? ''));
    }

    // typeOfProductController?.text =
    //     planCapacityAssesment?.additionalData?.typeOfEndProduct?.first ?? '';
    selectedEndProductsData =
        planCapacityAssesment?.additionalData?.typeOfEndProduct ?? [];
    endProductDataListController?.text = selectedEndProductsData.join(",");

    // endProductDropdownValue =
    //     planCapacityAssesment?.additionalData?.typeOfEndProduct?.first;
    plantProductionCapacityController?.text =
        planCapacityAssesment?.additionalData?.plantProductionCapacity ?? '';

    endProductProducedController?.text =
        planCapacityAssesment?.additionalData?.endProductProducedOnAuditDay ??
            '';
//daysPlantOperational is plantOperationalPerYear
    daysPlantOperationalController?.text =
        planCapacityAssesment?.additionalData?.plantOperationalPerYear ?? '';
//hoursPlantOperational is plantOperationalPerShift
    hoursPlantOperationalController?.text =
        planCapacityAssesment?.additionalData?.plantOperationalPerShift ?? '';
//shiftPlantOperational is PlantOperationalPerDay
    shiftPlantOperationalController?.text =
        planCapacityAssesment?.additionalData?.plantOperationalPerDay ?? '';

    actualProcessingCapacityController?.text =
        "${planCapacityAssesment?.additionalData?.actualProcessingCapacityDerived ?? ''}";

    differenceInActualProccessingController?.text =
        "${valueComparable?.additionalData?.differenceInActualProcessing ?? ''}";
    uploadSalesController?.text =
        "${valueComparable?.additionalData?.differenceInActualProcessing ?? ''}";
    powerConsumptionController?.text =
        electricityVerification?.additionalData?.powerOnAuditDay ?? '';
    actualAverageAnnualController?.text =
        "${electricityVerification?.additionalData?.annualPowerConsumption ?? ''}";

    totalElectricityController?.text =
        electricityVerification?.additionalData?.totalElectricityConsumption ??
            '';
    areValuedCandDController?.text = cAndDComparable?.auditRemark ?? '';
    radioxy = "${valueComparable?.auditConfirmedStatus ?? '1'}";
    radiocd = "${cAndDComparable?.auditConfirmedStatus ?? '1'}";
  }

  void summaryForm3View() {
    procurementInfoContact?.text =
        procurementInfo?.contacted?.additionalData?.suppliers.toString() ?? '';
    procurementInfoContactRemarks?.text =
        procurementInfo?.contacted?.auditRemark ?? '';
    procurementInfoAuditVerified?.text = procurementInfo
            ?.verified?.additionalData?.suppliersNotVerified
            .toString() ??
        '';
    procurmentInfoVerifiedRemark?.text =
        procurementInfo?.verified?.auditRemark ?? '';
    physicallyContactedValue?.text = procurementInfo
            ?.physicallyContacted?.additionalData?.suppliers
            .toString() ??
        '';
    physicallyContactedRemark?.text =
        procurementInfo?.physicallyContacted?.auditRemark ?? '';
    physicallyVerifiedValue?.text = procurementInfo
            ?.physicallyVerified?.additionalData?.suppliersNotVerified
            .toString() ??
        '';
    physicallyVerifiedRemark?.text =
        procurementInfo?.physicallyVerified?.auditRemark ?? '';
    radioProcurementInfoContact =
        "${procurementInfo?.contacted?.auditConfirmedStatus ?? '1'}";
    radioProcurementInfoVerified =
        "${procurementInfo?.verified?.auditConfirmedStatus ?? '1'}";
    radioProcurementInfoPhysicallyContacted =
        "${procurementInfo?.physicallyContacted?.auditConfirmedStatus ?? '1'}";
    radioProcurementInfoPhysicallyVerified =
        "${procurementInfo?.physicallyVerified?.auditConfirmedStatus ?? '1'}";
  }

  void summaryForm4View() {
    invoiceController?.text =
        productionInfo?.invoice?.additionalData?.numberOfSuppliersContacted ??
            '';
    remakrsInvoiceController?.text = productionInfo?.invoice?.auditRemark ?? '';
    buyersController?.text =
        productionInfo?.invoice?.additionalData?.numberOfSuppliersContacted ??
            '';
    remakrsBuyerController?.text = productionInfo?.buyers?.auditRemark ?? '';
    radioBuyer = "${productionInfo?.buyers?.auditConfirmedStatus ?? '1'}";
    radioInvoice = "${productionInfo?.buyers?.auditConfirmedStatus ?? '1'}";
  }

  void summaryForm5View() {
    selectDropDownController?.text = wasteWaterGenerationAndDisposal
            ?.etpInstalled?.additionalData?.operational ??
        '';
    etpRemarksInstalledController?.text =
        wasteWaterGenerationAndDisposal?.etpInstalled?.auditRemark ?? '';
    radioInstalled =
        "${wasteWaterGenerationAndDisposal?.etpInstalled?.auditConfirmedStatus ?? '1'}";
    etpCapacityController?.text = wasteWaterGenerationAndDisposal
            ?.etpCapacity?.additionalData?.capacity
            .toString() ??
        '';
    radioCapacity =
        "${wasteWaterGenerationAndDisposal?.etpCapacity?.auditConfirmedStatus ?? '1'}";
    etpRemarksCapacityController?.text =
        wasteWaterGenerationAndDisposal?.etpCapacity?.auditRemark ?? '';
    summmaryRemakrController?.text =
        wasteWaterGenerationAndDisposal?.summary?.auditRemark ?? '';
  }

  Future<FilePickerResult?> openFileManager(
      BuildContext context, RecyclerForm1 fieldName,
      {bool isVideo = false, bool isPdf = false}) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: isVideo == true
            ? ["MP4"]
            : isPdf
                ? ["PDF"]
                : ["JPEG", "PNG"]);

    if (result != null) {
      switch (fieldName) {
        case RecyclerForm1.aadhar:
          final file = File(result.files.single.path ?? "");
          aadharFilePath = file.path;
          aadharFileSizeModel = await getFileSize(aadharFilePath ?? "", 1);
          fileSize = aadharFileSizeModel?.fileSize ?? "0 B";
          aadharFileName = file.path.split('/').last;
          aadharDocument?.fileName = aadharFileName;
          updateUI();
          break;
        case RecyclerForm1.panNo:
          final file = File(result.files.single.path ?? "");
          panNoFilePath = file.path;
          panNoFileSizeModel = await getFileSize(panNoFilePath ?? "", 1);
          fileSize = panNoFileSizeModel?.fileSize ?? "0 B";
          panNoFileName = file.path.split('/').last;
          authorizedPersonPanDocument?.fileName = panNoFileName;
          updateUI();
          break;
        case RecyclerForm1.pollution:
          final file = File(result.files.single.path ?? "");
          pollutionFilePath = file.path;
          pollutionFileSizeModel =
              await getFileSize(pollutionFilePath ?? "", 1);
          fileSize = pollutionFileSizeModel?.fileSize ?? "0 B";
          pollutionFileName = file.path.split('/').last;
          airPollutionControlDevicesDocument?.fileName = pollutionFileName;
          updateUI();
          break;
        case RecyclerForm1.power:
          final file = File(result.files.single.path ?? "");
          powerFilePath = file.path;
          powerFileSizeModel = await getFileSize(powerFilePath ?? "", 1);
          fileSize = powerFileSizeModel?.fileSize ?? "0 B";
          powerFileName = file.path.split('/').last;
          lastYearElectricityBillDocument?.fileName = powerFileName;
          updateUI();
          break;
        case RecyclerForm1.video:
          final file = File(result.files.single.path ?? '');
          videoFilePath = file.path;
          videoFileSizeModel = await getFileSize(videoFilePath ?? "", 1);
          fileSize = videoFileSizeModel?.fileSize ?? "0 B";
          videoFileName = file.path.split('/').last;
          geoTaggedVideoUploadDocument?.fileName = videoFileName;
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
    if (uploadVideoController?.text.isEmpty ?? false) {
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
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      String path = result.files.single.path!;
      File file = File(path);

      videoSize = await file.length();

      videoDuration = await _getVideoDuration(path);
    }
    updateUI();
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
    } else if (fileSizeModel?.fileSize.contains("MB") ?? false) {
      if (fileSizeModel!.fileSizeNum > 2.0) {
        return messageConstant.maxFileSize;
      }
    }
    return null;
  }

  void textForm2Listener() {
    plantProductionCapacityController?.addListener(() {
      actualProcessingValue();
    });
    endProductProducedController?.addListener(() {
      actualProcessingValue();
    });
    daysPlantOperationalController?.addListener(() {
      actualProcessingValue();
    });
    hoursPlantOperationalController?.addListener(() {
      actualProcessingValue();
    });
    shiftPlantOperationalController?.addListener(() {
      actualProcessingValue();
    });
    actualProcessingCapacityController?.addListener(() {
      differenceInActualProcessingValue();
    });
    powerConsumptionController?.addListener(() {
      actualAveragePowerValue();
    });
  }

  void actualAveragePowerValue() {
    int a = int.parse((powerConsumptionController?.text.isEmpty ?? false)
        ? "1"
        : powerConsumptionController?.text ?? "");
    int b = int.parse((endProductProducedController?.text.isEmpty ?? false)
        ? "1"
        : endProductProducedController?.text ?? "");
    int z = int.parse((totalQuantitySalesController?.text.isEmpty ?? false)
        ? "1"
        : totalQuantitySalesController?.text ?? "");

    if (powerConsumptionController?.text.isNotEmpty ??
        false ||
            (endProductProducedController?.text.isNotEmpty ?? false) ||
            (totalQuantitySalesController?.text.isNotEmpty ?? false)) {
      actualAverageAnnualController?.text = (a / b - z).toString();
    }
  }

  void differenceInActualProcessingValue() {
    int y = int.parse(actualProcessingCapacityController?.text.isEmpty ?? false
        ? "1"
        : actualProcessingCapacityController?.text ?? "");
    int z = int.parse(totalQuantitySalesController?.text.isEmpty ?? false
        ? "1"
        : totalQuantitySalesController?.text ?? "");

    if (actualProcessingCapacityController?.text.isNotEmpty ?? false) {
      uploadSalesController?.text = (1.05 * y - z).toString();
    }
  }

  void actualProcessingValue() {
    int endProduct = int.parse(
        endProductProducedController?.text.isEmpty ?? false
            ? "1"
            : endProductProducedController?.text ?? "");
    int daysPlant = int.parse(
        daysPlantOperationalController?.text.isEmpty ?? false
            ? "1"
            : daysPlantOperationalController?.text ?? "");
    int hoursPlant = int.parse(
        hoursPlantOperationalController?.text.isEmpty ?? false
            ? "1"
            : hoursPlantOperationalController?.text ?? "");
    int shiftPlant = int.parse(
        shiftPlantOperationalController?.text.isEmpty ?? false
            ? "1"
            : shiftPlantOperationalController?.text ?? "");

    if (plantProductionCapacityController?.text.isNotEmpty ??
        false ||
            (endProductProducedController?.text.isNotEmpty ?? false) ||
            (daysPlantOperationalController?.text.isNotEmpty ?? false) ||
            (hoursPlantOperationalController?.text.isNotEmpty ?? false) ||
            (shiftPlantOperationalController?.text.isNotEmpty ?? false)) {
      actualProcessingCapacityController?.text =
          (endProduct * daysPlant * hoursPlant * shiftPlant).toString();
    }
  }

  void textForm3Listener() {
    procurementInfoContact?.addListener(() {
      totalValueA();
    });
    procurementInfoAuditVerified?.addListener(() {
      totalValueA();
    });
    physicallyContactedValue?.addListener(() {
      totalValueB();
    });
    physicallyVerifiedValue?.addListener(() {
      totalValueB();
    });
  }

  void totalValueA() {
    int supplierContact = int.parse(
        procurementInfoContact?.text.isEmpty ?? false
            ? "0"
            : procurementInfoContact?.text ?? "");
    int verified = int.parse(procurementInfoAuditVerified?.text.isEmpty ?? false
        ? "0"
        : procurementInfoAuditVerified?.text ?? "");
    if (procurementInfoContact?.text.isNotEmpty ??
        false || (procurementInfoAuditVerified?.text.isNotEmpty ?? false)) {
      aNotVerifiedController?.text = (supplierContact - verified).toString();
    }
  }

  void totalValueB() {
    int supplierContact = int.parse(
        physicallyContactedValue?.text.isEmpty ?? false
            ? "0"
            : physicallyContactedValue?.text ?? "");
    int verified = int.parse(physicallyVerifiedValue?.text.isEmpty ?? false
        ? "0"
        : physicallyVerifiedValue?.text ?? "");
    if (physicallyContactedValue?.text.isNotEmpty ??
        false || (physicallyVerifiedValue?.text.isNotEmpty ?? false)) {
      bNotVerifiedController?.text = (supplierContact - verified).toString();
    }
  }

  String? summaryValidation() {
    if (summmaryRemakrController?.text.isEmpty ?? false) {
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
  final formKey2 = GlobalKey<FormState>();

  Future<void> postDocumentData(
      BuildContext context, DocumentRequestModel request,
      {RecyclerForm1? type}) async {
    otherMachineriesError = "";
    aadhaarcardError = "";
    authorizedPersonPanError = "";
    lastYearElectricityBillError = "";
    airPollutionControlDevicesError = "";
    geoTaggedVideoUploadError = "";

    state = ViewState.busy;
    APIResponse<DocumentResponseModel?>? response;
    try {
      response = await auditorRepository.postDocumentRequest(request);
      if (response?.isSuccess == true) {
        response?.data =
            DocumentResponseModel.fromJson(response.completeResponse);
        if (context.mounted) {
          state = ViewState.idle;
          if (type != null) {
            setUploadFileData(type, response);
          } else {
            setMachineUploadFileData(response);
          }
        }
      } else {
        final apiError = response?.error?.errorsList;

        otherMachineriesError = (apiError?.otherMachineries ?? []).isEmpty
            ? ""
            : apiError?.otherMachineries?.first ?? "";
        aadhaarcardError = (apiError?.aadhaarcard ?? []).isEmpty
            ? ""
            : apiError?.aadhaarcard?.first ?? "";

        authorizedPersonPanError = (apiError?.authorizedPersonPan ?? []).isEmpty
            ? ""
            : apiError?.authorizedPersonPan?.first ?? "";
        lastYearElectricityBillError =
            (apiError?.lastYearElectricityBill ?? []).isEmpty
                ? ""
                : apiError?.lastYearElectricityBill?.first ?? "";
        airPollutionControlDevicesError =
            (apiError?.airPollutionControlDevices ?? []).isEmpty
                ? ""
                : apiError?.airPollutionControlDevices?.first ?? "";
        geoTaggedVideoUploadError =
            (apiError?.geoTaggedVideoUpload ?? []).isEmpty
                ? ""
                : apiError?.geoTaggedVideoUpload?.first ?? "";
      }
    } catch (e) {
      helperFunctions.logger('$e');
    }
    state = ViewState.idle;
  }

  Future getAuditorFile(BuildContext context, String key) async {
    state = ViewState.busy;
    try {
      APIResponse value = await auditorRepository.getDownloadFile(key);

      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: "${DateTime.now().millisecond}", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? '');
        }
      }
    } catch (error) {
      helperFunctions.logger("$error");
    }
    state = ViewState.idle;
    return null;
  }

  Future getViewEntriesFile(BuildContext context, String url) async {
    state = ViewState.busy;
    updateUI();
    try {
      APIResponse value =
          await auditorRepository.getViewEntriesDownloadFile(url);

      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: "${DateTime.now().millisecond}", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? '');
        }
      }
    } catch (error) {
      helperFunctions.logger("$error");
    }
    state = ViewState.idle;
    return null;
  }

  void setUploadFileData(
      RecyclerForm1 type, APIResponse<DocumentResponseModel?>? response) {
    switch (type) {
      case RecyclerForm1.aadhar:
        aadharDocument = response?.data?.data;
        aadharFile = null;
        break;
      case RecyclerForm1.pollution:
        airPollutionControlDevicesDocument = response?.data?.data;
        pollutionFile = null;
        break;
      case RecyclerForm1.panNo:
        authorizedPersonPanDocument = response?.data?.data;
        panNoFile = null;
        break;
      case RecyclerForm1.video:
        geoTaggedVideoUploadDocument = response?.data?.data;
        videoFile = null;
        break;
      case RecyclerForm1.power:
        lastYearElectricityBillDocument = response?.data?.data;
        powerFile = null;
        break;
    }
    updateUI();
  }

  void setMachineUploadFileData(APIResponse<DocumentResponseModel?>? response) {
    otherMachineriesDocument.add(response?.data?.data);
    machineFile.clear();
    helperFunctions.logger(machineFile.length.toString());
    updateUI();
  }

  // void formValidation(BuildContext context, String id, bool isRetreader) {
  //   if (formKey.currentState?.validate() ?? false) {
  //     onNextButton(context, id, isRetreader);
  //   } else {}
  // }

  Future<void> handleOnMachineSuffixTap(BuildContext context,
      TextEditingController? controller, int index) async {
    if (controller?.text.isEmpty ?? false) {
      if (context.mounted) {
        var res = await openMachineFileManager(context);
        if (res != null) {
          controller?.text = res.files.isEmpty ? "" : res.files.first.name;
          updateUI();
          helperFunctions.logger(uploadControllerList.length.toString());

          machineFile.add(await MultipartFile.fromFile(
              res.files.first.path ?? '',
              filename: res.files.first.name));

          DocumentRequestModel requestModel =
              DocumentRequestModel(otherMachineries: machineFile.first);
          if (context.mounted) {
            await postDocumentData(context, requestModel);
          }
        }
      }
    } else {
      controller?.text = "";
      machineFilePath = [];
      if (otherMachineriesDocument.length == (index + 1)) {
        otherMachineriesDocument.removeAt(index);
      }
      machineFile.clear();
      otherMachineriesError = "";

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

  Map<String, Machinery>? getPlantMachinery() {
    Map<String, Machinery> machineryMap = {};
    if (plantMachineryControllerList.length == plantMachineyRadioList.length) {
      for (int i = 0; i < plantMachineryControllerList.length; i++) {
        machineryMap[(nw?[i].machineryId ?? '')] = Machinery(
          auditConfirmedStatus: plantMachineyRadioList[i],
          auditRemark: plantMachineryControllerList[i].text,
        );
      }
      return machineryMap;
    }
    updateUI();
    return null;
  }

  List<OmRequest> getOmRequest() {
    if (controllerList[0].text.isNotEmpty ||
        uploadControllerList[0].text.isNotEmpty) {
      for (int i = 0; i < controllerList.length; i++) {
        if (otherMachineriesDocument[i]?.fileKey?.isEmpty ?? false) {
          OmRequest omRequest = OmRequest(
            auditDocument: uploadControllerList[i].text,
            value: controllerList[i].text,
          );
          omRequestList.add(omRequest);
        } else {
          OmRequest omRequest = OmRequest(
              auditDocument: uploadControllerList[i].text,
              value: controllerList[i].text,
              fileKey: otherMachineriesDocument[i]?.fileKey,
              fileLink: otherMachineriesDocument[i]?.fileUrl);
          omRequestList.add(omRequest);
        }
      }
      return omRequestList;
    } else {
      return [];
    }
  }

  Future<void> formValidation(BuildContext context,
      {String userId = "",
      bool isRetreader = false,
      String submit = ""}) async {
    if (controllerList[0].text.isNotEmpty ||
        uploadControllerList[0].text.isNotEmpty) {
      if ((formKey.currentState?.validate() ?? false) &&
          (formKey2.currentState?.validate() ?? false)) {
        postForm1Data(context,
            isRetreader: isRetreader, submit: submit, userId: userId);
      }
    } else {
      if (formKey2.currentState?.validate() ?? false) {
        postForm1Data(context,
            isRetreader: isRetreader, submit: submit, userId: userId);
      }
    }
  }

//Submit is "SavedAsDraft" to post data as Save as Draft, anyother value means submit
  Future<void> postForm1Data(BuildContext context,
      {String userId = "",
      bool isRetreader = false,
      String submit = ""}) async {
    state = ViewState.busy;
    try {
      AuditorRecyclerForm1RequestModel requestModel =
          AuditorRecyclerForm1RequestModel(
              submit: submit,
              auditPlanId: userId,
              generalInfo: GenerralInfoRequest(
                  gstNo: AddressLine(
                      auditConfirmedStatus: radioGst,
                      auditRemark: gstRemarkController?.text),
                  companyPan: AddressLine(
                      auditConfirmedStatus: radioPanOfCompany,
                      auditRemark: companyPanRemarkController?.text),
                  companyIec: AddressLine(
                      auditConfirmedStatus: radioIec,
                      auditRemark: companyRemarkIECController?.text),
                  cto: AddressLine(
                      auditConfirmedStatus: radioCto,
                      auditRemark: recyclerRemakrCTOController?.text),
                  authorizationUnderHomwRules: AddressLine(
                      auditConfirmedStatus: radioAuthorization,
                      auditRemark: remarkAuthorizationController?.text),
                  addressLine1: AddressLine(
                      auditConfirmedStatus: radioRecyclingDetails,
                      auditRemark: remarkRecyclingDetailsController?.text),
                  gpsLocationRecycler:
                      GpsLocationRecycler(auditConfirmedStatus: radioGps),
                  gpsLocationAuditor: GpsLocationAuditorRequest(
                    auditConfirmedStatus: radioGps,
                    auditRemark: gpsAuditorRemarkController?.text,
                    additionalData: GpsLocationAuditorAdditionalDataRequest(
                        lat: gpsAuditorLatitude?.text,
                        long: gpsAuditorLongitude?.text),
                  ),
                  authorizedPersonAdhar: AirPollutionControlDevicesRequest(
                      auditRemark: remarkAadharController?.text,
                      auditConfirmedStatus: radioAadharCard,
                      auditDocument: aadharDocument?.fileName ?? '',
                      additionalData:
                          AirPollutionControlDevicesAdditionalDataRequest(
                              fileKey: aadharDocument?.fileKey ?? '',
                              fileLink: aadharDocument?.fileUrl ?? '')),
                  authorizedPersonPan: AirPollutionControlDevicesRequest(
                      auditRemark: remarkPanNoController?.text,
                      auditConfirmedStatus: radioPanNo,
                      auditDocument:
                          authorizedPersonPanDocument?.fileName ?? '',
                      additionalData: AirPollutionControlDevicesAdditionalDataRequest(
                          fileKey: authorizedPersonPanDocument?.fileKey ?? '',
                          fileLink:
                              authorizedPersonPanDocument?.fileUrl ?? '')),
                  otherMachineries: OtherMachineriesRequest(
                      additionalData: OtherMachineriesAdditionalDataRequest(
                          om: getOmRequest())),
                  detailsOfMachinery: DetailsOfMachinery(
                      additionalData: DetailsOfMachineryAdditionalData(
                          machinery: getPlantMachinery())),
                  lastYearElectricityBill: AirPollutionControlDevicesRequest(
                      auditRemark: remarkPowerController?.text,
                      auditConfirmedStatus: radioPowerConsumption,
                      auditDocument: lastYearElectricityBillDocument?.fileName,
                      additionalData: AirPollutionControlDevicesAdditionalDataRequest(
                          fileKey:
                              lastYearElectricityBillDocument?.fileKey ?? '',
                          fileLink:
                              lastYearElectricityBillDocument?.fileUrl ?? '')),
                  airPollutionControlDevices:
                      AirPollutionControlDevicesRequest(auditRemark: remakrsPollutionController?.text, auditConfirmedStatus: radioPollution, auditDocument: pollutionFileName ?? airPollutionControlDevicesDocument?.fileName ?? '', additionalData: AirPollutionControlDevicesAdditionalDataRequest(fileKey: airPollutionControlDevicesDocument?.fileKey ?? '', fileLink: airPollutionControlDevicesDocument?.fileUrl ?? '')),
                  geoTaggedVideoUpload: AirPollutionControlDevicesRequest(auditRemark: remarkVideoController?.text, auditConfirmedStatus: radioPlant, auditDocument: geoTaggedVideoUploadDocument?.fileName ?? '', additionalData: AirPollutionControlDevicesAdditionalDataRequest(fileKey: geoTaggedVideoUploadDocument?.fileKey ?? '', fileLink: geoTaggedVideoUploadDocument?.fileUrl ?? ''))));

      final res = await auditorRepository.postRecyclerForm1Data(requestModel,
          isRetreader: isRetreader);
      if (res?.isSuccess == true) {
        if (submit != storeKeyConstants.saveAsDraft) {
          machineFile.clear();
          machineFileName.clear();
          machineFilePath.clear();
          machineFileSize.clear();
          machineFileSizeModel.clear();
          otherMachineriesDocument.clear();
          machineList.clear();
          omRequestList.clear();
          nw?.clear();
          plantMachineyRadioList.clear();
          plantMachineryControllerList.clear();
          uploadControllerList.clear();
          controllerList.clear();
          omRequestList.clear();
        } else {
          omRequestList.clear();
        }
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
        }

        if (submit == "") {
          if (context.mounted) {
            onNextButton(context, userId, isRetreader);
          }
        }
      } else {
        final apiError = res?.error?.errorsList;
        detailsOfMachineryRemarkError =
            (apiError?.detailsOfMachineryRemark ?? []).isEmpty
                ? ""
                : apiError?.detailsOfMachineryRemark?.first ?? '';

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
            .commonErrorSnackBar(context, messageConstant.somethingWentWrong);
      }
    }
    state = ViewState.idle;

    updateUI();
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
                  auditRemark: remakrsInvoiceController?.text,
                  additionalData: InvoiceAdditionalRequestData(
                      numberOfSuppliersContacted: invoiceController?.text)),
              buyers: BuyersRequest(
                  auditConfirmedStatus: radioBuyer,
                  auditRemark: remakrsBuyerController?.text,
                  additionalData: BuyersAdditionalRequestData(
                      numberOfBuyersContacted: buyersController?.text)),
            ),
            auditPlanId: userId,
            submit: submit);
    state = ViewState.busy;
    try {
      final res = await auditorRepository.postRecyclerForm4Data(requestModel,
          isRetreader: isRetreader);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
          if (submit == "") {
            if (context.mounted) {
              onNextButton(context, userId, isRetreader);
            }
          }
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
        numberOfBuyerContactedError =
            (apiError?.productionInfoBuyersAdditionalDataNumberOfBuyersContacted ??
                        [])
                    .isEmpty
                ? ""
                : apiError
                        ?.productionInfoBuyersAdditionalDataNumberOfBuyersContacted
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

  Future<void> postForm5Data(BuildContext context,
      {String userId = "",
      bool isRetreader = false,
      String submit = "SaveAsDraft"}) async {
    AuditorRecyclerForm5RequestModel requestModel =
        AuditorRecyclerForm5RequestModel(
            submit: submit,
            auditPlanId: userId,
            wasteWaterGenerationAndDisposal:
                InvoiceAdditionalRequestDataRequest(
                    etpInstalled: EtpInstalledRequest(
                        auditConfirmedStatus: radioInstalled,
                        auditRemark: etpRemarksInstalledController?.text,
                        additionalData: EtpInstalledAdditionalDataRequest(
                            operational: installDropdownValue)),
                    etpCapacity: EtpCapacityRequest(
                        auditConfirmedStatus: radioCapacity,
                        auditRemark: etpRemarksCapacityController?.text,
                        additionalData: EtpCapacityAdditionalDataRequest(
                            capacity: etpCapacityController?.text)),
                    summary: SummaryRequest(
                        auditRemark: summmaryRemakrController?.text)));
    state = ViewState.busy;
    try {
      final res = await auditorRepository.postRecyclerForm5Data(requestModel,
          isRetreader: isRetreader);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
          if (submit == "") {
            if (context.mounted) {
              MaterialAppViewModel.selectedPageIndex = 1;
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.auditorHomeScreen,
                  ModalRoute.withName(AppRoutes.auditorHomeScreen));
            }
          }
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

class AddMachineModel {
  FileSizeModel? machineFileSizeModel;
  String? machineFileName;
  Om? machineList;
  String? machineFileSize;
  String? machineFilePath;
  MultipartFile? machineFile;
  DocumentData? otherMachineriesDocument;
  OmRequest? omRequestList;
  FileSizeModel? fileSizeModelList;
  TextEditingController uploadControllerList;
  TextEditingController controllerList;
  AddMachineModel({
    required this.controllerList,
    required this.uploadControllerList,
    this.fileSizeModelList,
    this.omRequestList,
    this.otherMachineriesDocument,
    this.machineFile,
    this.machineFilePath,
    this.machineFileSize,
    this.machineList,
    this.machineFileName,
    this.machineFileSizeModel,
  });
}
