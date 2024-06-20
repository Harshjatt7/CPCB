import 'dart:convert';

String spcbComplaintRequestModelToJson(SpcbComplaintRequestModel data) =>
    json.encode(data.toJson());

class SpcbComplaintRequestModel {
  int? userId;
  String? complaint;

  SpcbComplaintRequestModel({
    this.userId,
    this.complaint,
  });
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "complaint": complaint,
      };
}
