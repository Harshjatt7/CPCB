import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';

import '../../models/response/admin/admin_application_response_model.dart';

class AdminRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future<APIResponse<EprApplicationResponseModel?>?> getAdminDashBoard(
      String selectedUserTab) async {
    APIResponse<EprApplicationResponseModel?>? response =
        await _apiBase.getRequest(
            "${_apiRoutes.adminEPRApplicationsAPIRoute}$selectedUserTab",
            isAuthorizationRequired: true);
    return response;
  }

  Future getApplicationData(
      {String? userType, String? page = "1", String? search}) async {
    APIResponse<AdminApplicationResponseModel?>? response =
        await _apiBase.getRequest(
            search == null
                ? "${_apiRoutes.adminApplicationReceived}/$userType?page=$page"
                : "${_apiRoutes.adminApplicationReceived}/$userType?page=$page&search=$search",
    
            isAuthorizationRequired: true);
    return response;
  }
}
