// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) =>
    ErrorResponseModel.fromJson(json.decode(str));

class ErrorResponseModel {
  Error? errorResponse;

  ErrorResponseModel({
    this.errorResponse,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        errorResponse:
            json["error"] == null ? null : Error.fromJson(json["error"]),
      );
}

class Error {
  String? errorDescription;

  Error({
    this.errorDescription,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorDescription: json["errorDescription"],
      );
}
