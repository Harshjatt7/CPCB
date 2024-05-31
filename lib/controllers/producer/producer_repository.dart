import 'package:cpcb_tyre/constants/api_constant.dart';
import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/models/request/producer/add_sales_request_model.dart';
import 'package:cpcb_tyre/models/response/base_response_model.dart';
import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/models/response/producer/producer_constant_response_model.dart';

class ProducerRepository {
  final _apiBase = APIBase();
  final _apiRoutes = APIRoutes();

  Future<APIResponse<AddDataResponseModel?>?> postProducerSalesData(
      ProducerAddSalesRequestModel requestModel) async {
    Map<String, dynamic> request = requestModel.toJson();
    APIResponse<AddDataResponseModel?>? response = await _apiBase.postRequest(
      _apiRoutes.producerSalesDataAPIRoute,
      data: request,
      isAuthorizationRequired: true,
    );
    return response;
  }

  Future<APIResponse<ProducerConstantResponseModel?>?>
      getProducerDataConstants() async {
    APIResponse<ProducerConstantResponseModel?>? response =
        await _apiBase.getRequest(_apiRoutes.producerSalesDataConstantAPIRoute,
            isAuthorizationRequired: true);
    return response;
  }
}
