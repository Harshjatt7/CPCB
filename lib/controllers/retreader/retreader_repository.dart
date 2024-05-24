import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/retreader/retreader_view_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/retreader_view_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';

class RetreaderRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getRetreaderData({String? page = "1", searchValue}) async {
    APIResponse<RetreaderResponseModel?>? response = await _apiBase.getRequest(
        searchValue == null
            ? "${_apiRoutes.retreaderAPIRoute}?page=$page"
            : "${_apiRoutes.retreaderAPIRoute}?page=$page&search=$searchValue",
        isAuthorizationRequired: true);
    return response;
  }

  Future postRetreaderData(RetreaderRequestModel requestModel) async {
    APIResponse? response = await _apiBase.postRequest(
      _apiRoutes.retreaderAPIRoute,
      data: requestModel.toJson(),
      isAuthorizationRequired: true,
    );
    HelperFunctions().logger("$response");
    return response;
  }
}
