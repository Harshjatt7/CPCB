import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/spcb/spcb_complaint_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/spcb/spcb_users_list_response_model.dart';

import '../../models/response/common/add_data_response_model.dart';

class SpcbRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future<APIResponse<AddDataResponseModel>?>? postComplaint(
    SpcbComplaintRequestModel requestModel,
  ) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel>? response = await _apiBase.postRequest(
        _apiRoutes.spcbRaiseUserComplaintAPIRoute,
        data: request,
        isAuthorizationRequired: true);
    return response;
  }

  Future getSpcbUserData({String? userType, String? page = "1", searchValue}) async {
    APIResponse<SpcbUsersResponseModel?>? response = await _apiBase.getRequest(
        searchValue == null
            ? "${_apiRoutes.spcbGetAllUsersAPIRoute}${userType ?? "producer"}?page=$page"
            : "${_apiRoutes.spcbGetAllUsersAPIRoute}${userType ?? "producer"}?page=$page&companyName=$searchValue",
        isAuthorizationRequired: true);
    return response;
  }
}


