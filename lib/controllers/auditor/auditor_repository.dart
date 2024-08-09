//auditor's repo
import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/auditor/auditor_post_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/producer/producer_form_3_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form1_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form4_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form5_request_model.dart';
import 'package:cpcb_tyre/models/response/auditor/auditor_dashboard_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/producer/producer_form_1_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/producer/producer_form_2_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/request/auditor/producer/produer_form_1_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/document_request_model.dart';
import 'package:cpcb_tyre/models/response/auditor/document_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form1_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form2_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form3_reponse_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form4_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form5_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:dio/dio.dart';

import '../../models/request/auditor/producer/producer_form_2_request_model.dart';
import '../../models/request/auditor/recycler/recycler_form_2_request_model.dart';
import '../../models/request/auditor/recycler/recycler_form_3_request_model.dart';
import '../../models/response/auditor/audit_list_response_model.dart';
import '../../models/response/auditor/audit_plan_detail_response_model.dart';
import '../../models/response/auditor/producer/producer_form_3_response_model.dart';
import '../../models/response/common/add_data_response_model.dart';

class AuditorRepository {
  final _apiRoutes = APIRoutes();
  final _apiBase = APIBase();

  Future getAuditStatus(AuditorPostModel requestModel, {String? status}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel>? response = await _apiBase.postRequest(
        status == "assigned"
            ? _apiRoutes.auditorPerformAcknowledge
            : _apiRoutes.auditorStartAcknowlege,
        data: request,
        isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postProducerForm3Data(
    ProducerForm3RequestModel requestModel,
  ) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.auditorProducerForm3RequestAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future getProducerForm3Data(AuditorPostModel requestModel) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<ProducerForm3ResponseModel?>? response = await _apiBase
        .postRequest(_apiRoutes.auditorProducerForm3ResponseAPIRoute,
            data: request, isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postProducerForm2Data(
    ProducerForm2RequestModel requestModel,
  ) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.auditorProducerForm2RequestAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future getProducerForm2Data(AuditorPostModel requestModel) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<ProducerForm2ResponseModel?>? response = await _apiBase
        .postRequest(_apiRoutes.auditorProducerForm2ResponseAPIRoute,
            data: request, isAuthorizationRequired: true);
    return response;
  }

  Future getFilePath(String? filePathUrl) async {
    APIResponse<AddDataResponseModel?>? response = await _apiBase.getRequest(
        filePathUrl ?? "",
        isAuthorizationRequired: true,
        isMediaAuthorizationRequired: true);
    return response;
  }

  Future getDasboardData() async {
    APIResponse<AuditorDashBoardResponseModel?>? response =
        await _apiBase.getRequest(_apiRoutes.auditorDashboardAPIRoute,
            isAuthorizationRequired: true);
    return response;
  }

  Future getAuditPlanListData({
    String? search,
    String? page,
    AuditPlanListResponseModel? request,
    List<String>? statusList,
    List<String>? unitTypeList,
  }) async {
    String url = "${_apiRoutes.auditorAuditPlanListAPIRoute}?page=$page";

    if (search != null) {
      url += "&name=$search";
    }

    if (statusList != null && statusList.isNotEmpty) {
      for (String status in statusList) {
        url += "&status[]=$status";
      }
    }

    if (unitTypeList != null && unitTypeList.isNotEmpty) {
      for (String unitType in unitTypeList) {
        url += "&unit_type[]=$unitType";
      }
    }
    APIResponse<AuditPlanListResponseModel?>? response =
        await _apiBase.getRequest(
      url,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future getAuditPlanDetail(AuditorPostModel requestModel) async {
    Map<String, dynamic> request = requestModel.toJson();

    APIResponse<AuditPlanDetailResponseModel?>? response =
        await _apiBase.postRequest(_apiRoutes.auditorAuditPlanDetailAPIRoute,
            data: request, isAuthorizationRequired: true);
    return response;
  }

  Future getProducerForm1Data(AuditorPostModel requestModel) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<ProducerForm1ResponseModel?>? response = await _apiBase
        .postRequest(_apiRoutes.auditorProducerForm1ResponseAPIRoute,
            data: request, isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postProducerForm1Data(
    ProducerForm1RequestModel requestModel,
  ) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.auditorProducerForm1RequestAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm1ResponseModel?>?> getRecyclerForm1Data(
      AuditorPostModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AuditorRecyclerForm1ResponseModel?>? response =
        await _apiBase.postRequest(
            isRetreader == true
                ? _apiRoutes.auditorRetreaderForm1APIRoute
                : _apiRoutes.auditorRecyclerForm1APIRoute,
            data: request,
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm2ResponseModel?>?> getRecyclerForm2Data(
      AuditorPostModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AuditorRecyclerForm2ResponseModel?>? response =
        await _apiBase.postRequest(
            isRetreader == true
                ? _apiRoutes.auditorRetreaderForm2APIRoute
                : _apiRoutes.auditorRecyclerForm2APIRoute,
            data: request,
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm3ResponseModel?>?> getRecyclerForm3Data(
      AuditorPostModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AuditorRecyclerForm3ResponseModel?>? response =
        await _apiBase.postRequest(
            isRetreader == true
                ? _apiRoutes.auditorRetreaderForm3APIRoute
                : _apiRoutes.auditorRecyclerForm3APIRoute,
            data: request,
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm4ResponseModel?>?> getRecyclerForm4Data(
      AuditorPostModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AuditorRecyclerForm4ResponseModel?>? response =
        await _apiBase.postRequest(
            isRetreader == true
                ? _apiRoutes.auditorRetreaderForm4APIRoute
                : _apiRoutes.auditorRecyclerForm4APIRoute,
            data: request,
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm5ResponseModel?>?> getRecyclerForm5Data(
      AuditorPostModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AuditorRecyclerForm5ResponseModel?>? response =
        await _apiBase.postRequest(
            isRetreader == true
                ? _apiRoutes.auditorRetreaderForm5APIRoute
                : _apiRoutes.auditorRecyclerForm5APIRoute,
            data: request,
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postRecyclerForm1Data(
      AuditorRecyclerForm1RequestModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      isRetreader == true
          ? _apiRoutes.auditorRetreaderForm1RequestAPIRoute
          : _apiRoutes.auditorRecyclerForm1RequestAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postRecyclerForm2Data(
      RecyclerForm2RequestModel requestModel,
      {bool? isRetreader}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      isRetreader == true
          ? _apiRoutes.auditorRetreaderForm2PostAPIRoute
          : _apiRoutes.auditorRecyclerForm2PostAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postRecyclerForm4Data(
      AuditorRecyclerForm4RequestModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      isRetreader == true
          ? _apiRoutes.auditorRetreaderForm4RequestAPIRoute
          : _apiRoutes.auditorRecyclerForm4RequestAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postRecyclerForm3Data(
      RecyclerForm3RequestModel requestModel,
      {bool? isRetreader}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      isRetreader == true
          ? _apiRoutes.auditorRetreaderForm3PostAPIRoute
          : _apiRoutes.auditorRecyclerForm3PostAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postRecyclerForm5Data(
      AuditorRecyclerForm5RequestModel requestModel,
      {bool isRetreader = false}) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      isRetreader == true
          ? _apiRoutes.auditorRetreaderForm5RequestAPIRoute
          : _apiRoutes.auditorRecyclerForm5RequestAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<DocumentResponseModel?>?> postDocumentRequest(
      DocumentRequestModel requestModel,
      {bool isRetreader = false}) async {
    FormData request = FormData.fromMap(requestModel.toJson());
    APIResponse<DocumentResponseModel?>? response = await _apiBase.postRequest(
      isRetreader == true
          ? _apiRoutes.retreaderFileUploadAPIRoute
          : _apiRoutes.recyclerFileUploadAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future getDownloadFile(String fileKey) async {
    final response = await _apiBase.getRequest(
        "${_apiRoutes.auditorUploadFileViewer}/$fileKey",
        isMediaAuthorizationRequired: true);
    return response;
  }

  Future getViewEntriesDownloadFile(String url) async {
    final splitUrl = url.split('/api');
    String? partAfterApi;
    if (splitUrl.length > 1) {
      partAfterApi = splitUrl[1];
      HelperFunctions().logger("Part after /api: $partAfterApi");
    }

    final response = await _apiBase.getRequest("api$partAfterApi",
        isMediaAuthorizationRequired: true);
    return response;
  }
}
