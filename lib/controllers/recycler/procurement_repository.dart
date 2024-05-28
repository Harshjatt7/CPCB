import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/procurement_response_model.dart';

class RecyclerProcurementRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getProcurementData({String? page = '1', companyName}) async {
    APIResponse<ProcurementResponseModel?>? response = await _apiBase.getRequest(
        companyName == null
            ? "${_apiRoutes.retreaderGetProcurementDataAPIRoute}?page=$page"
            : "${_apiRoutes.retreaderGetProcurementDataAPIRoute}?page=$page&company_name=$companyName",
        isAuthorizationRequired: true);
    return response;
  }
}
