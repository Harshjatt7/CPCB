import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/retreader/procurement_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:dio/dio.dart';

class ProcurementRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future postRetreaderData(ProcurementRequestModel requestModel) async {
    FormData request = FormData.fromMap(requestModel.toJson());
    APIResponse<ProcurementRequestModel>? response =
        await _apiBase.postRequest<ProcurementRequestModel>(
      _apiRoutes.procurementAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }
}
