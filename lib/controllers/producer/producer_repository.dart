import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/producer/sales_data_response_model.dart';

class ProducerRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future getSalesData({String? page = "1"}) async {
    APIResponse<SalesDataResponseModel?>? response = await _apiBase.getRequest(
        "${_apiRoutes.producerSalesDataList}?page=$page",
        isAuthorizationRequired: true);
    return response;
  }
}
