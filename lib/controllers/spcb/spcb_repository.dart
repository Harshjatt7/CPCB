import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/spcb/spcb_complaint_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';

import '../../models/response/common/add_data_response_model.dart';

class SpcbRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future<APIResponse<AddDataResponseModel>?>? postComplaint(
    SpcbComplaintRequestModel requestModel,
  ) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel>? response = await _apiBase.postRequest(
        _apiRoutes.spcbRaiseUserComplaint,
        data: request,
        isAuthorizationRequired: true);
    return response;
  }
}
