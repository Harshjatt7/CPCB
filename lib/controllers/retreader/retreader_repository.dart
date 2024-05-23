import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/retreader/retreader_view_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/retreader_view_response_model.dart';

class RetreaderRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getRetreaderData(String url, {String? page = "1",searchValue}) async {
    APIResponse<RetreaderResponseModel?>? response =
        await _apiBase.getRequest(searchValue == null ?"$url?page=$page" : "$url?page=$page&seller_name=$searchValue", isAuthorizationRequired: true);
    return response;
  }

  Future postRetreaderData(RetreaderRequestModel requestModel) async {
    APIResponse<RetreaderRequestModel>? response = 
        await _apiBase.postRequest<RetreaderRequestModel>(_apiRoutes.retreaderAPIRoute,
            data: requestModel.toJson(), isAuthorizationRequired: true,);
    return response;
  }
}
