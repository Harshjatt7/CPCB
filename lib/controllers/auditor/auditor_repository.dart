//auditor's repo
import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/auditor/document_request_model.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form1_request_model.dart';
import 'package:cpcb_tyre/models/response/auditor/auditor_dashboard_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/document_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form1_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form2_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form3_reponse_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form4_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form5_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/request/auditor/produer_form_1_request_model.dart';
import 'package:dio/dio.dart';

import '../../models/response/common/add_data_response_model.dart';

class AuditorRepository {
  final _apiRoutes = APIRoutes();
  final _apiBase = APIBase();

  Future getDasboardData() async {
    APIResponse<AuditorDashBoardResponseModel?>? response =
        await _apiBase.getRequest(_apiRoutes.auditorDashboardAPIRoute,
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AddDataResponseModel?>?> postProducerForm1Data(
      ProducerForm1RequestModel requestModel) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.producerSalesDataAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm1ResponseModel?>?> getRecyclerForm1Data(
      String userId) async {
    APIResponse<AuditorRecyclerForm1ResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.auditorRecyclerForm1APIRoute}$userId",
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm2ResponseModel?>?> getRecyclerForm2Data(
      String userId) async {
    APIResponse<AuditorRecyclerForm2ResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.auditorRecyclerForm2APIRoute}$userId",
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm3ResponseModel?>?> getRecyclerForm3Data(
      String userId) async {
    APIResponse<AuditorRecyclerForm3ResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.auditorRecyclerForm3APIRoute}$userId",
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm4ResponseModel?>?> getRecyclerForm4Data(
      String userId) async {
    APIResponse<AuditorRecyclerForm4ResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.auditorRecyclerForm4APIRoute}$userId",
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm5ResponseModel?>?> getRecyclerForm5Data(
      String userId) async {
    APIResponse<AuditorRecyclerForm5ResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.auditorRecyclerForm3APIRoute}$userId",
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AuditorRecyclerForm1RequestModel?>?> postRecyclerForm1Data(
      ProducerForm1RequestModel requestModel) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AuditorRecyclerForm1RequestModel?>? response =
        await _apiBase.postRequest(
      _apiRoutes.auditorRecyclerForm1PostAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<DocumentResponseModel?>?> postDocumentRequest(
      DocumentRequestModel requestModel) async {
    FormData request = FormData.fromMap(requestModel.toJson());
    APIResponse<DocumentResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.fileUploadAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }
}
