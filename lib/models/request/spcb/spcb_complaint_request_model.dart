import 'dart:convert';

import 'package:dio/dio.dart';

String spcbComplaintRequestModelToJson(SpcbComplaintRequestModel data) =>
    json.encode(data.toJson());

class SpcbComplaintRequestModel {
  int? userId;
  String? complaint;
  MultipartFile? uploadFile;

  SpcbComplaintRequestModel({this.userId, this.complaint, this.uploadFile});
  Map<String, dynamic> toJson() =>
      {"userId": userId, "complaint": complaint, "complaint_file": uploadFile};
}
