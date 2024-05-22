// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) =>
    ErrorResponseModel.fromJson(json.decode(str));

class ErrorResponseModel {
  String? message;
  Error? errorResponse;
  ErrorsList? errorsList;

  ErrorResponseModel({
    this.message,
    this.errorResponse,
    this.errorsList,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        message: json["message"],
        errorResponse:
            json["error"] == null ? null : Error.fromJson(json["error"]),
        errorsList:
            json["errors"] == null ? null : ErrorsList.fromJson(json["errors"]),
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

class ErrorsList {
  List<String>? financialYear;
  List<String>? processedQty;
  List<String>? producedQty;
  List<String>? retreadedDate;

  ErrorsList({
    this.financialYear,
    this.processedQty,
    this.producedQty,
    this.retreadedDate,
  });

  factory ErrorsList.fromJson(Map<String, dynamic> json) => ErrorsList(
        financialYear: json["financial_year"] == null
            ? []
            : List<String>.from(json["financial_year"]!.map((x) => x)),
        processedQty: json["processed_qty"] == null
            ? []
            : List<String>.from(json["processed_qty"]!.map((x) => x)),
        producedQty: json["produced_qty"] == null
            ? []
            : List<String>.from(json["produced_qty"]!.map((x) => x)),
        retreadedDate: json["retreaded_date"] == null
            ? []
            : List<String>.from(json["retreaded_date"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "financial_year": financialYear == null
            ? []
            : List<dynamic>.from(financialYear!.map((x) => x)),
        "processed_qty": processedQty == null
            ? []
            : List<dynamic>.from(processedQty!.map((x) => x)),
        "produced_qty": producedQty == null
            ? []
            : List<dynamic>.from(producedQty!.map((x) => x)),
        "retreaded_date": retreadedDate == null
            ? []
            : List<dynamic>.from(retreadedDate!.map((x) => x)),
      };
}
