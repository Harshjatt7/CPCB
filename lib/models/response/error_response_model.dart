class ErrorResponseModel {
  Error? error;
  int? statusCode;

  ErrorResponseModel({this.error, this.statusCode});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        statusCode: json["statusCode"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );
}

class Error {
  String? errorCode;
  String? errorDescription;

  Error({
    this.errorCode,
    this.errorDescription,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json["errorCode"],
        errorDescription: json["errorDescription"],
      );
}
