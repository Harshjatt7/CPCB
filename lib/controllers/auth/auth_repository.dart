import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/login_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/auth/login_response_model.dart';

class AuthRepository {
  final _apiRoutes = APIRoutes();
  final _apiBase = APIBase();

  Future login(LoginRequestModel requestModel) async {
    APIResponse<LoginResponseModel>? response =
        await _apiBase.postRequest<LoginResponseModel>(_apiRoutes.loginAPIRoute,
            data: requestModel.toJson(), isAuthorizationRequired: false);
    return response;
  }

  Future refreshToken() async {
    APIResponse<LoginResponseModel>? response = await _apiBase.postRequest(
        _apiRoutes.refreshTokenAPIRoute,
        isRefreshTokenAuthorizationRequired: true);
    return response;
  }
}
