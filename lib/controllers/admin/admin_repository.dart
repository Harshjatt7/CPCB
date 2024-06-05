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
        await _apiBase.getRequest("${_apiRoutes.adminEPRApplicationsAPIRoute}$selectedUserTab", isAuthorizationRequired: true);
    return response;
  }


  Future getApplicationData({String? page = "1"}) async {
    APIResponse<AdminApplicationResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.adminApplicationReceivedProducer}?page=$page",
            isAuthorizationRequired: true);
    return response;
  }
}
