import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import '../../models/response/recycler/get_recycler_add_data_constants.dart';
import '../../models/response/recycler/get_recycler_data_list_response_model.dart';

class RecyclerRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getRecyclerData({String? page = "1", searchValue}) async {
    APIResponse<RecyclerDataListResponseModel?>? response =
        await _apiBase.getRequest(
            searchValue == null
                ? "${_apiRoutes.getRecyclerData}?page=$page"
                : "${_apiRoutes.getRecyclerData}?page=$page&supplierName=$searchValue",
            isAuthorizationRequired: true);
    return response;
  }

  Future<APIResponse<AddRecyclerDataConstantsResponseModel?>?>
      getRecyclerDataConstants() async {
    APIResponse<AddRecyclerDataConstantsResponseModel?>? response =
        await _apiBase.getRequest(_apiRoutes.getRecyclerDataConstants,
            isAuthorizationRequired: true);

    return response;
  }
}
