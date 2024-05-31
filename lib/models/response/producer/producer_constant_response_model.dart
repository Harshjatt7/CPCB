import 'dart:convert';

ProducerConstantResponseModel producerConstantResponseModelFromJson(
        String str) =>
    ProducerConstantResponseModel.fromJson(json.decode(str));

class ProducerConstantResponseModel {
  Data? data;

  ProducerConstantResponseModel({
    this.data,
  });

  factory ProducerConstantResponseModel.fromJson(Map<String, dynamic> json) =>
      ProducerConstantResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Map<String, String>? producerType;
  Map<String, String>? tyreType;
  List<String>? months;
  List<String>? financialYear;

  Data({
    this.producerType,
    this.tyreType,
    this.months,
    this.financialYear,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        producerType: json["producerType"] == null
            ? null
            : Map<String, String>.from(json["producerType"]),
        tyreType: json["tyreType"] == null
            ? null
            : Map<String, String>.from(json["tyreType"]),
        months: json["months"] == null
            ? []
            : List<String>.from(json["months"].values.map((x) => x.toString())),
        financialYear: json["financialYear"] == null
            ? []
            : List<String>.from(json["financialYear"].map((x) => x)),
      );
}
