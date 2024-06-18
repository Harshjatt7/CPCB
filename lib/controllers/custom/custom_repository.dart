import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/custom/custom_response_model.dart';

class CustomRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getDownloadCertificate(String userId) async {
    final response = await _apiBase.getRequest(
        "${_apiRoutes.customDownloadCertificateAPIRoute}?user_id=$userId",
        isMediaAuthorizationRequired: true);
    return response;
  }
   Future getCustomData({String? page = "1", searchValue}) async {
    APIResponse<CustomResponseModel?>? response =
        await _apiBase.getRequest(
            searchValue == null
                ? "${_apiRoutes.customProducerAPIRoute}?page=$page"
                : "${_apiRoutes.customProducerAPIRoute}?page=$page&name=$searchValue",
            isAuthorizationRequired: true);
    return response;
  }
}
