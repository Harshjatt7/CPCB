import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/retreader/procurement_request_model.dart';
import 'package:cpcb_tyre/models/request/retreader/retreader_view_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/procurement_response_model.dart';
import 'package:cpcb_tyre/models/response/retreader/retreader_view_response_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:dio/dio.dart';

import '../../models/response/common/add_data_response_model.dart';

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

  Future<APIResponse<AddDataResponseModel?>?> postRetreaderData(
      RetreaderRequestModel requestModel) async {
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.retreaderAPIRoute,
      data: requestModel.toJson(),
      isAuthorizationRequired: true,
    );
    HelperFunctions().logger("$response");
    return response;
  }
  Future postProcurementData(ProcurementRequestModel requestModel) async {
    FormData request = FormData.fromMap(requestModel.toJson());
    APIResponse? response = await _apiBase.postRequest(
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

