import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/retreader/procurement_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/procurement_response_model.dart';
import 'package:dio/dio.dart';

class ProcurementRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future postProcurementData(ProcurementRequestModel requestModel) async {
    FormData request = FormData.fromMap(requestModel.toJson());
    APIResponse? response =
        await _apiBase.postRequest(
      _apiRoutes.procurementAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future getProcurementData({String? page = '1', searchValue}) async {
    APIResponse<ProcurementResponseModel?>? response = await _apiBase.getRequest(
        searchValue == null
            ? "${_apiRoutes.retreaderGetProcurementDataAPIRoute}?page=$page"
            : "${_apiRoutes.retreaderGetProcurementDataAPIRoute}?page=$page&seller_name=$searchValue",
        isAuthorizationRequired: true);
    return response;
  }
}
