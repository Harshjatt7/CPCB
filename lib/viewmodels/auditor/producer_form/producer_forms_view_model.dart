import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/request/auditor/producer/produer_form_1_request_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/enums/state_enums.dart';
import '../../../constants/routes_constant.dart';
import '../../../controllers/auditor/auditor_repository.dart';
import '../../../models/request/auditor/producer/producer_form_2_request_model.dart';
import '../../../models/request/auditor/producer/producer_form_3_request_model.dart';
import '../../../models/response/auditor/producer/producer_form_1_response_model.dart';
import '../../../models/response/auditor/producer/producer_form_2_response_model.dart';
import '../../../models/response/auditor/producer/producer_form_3_response_model.dart';
import '../../../models/response/base_response_model.dart';
import '../../../models/response/common/file_size_model.dart';
import '../../../theme/app_color.dart';

class ProducerFormsViewModel extends BaseViewModel {
  final stringConstants = StringConstants();
  final messageConstant = MessageConstant();
  final helperFunctions = HelperFunctions();
  final appColor = AppColor();

  //Form 1
  TextEditingController? disabledCompanyNameRemark;
  TextEditingController? disabledCategoryOfProducer;
  TextEditingController? disabledGst;
  TextEditingController? disabledPan;
  TextEditingController? disabledCin;
  TextEditingController? disabledIec;

  TextEditingController? companyNameRemark;
  TextEditingController? categoryOfProducerRemark;
  TextEditingController? gstRemark;
  TextEditingController? panOfCompanyRemark;
  TextEditingController? cinRemark;
  TextEditingController? iecRemark;

  TextEditingController? iecController;
  TextEditingController? cinController;
  TextEditingController? panController;
  TextEditingController? gstController;

  String? radioCompanyDetail;
  String? radioCategoryOfProducer;
  String? radioGst;
  String? radioPanOfCompany;
  String? radioCin;
  String? radioIec;

  MultipartFile? iecFile;
  MultipartFile? cinFile;
  MultipartFile? panFile;
  MultipartFile? gstFile;

  String? gstFilePath;
  String? panFilePath;
  String? cinFilePath;
  String? iecFilePath;

  FileSizeModel? gstFileSizeModel;
  FileSizeModel? panFileSizeModel;
  FileSizeModel? cinFileSizeModel;
  FileSizeModel? iecFileSizeModel;

  String? fileSize;
  double? fileSizeNum;

  String companyNameRemarkError = "";
  String categoryOfProducerRemarkError = "";
  String gstRemarkError = "";
  String panOfCompanyRemarkError = "";
  String iecRemarkError = "";

  TextEditingController? gstFileName;
  TextEditingController? panFileName;
  TextEditingController? cinFileName;
  TextEditingController? iecFileName;

  final _auditorRepository = AuditorRepository();
  ProducerForm1RequestModel? data;

  APIResponse<ProducerForm1ResponseModel?>? _producerForm1ResponseModel;
  APIResponse<ProducerForm1ResponseModel?>? get producerForm1ResponseModel =>
      _producerForm1ResponseModel;

  CompanyDetailsResponse? producerForm1Data;

  //Form 2
  String? radioMisreportingP1;
  String? radioMisreportingP2;
  String? radioMisreportingP3;
  String? radioMisreportingP4;
  String? radioMisreportingP5;
  String? radioMisreportingP6;

  List<String> producerHeadingList = [
    "Type of Tyre",
    "Financial Year",
    "Motorcycle",
    "Passenger Car",
    "Scooter",
    "Truck",
    "Bus",
    "LCV",
    "T Rear",
    "Other",
    "Total"
  ];

  APIResponse<ProducerForm2ResponseModel?>? _producerForm2ResponseModel;
  APIResponse<ProducerForm2ResponseModel?>? get producerForm2ResponseModel =>
      _producerForm2ResponseModel;
  AuditSummaryForm2Response? producerForm2DataAuditData;
  ProducerForm2SalesData? producerForm2Data;

