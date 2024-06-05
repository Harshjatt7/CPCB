import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';

class AdminRepository {
  final _apiBase = APIBase();

  Future<APIResponse<EprApplicationResponseModel?>?> getAdminDashBoard(
      String url) async {
    APIResponse<EprApplicationResponseModel?>? response =
        await _apiBase.getRequest(url, isAuthorizationRequired: true);
    return response;
  }
}
