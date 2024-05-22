import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/dashboard_response_model.dart';
import 'package:cpcb_tyre/models/response/common/profile_response_model.dart';

class CommonRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getDasboardData(String url) async {
    APIResponse<DashboardResponseModel?>? response =
        await _apiBase.getRequest(url, isAuthorizationRequired: true);
    return response;
  }

  Future getProfileData() async {
    APIResponse<ProfileResponseModel?>? response = await _apiBase.getRequest(
      _apiRoutes.profileAPIRoute,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future logout() async {
    APIResponse? response = await _apiBase
        .postRequest(_apiRoutes.logoutAPIRoute, isAuthorizationRequired: true);

    return response;
  }

  Future getDownloadPaymentReceipt(String url) async {
    final response =
        await _apiBase.getRequest(url, isMediaAuthorizationRequired: true);
    return response;
  }
}