  // Form 3
  String? radioMisreporting;
  String? radioInformation;
  TextEditingController? deviationController;
  TextEditingController? remarkController;
  TextEditingController? summaryController;
  APIResponse<ProducerForm3ResponseModel?>? _producerForm3ResponseModel;
  APIResponse<ProducerForm3ResponseModel?>? get producerForm3ResponseModel =>
      _producerForm3ResponseModel;
  ProducerForm3AuditSummary? producerForm3Data;
  String? auditRemarkError;
  String? summaryError;

  int page = 1;

  int counter = 0;
  void initializeForm1TextEditingControllers() {
    disabledCompanyNameRemark = TextEditingController();
    disabledCategoryOfProducer = TextEditingController();
    disabledGst = TextEditingController();
    disabledPan = TextEditingController();
    disabledCin = TextEditingController();
    disabledIec = TextEditingController();
    companyNameRemark = TextEditingController();
    categoryOfProducerRemark = TextEditingController();
    gstRemark = TextEditingController();
    panOfCompanyRemark = TextEditingController();
    cinRemark = TextEditingController();
    iecRemark = TextEditingController();
    iecController = TextEditingController();
    cinController = TextEditingController();
    panController = TextEditingController();
    gstController = TextEditingController();
    gstFileName = TextEditingController();
    panFileName = TextEditingController();
    cinFileName = TextEditingController();
    iecFileName = TextEditingController();
  }

  void initializeForm2TextEditingControllers() {
    deviationController = TextEditingController();
    remarkController = TextEditingController();
    summaryController = TextEditingController();
  }

