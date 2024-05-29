import 'dart:convert';

AddDataResponseModel addDataResponseModelFromJson(String str) =>
    AddDataResponseModel.fromJson(json.decode(str));

class AddDataResponseModel {
  String? message;

  AddDataResponseModel({
    this.message,
  });

  factory AddDataResponseModel.fromJson(Map<String, dynamic> json) =>
      AddDataResponseModel(
        message: json["message"],
      );
}




