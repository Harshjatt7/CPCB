import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/dashboard_response_model.dart';

class CommonRepository {
  final _apiBase = APIBase();

  Future getDasboardData(String url) async {
    APIResponse<DashboardResponseModel?>? response =
        await _apiBase.getRequest(url, isAuthorizationRequired: true);
    return response;
  }
}