  void setCounter() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      counter = 0;
      updateUI();
    });
  }

  String getTitle(int counter) {
    String title = '(${String.fromCharCode(65 + counter)}). ';
    return title;
  }

  int index = 1;

  void onNextButton(BuildContext context, String id) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (index < 3) {
        index++;
        switch (index) {
          case 1:
            await getProducerForm1Data(context, id: id);
            break;
          case 2:
            await getProducerForm2Data(context, id: id);
            break;
          case 3:
            await getProducerForm3Data(context, id: id);
            break;
        }
        updateUI();
      }
    });
  }

  Future<void> onBackButton(BuildContext context, String id) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (index > 1) {
        index--;
        switch (index) {
          case 1:
            await getProducerForm1Data(context, id: id);
            break;
          case 2:
            await getProducerForm2Data(context, id: id);
            break;
          case 3:
            await getProducerForm3Data(context, id: id);
            break;
        }
        if (context.mounted) {
          updateUI();
        }
      } else {
        Navigator.pop(context);
      }
    });
  }

  void getIndex(num? progress) {
    switch (progress) {
      case 0:
        index = 1;
        break;
      case 33:
        index = 2;
        break;
      case 66:
        index = 3;
        break;
      default:
        index = 1;
    }
    updateUI();
  }

  void initalizeGroupValues() {
    radioCompanyDetail = "1";
    radioCategoryOfProducer = "1";
    radioGst = "1";
    radioPanOfCompany = "1";
    radioCin = "1";
    radioIec = "1";
    radioMisreportingP1 = "1";
    radioMisreportingP3 = "1";
    radioMisreportingP2 = "1";
    radioMisreportingP4 = "1";
    radioMisreportingP5 = "1";
    radioMisreportingP6 = "1";
    radioMisreporting = "1";
    radioInformation = "1";
  }

  Future<void> postForm3Data(BuildContext context,
      {String? id, String? saveAsDraft}) async {
    ProducerForm3RequestModel requestModel = ProducerForm3RequestModel(
      summaryReport: SummaryReport(
        missReporting: MissReportingResponse(
          auditConfirmedStatus: radioMisreporting,
          additionalData: MissReportingAdditionalDataResponse(
              deviationValue: deviationController?.text),
        ),
        falseInformation: FalseInformationResponse(
            auditConfirmedStatus: radioInformation,
            auditRemark: remarkController?.text,
            additionalData: FalseInformationAdditionalDataResponse(
                overallSummary: summaryController?.text)),
      ),
      submit: saveAsDraft ?? "",
    );
    state = ViewState.busy;
    try {
      final res =
          await _auditorRepository.postProducerForm3Data(requestModel, id: id);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
          if (saveAsDraft == null) {
            MaterialAppViewModel.selectedPageIndex = 1;
            Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.auditorHomeScreen,
                ModalRoute.withName(AppRoutes.auditorHomeScreen));
          }
        }
      } else {
        final apiError = res?.error?.errorsList;
        auditRemarkError = (apiError?.auditRemark ?? []).isEmpty
            ? ""
            : apiError?.auditRemark?.first ?? "";
        summaryError = (apiError?.summary ?? []).isEmpty
            ? ""
            : apiError?.summary?.first ?? "";
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, stringConstants.somethingWentWrong);
      }
    }
    // updateUI();
    state = ViewState.idle;
  }

  Future<APIResponse<ProducerForm3ResponseModel?>?> getProducerForm3Data(
      BuildContext context,
      {String? id}) async {
    state = ViewState.busy;
    auditRemarkError = "";
    summaryError = "";
    try {
      _producerForm3ResponseModel =
          await _auditorRepository.getProducerForm3Data(id: id);
      if (_producerForm3ResponseModel?.isSuccess == true) {
        _producerForm3ResponseModel?.data = ProducerForm3ResponseModel.fromJson(
            _producerForm3ResponseModel?.completeResponse);

        producerForm3Data =
            _producerForm3ResponseModel?.data?.data?.auditSummary;
        deviationController?.text =
            producerForm3Data?.missReporting?.additionalData?.deviationValue ??
                "";
        // contoller .text =
        //     producerForm3Data?.missReporting?.additionalData?.deviationValue ??
        //         "";
        remarkController?.text =
            producerForm3Data?.falseInformation?.auditRemark ?? "";
        summaryController?.text = producerForm3Data
                ?.falseInformation?.additionalData?.overallSummary ??
            "";
        radioMisreporting =
            producerForm3Data?.missReporting?.auditConfirmedStatus.toString() ??
                "0";
        radioInformation = producerForm3Data
                ?.falseInformation?.auditConfirmedStatus
                .toString() ??
            "0";
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    if (context.mounted) {
      updateUI();
    }
    state = ViewState.idle;
    return _producerForm3ResponseModel;
  }

  Future<void> postForm2Data(BuildContext context,
      {String? id, String? saveAsDraft}) async {
    ProducerForm2RequestModel requestModel = ProducerForm2RequestModel(
      producerSalesData: ProducerRequestSalesData(
        salesP1: ProducerSalesDetail(auditConfirmedStatus: radioMisreportingP1),
        salesP2: ProducerSalesDetail(auditConfirmedStatus: radioMisreportingP2),
        salesP3: ProducerSalesDetail(auditConfirmedStatus: radioMisreportingP3),
        salesP4: ProducerSalesDetail(auditConfirmedStatus: radioMisreportingP4),
        salesP5: ProducerSalesDetail(auditConfirmedStatus: radioMisreportingP5),
        salesP6: ProducerSalesDetail(auditConfirmedStatus: radioMisreportingP6),
      ),
      submit: saveAsDraft ?? "",
    );
    state = ViewState.busy;
    try {
      final res =
          await _auditorRepository.postProducerForm2Data(requestModel, id: id);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
          if (saveAsDraft == null) {
            if (context.mounted) {
              onNextButton(context, id ?? "");
            }
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, stringConstants.somethingWentWrong);
      }
    }

    state = ViewState.idle;
    updateUI();
  }

  Future<APIResponse<ProducerForm2ResponseModel?>?> getProducerForm2Data(
      BuildContext context,
      {String? id}) async {
    state = ViewState.busy;
    try {
      _producerForm2ResponseModel =
          await _auditorRepository.getProducerForm2Data(id: id);
      if (_producerForm2ResponseModel?.isSuccess == true) {
        _producerForm2ResponseModel?.data = ProducerForm2ResponseModel.fromJson(
            _producerForm2ResponseModel?.completeResponse);

        producerForm2Data = _producerForm2ResponseModel?.data?.data?.salesData;
        producerForm2DataAuditData =
            _producerForm2ResponseModel?.data?.data?.auditSummary;
        radioMisreportingP1 = producerForm2DataAuditData
            ?.salesP1?.auditConfirmedStatus
            .toString();
        radioMisreportingP2 = producerForm2DataAuditData
            ?.salesP2?.auditConfirmedStatus
            .toString();
        radioMisreportingP3 = producerForm2DataAuditData
            ?.salesP3?.auditConfirmedStatus
            .toString();
        radioMisreportingP4 = producerForm2DataAuditData
            ?.salesP4?.auditConfirmedStatus
            .toString();
        radioMisreportingP5 = producerForm2DataAuditData
            ?.salesP5?.auditConfirmedStatus
            .toString();
        radioMisreportingP6 = producerForm2DataAuditData
            ?.salesP6?.auditConfirmedStatus
            .toString();
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }

    state = ViewState.idle;
    if (context.mounted) {
      updateUI();
    }
    return _producerForm2ResponseModel;
  }

  Future<APIResponse<ProducerForm1ResponseModel?>?> getProducerForm1Data(
      BuildContext context,
      {String? id}) async {
    state = ViewState.busy;
    companyNameRemarkError = "";
    companyNameRemarkError = "";
    categoryOfProducerRemarkError = "";
    gstRemarkError = "";
    panOfCompanyRemarkError = "";
    iecRemarkError = "";
    try {
      _producerForm1ResponseModel =
          await _auditorRepository.getProducerForm1Data(id: id);
      if (_producerForm1ResponseModel?.isSuccess == true) {
        _producerForm1ResponseModel?.data = ProducerForm1ResponseModel.fromJson(
            _producerForm1ResponseModel?.completeResponse);

        producerForm1Data =
            _producerForm1ResponseModel?.data?.data?.companyDetails;

        disabledCompanyNameRemark?.text =
            producerForm1Data?.companyNameAndAddress ?? "";
        disabledCategoryOfProducer?.text =
            producerForm1Data?.categoryOfProducer ?? "";
        disabledGst?.text = producerForm1Data?.gstNo ?? "";
        disabledPan?.text = producerForm1Data?.panOfCompany ?? "";
        disabledCin?.text = producerForm1Data?.cinNo ?? "";
        disabledIec?.text = producerForm1Data?.iec ?? "";

        final data = _producerForm1ResponseModel?.data?.data?.auditSummary;
        companyNameRemark?.text = data?.companyNameAddress?.auditRemark ?? "";
        categoryOfProducerRemark?.text =
            data?.producerCategory?.auditRemark ?? "";
        gstRemark?.text = data?.companyGst?.auditRemark ?? "";
        panOfCompanyRemark?.text = data?.companyPan?.auditRemark ?? "";
        cinRemark?.text = data?.companyCin?.auditRemark ?? "";
        iecRemark?.text = data?.companyIec?.auditRemark ?? "";

        radioCompanyDetail =
            data?.companyNameAddress?.auditConfirmedStatus.toString() ?? "1";
        radioCategoryOfProducer =
            data?.producerCategory?.auditConfirmedStatus.toString() ?? "1";
        radioGst = data?.companyGst?.auditConfirmedStatus.toString() ?? "1";
        radioPanOfCompany =
            data?.companyPan?.auditConfirmedStatus.toString() ?? "1";
        radioCin = data?.companyCin?.auditConfirmedStatus.toString() ?? "1";
        radioIec = data?.companyIec?.auditConfirmedStatus.toString() ?? "1";

        gstFileName?.text = producerForm1Data?.gstFileName ?? "";
        panFileName?.text = producerForm1Data?.panFileName ?? "";
        cinFileName?.text = producerForm1Data?.cinFileName ?? "";
        iecFileName?.text = producerForm1Data?.iecFileName ?? "";

        gstFilePath = producerForm1Data?.gstFilePath;
        panFilePath = producerForm1Data?.panFilePath;
        cinFilePath = producerForm1Data?.cinFilePath;
        iecFilePath = producerForm1Data?.iecFilePath;
      } else {
        helperFunctions.logger("No response");
      }
    } catch (err) {
      helperFunctions.logger("$err");
    }
    if (context.mounted) {
      updateUI();
    }
    state = ViewState.idle;
    return _producerForm1ResponseModel;
  }

  Future<void> postForm1Data(BuildContext context,
      {String? id, String? saveAsDraft}) async {
    state = ViewState.busy;
    ProducerForm1RequestModel requestModel = ProducerForm1RequestModel(
      companyDetails: CompanyDetails(
        companyNameAddress: CompanyData(
            auditConfirmedStatus: radioCompanyDetail,
            auditRemark: companyNameRemark?.text),
        producerCategory: CompanyData(
            auditConfirmedStatus: radioCategoryOfProducer,
            auditRemark: categoryOfProducerRemark?.text),
        companyGst: CompanyData(
            auditConfirmedStatus: radioGst, auditRemark: gstRemark?.text),
        companyPan: CompanyData(
            auditConfirmedStatus: radioPanOfCompany,
            auditRemark: panOfCompanyRemark?.text),
        companyCin: CompanyData(
            auditConfirmedStatus: radioCin, auditRemark: cinRemark?.text),
        companyIec: CompanyData(
            auditConfirmedStatus: radioIec, auditRemark: iecRemark?.text),
      ),
      submit: saveAsDraft ?? "",
    );

    try {
      final res =
          await _auditorRepository.postProducerForm1Data(requestModel, id: id);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions().commonSuccessSnackBar(
              context, res?.data?.message ?? "Data Successfuly Added");
          if (saveAsDraft == null) {
            if (context.mounted) {
              onNextButton(context, id ?? "");
            }
          }
        }
      } else {
        final apiError = res?.error?.errorsList;

        companyNameRemarkError =
            (apiError?.companyNameAndAddressRemark ?? []).isEmpty
                ? ""
                : apiError?.companyNameAndAddressRemark?.first ?? "";
        categoryOfProducerRemarkError =
            (apiError?.producerCategoryRemark ?? []).isEmpty
                ? ""
                : apiError?.producerCategoryRemark?.first ?? "";
        gstRemarkError = (apiError?.gstRemark ?? []).isEmpty
            ? ""
            : apiError?.gstRemark?.first ?? "";
        panOfCompanyRemarkError = (apiError?.panRemark ?? []).isEmpty
            ? ""
            : apiError?.panRemark?.first ?? "";
        iecRemarkError = (apiError?.iecRemark ?? []).isEmpty
            ? ""
            : apiError?.iecRemark?.first ?? "";
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

  String? validate(String controller) {
    if (controller.isEmpty) {
      return "Please enter a value";
    } else {
      return null;
    }
  }

  void handleOnTap(
    BuildContext context,
    String fileName,
    String? filePathUrl,
  ) async {
    if (filePathUrl != null) {
      APIResponse res = await _auditorRepository.getFilePath(filePathUrl);
      if (res.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions()
              .commonSuccessSnackBar(context, "Successfully downloaded");
        }
        await HelperFunctions()
            .downloadAndStoreFile(name: fileName, response: res);
      }
    } else {
      HelperFunctions().logger("File URL is null");
    }
  }

  Future getViewEntriesFile(BuildContext context, String url) async {
    state = ViewState.busy;
    try {
      APIResponse value =
          await _auditorRepository.getViewEntriesDownloadFile(url);

      if (value.isSuccess == true) {
        helperFunctions.downloadAndStoreFile(
            name: "${DateTime.now().millisecond}", response: value);
        state = ViewState.idle;
        return value;
      } else {
        state = ViewState.idle;
        if (context.mounted) {
          helperFunctions.commonErrorSnackBar(
              context, value.error?.message ?? "Data Successfuly Added");
        }
      }
    } catch (error) {
      helperFunctions.logger("$error");
    }
    state = ViewState.idle;
    return null;
  }
}
