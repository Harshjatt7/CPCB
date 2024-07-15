//auditor's repo
import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/auditor/recycler/recycler_form1_request_model.dart';
import 'package:cpcb_tyre/models/response/auditor/auditor_dashboard_response_model.dart';
import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/request/auditor/produer_form_1_request_model.dart';

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

  Future<APIResponse<AuditorRecyclerFormResponseModel?>?> getRecyclerData(
      {String? url}) async {
    APIResponse<AuditorRecyclerFormResponseModel?>? response =
        await _apiBase.getRequest(url ?? "", isAuthorizationRequired: true);
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
}
