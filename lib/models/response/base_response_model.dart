import 'package:cpcb_tyre/models/response/error_response_model.dart';

interface class APIResponse<T> {
  final bool? isSuccess;

  T? data;
  final List<String>? headers;

  dynamic completeResponse;

  final ErrorResponseModel? error;

  APIResponse(
      {this.isSuccess,
      this.data,
      this.completeResponse,
      this.error,
      this.headers});
}
