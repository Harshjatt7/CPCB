import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/admin/common_epr_oblication_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_application_response_model.dart';
import 'package:cpcb_tyre/models/response/admin/epr_oblications.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';

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

  Future<APIResponse<EprOblicationsResponseModel?>?> getEprOblications() async {
    APIResponse<EprOblicationsResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.adminEPROblicationsAPIRoute}producer",
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<CommonEprOblicationsResponseModel?>?>
      getCommonEprOblications(String selectedUserTab) async {
    APIResponse<CommonEprOblicationsResponseModel?>? response = await _apiBase
        .getRequest("${_apiRoutes.adminEPROblicationsAPIRoute}$selectedUserTab",
            isAuthorizationRequired: true);
    return response;
  }
}
