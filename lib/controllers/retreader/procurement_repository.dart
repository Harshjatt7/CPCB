import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/retreader/procurement_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/procurement_response_model.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:dio/dio.dart';

class ProcurementRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future<APIResponse<AddDataResponseModel?>?> postProcurementData(
      ProcurementRequestModel requestModel) async {
    FormData request = FormData.fromMap(requestModel.toJson());
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.procurementAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future getProcurementData(String url, {String? page = '1', search}) async {
    APIResponse<ProcurementResponseModel?>? response =
        await _apiBase.getRequest(
            search == null
                ? "$url?page=$page"
                : MaterialAppViewModel.userTypeEnum == UserTypes.retreader
                    ? "$url?page=$page&seller_name=$search"
                    : "$url?page=$page&company_name=$search",
            isAuthorizationRequired: true);
    return response;
  }
}
