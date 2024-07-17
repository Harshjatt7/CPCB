import 'package:dio/dio.dart';

class DocumentRequestModel {
  MultipartFile? aaddhar;
  MultipartFile? authorizedPersonPan;
  MultipartFile? lastYearElectricityBill;
  MultipartFile? airPollutionControlDevices;
  MultipartFile? otherMachineries;
  MultipartFile? geoTaggedVideoUpload;

  DocumentRequestModel(
      {this.aaddhar,
      this.authorizedPersonPan,
      this.lastYearElectricityBill,
      this.airPollutionControlDevices,
      this.otherMachineries,
      this.geoTaggedVideoUpload});

  Map<String, dynamic> toJson() => {
        "aadhaar-card": aaddhar,
        "authorizedPersonPan": authorizedPersonPan,
        "lastYearElectricityBill": lastYearElectricityBill,
        "airPollutionControlDevices": airPollutionControlDevices,
        "otherMachineries": otherMachineries,
        "geoTaggedVideoUpload": geoTaggedVideoUpload
      };
}
