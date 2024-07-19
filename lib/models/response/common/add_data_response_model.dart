import 'dart:convert';

AddDataResponseModel addDataResponseModelFromJson(String str) =>
    AddDataResponseModel.fromJson(json.decode(str));

class AddDataResponseModel {
    String? status;
    String? message;
    bool? draftMode;

    AddDataResponseModel({
        this.status,
        this.message,
        this.draftMode,
    });

    factory AddDataResponseModel.fromJson(Map<String, dynamic> json) => AddDataResponseModel(
        status: json["status"],
        message: json["message"],
        draftMode: json["draft_mode"],
    );

}




