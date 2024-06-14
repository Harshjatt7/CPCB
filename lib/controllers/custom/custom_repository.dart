import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';

class CustomRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getDownloadCertificate(String userId) async {
    final response = await _apiBase.getRequest(
        "${_apiRoutes.customDownloadCertificateAPIRoute}?user_id=$userId",
        isMediaAuthorizationRequired: true);
    return response;
  }
}
