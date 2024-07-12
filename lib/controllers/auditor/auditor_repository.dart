//auditor's repo
import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/auditor/auditor_dashboard_response_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';

class AuditorRepository {
  final _apiRoutes = APIRoutes();
  final _apiBase = APIBase();

  Future getDasboardData() async {
    APIResponse<AuditorDashBoardResponseModel?>? response =
        await _apiBase.getRequest(_apiRoutes.auditorDashboardAPIRoute,
            isAuthorizationRequired: true);
    return response;
  }
}
