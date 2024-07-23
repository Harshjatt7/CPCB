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
        if (aaddhar != null) "aadhaar-card": aaddhar,
        if (authorizedPersonPan != null)
          "authorizedPersonPan": authorizedPersonPan,
        if (lastYearElectricityBill != null)
          "lastYearElectricityBill": lastYearElectricityBill,
        if (airPollutionControlDevices != null)
          "airPollutionControlDevices": airPollutionControlDevices,
        if (otherMachineries != null) "otherMachineries": otherMachineries,
        if (geoTaggedVideoUpload != null)
          "geoTaggedVideoUpload": geoTaggedVideoUpload
      };
}
