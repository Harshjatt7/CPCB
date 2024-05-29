import 'package:cpcb_tyre/models/response/common/add_data_response_model.dart';
import 'package:cpcb_tyre/models/response/error_response_model.dart';

interface class APIResponse<T> {
  final bool? isSuccess;

  T? data;

  dynamic completeResponse;

  final ErrorResponseModel? error;
  
  final AddDataResponseModel? addResponse;

  APIResponse({
    this.isSuccess,
    this.data,
    this.completeResponse,
    this.error,
    this.addResponse,
  });
}
