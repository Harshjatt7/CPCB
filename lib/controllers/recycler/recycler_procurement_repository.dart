import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/recycler/recycler_procurement_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/recycler/recycler_procurement_response_model.dart';
import 'package:dio/dio.dart';

class RecyclerProcurementRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future postRecyclerProcurementData(
      RecyclerProcurementRequestModel requestModel) async {
    FormData request = FormData.fromMap(requestModel.toJson());
    APIResponse? response = await _apiBase.postRequest(
      _apiRoutes.reyclerProcurementAddDataAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future getRecyclerProcurementConstantData() async {
    APIResponse<RecyclerProcurementConstantsResponseData?>? response =
        await _apiBase.getRequest(
            _apiRoutes.reyclerProcurementConstantDataAPIRoute,
            isAuthorizationRequired: true,
            isRefreshTokenAuthorizationRequired: true);
    return response;
  }
}
