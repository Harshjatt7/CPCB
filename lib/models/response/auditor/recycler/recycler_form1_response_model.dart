// To parse this JSON data, do
//
//     final auditorRecyclerForm1ResponseModel = auditorRecyclerForm1ResponseModelFromJson(jsonString);

import 'dart:convert';

AuditorRecyclerForm1ResponseModel auditorRecyclerForm1ResponseModelFromJson(
        String str) =>
    AuditorRecyclerForm1ResponseModel.fromJson(json.decode(str));

String auditorRecyclerForm1ResponseModelToJson(
        AuditorRecyclerForm1ResponseModel data) =>
    json.encode(data.toJson());

class AuditorRecyclerForm1ResponseModel {
  AuditorRecyclerForm1Data? data;

  AuditorRecyclerForm1ResponseModel({
    this.data,
  });

  factory AuditorRecyclerForm1ResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AuditorRecyclerForm1ResponseModel(
        data: json["data"] == null
            ? null
            : AuditorRecyclerForm1Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class AuditorRecyclerForm1Data {
  String? auditPlanId;
  GeneralInfoStep1Data? generalInfo;
  AuditSummary? auditSummary;

  AuditorRecyclerForm1Data({
    this.auditPlanId,
    this.generalInfo,
    this.auditSummary,
  });

  factory AuditorRecyclerForm1Data.fromJson(Map<String, dynamic> json) =>
      AuditorRecyclerForm1Data(
        auditPlanId: json["auditPlanId"],
        generalInfo: json["generalInfo"] == null
            ? null
            : GeneralInfoStep1Data.fromJson(json["generalInfo"]),
        auditSummary: json["auditSummary"] == null
            ? null
            : AuditSummary.fromJson(json["auditSummary"]),
      );

  Map<String, dynamic> toJson() => {
        "auditPlanId": auditPlanId,
        "generalInfo": generalInfo?.toJson(),
        "auditSummary": auditSummary?.toJson(),
      };
}

class AuditSummary {
  AddressLine1? gstNo;
  AddressLine1? companyPan;
  AddressLine1? companyIec;
  AddressLine1? cto;
  AddressLine1? authorizationUnderHomwRules;
  AddressLine1? addressLine1;
  AddressLine1? gpsLocationRecycler;
  GpsLocationAuditor? gpsLocationAuditor;
  AirPollutionControlDevices? authorizedPersonAdhar;
  AirPollutionControlDevices? authorizedPersonPan;
  OtherMachineries? otherMachineries;
  AirPollutionControlDevices? lastYearElectricityBill;
  AirPollutionControlDevices? airPollutionControlDevices;
  AirPollutionControlDevices? geoTaggedVideoUpload;

  AuditSummary({
    this.gstNo,
    this.companyPan,
    this.companyIec,
    this.cto,
    this.authorizationUnderHomwRules,
    this.addressLine1,
    this.gpsLocationRecycler,
    this.gpsLocationAuditor,
    this.authorizedPersonAdhar,
    this.authorizedPersonPan,
    this.otherMachineries,
    this.lastYearElectricityBill,
    this.airPollutionControlDevices,
    this.geoTaggedVideoUpload,
  });

  factory AuditSummary.fromJson(Map<String, dynamic> json) => AuditSummary(
        gstNo:
            json["gstNo"] == null ? null : AddressLine1.fromJson(json["gstNo"]),
        companyPan: json["companyPan"] == null
            ? null
            : AddressLine1.fromJson(json["companyPan"]),
        companyIec: json["companyIEC"] == null
            ? null
            : AddressLine1.fromJson(json["companyIEC"]),
        cto: json["cto"] == null ? null : AddressLine1.fromJson(json["cto"]),
        authorizationUnderHomwRules: json["authorizationUnderHomwRules"] == null
            ? null
            : AddressLine1.fromJson(json["authorizationUnderHomwRules"]),
        addressLine1: json["addressLine1"] == null
            ? null
            : AddressLine1.fromJson(json["addressLine1"]),
        gpsLocationRecycler: json["gpsLocationRecycler"] == null
            ? null
            : AddressLine1.fromJson(json["gpsLocationRecycler"]),
        gpsLocationAuditor: json["gpsLocationAuditor"] == null
            ? null
            : GpsLocationAuditor.fromJson(json["gpsLocationAuditor"]),
        authorizedPersonAdhar: json["authorizedPersonAdhar"] == null
            ? null
            : AirPollutionControlDevices.fromJson(
                json["authorizedPersonAdhar"]),
        authorizedPersonPan: json["authorizedPersonPan"] == null
            ? null
            : AirPollutionControlDevices.fromJson(json["authorizedPersonPan"]),
        otherMachineries: json["otherMachineries"] == null
            ? null
            : OtherMachineries.fromJson(json["otherMachineries"]),
        lastYearElectricityBill: json["lastYearElectricityBill"] == null
            ? null
            : AirPollutionControlDevices.fromJson(
                json["lastYearElectricityBill"]),
        airPollutionControlDevices: json["airPollutionControlDevices"] == null
            ? null
            : AirPollutionControlDevices.fromJson(
                json["airPollutionControlDevices"]),
        geoTaggedVideoUpload: json["geoTaggedVideoUpload"] == null
            ? null
            : AirPollutionControlDevices.fromJson(json["geoTaggedVideoUpload"]),
      );

  Map<String, dynamic> toJson() => {
        "gstNo": gstNo?.toJson(),
        "companyPan": companyPan?.toJson(),
        "companyIEC": companyIec?.toJson(),
        "cto": cto?.toJson(),
        "authorizationUnderHomwRules": authorizationUnderHomwRules?.toJson(),
        "addressLine1": addressLine1?.toJson(),
        "gpsLocationRecycler": gpsLocationRecycler?.toJson(),
        "gpsLocationAuditor": gpsLocationAuditor?.toJson(),
        "authorizedPersonAdhar": authorizedPersonAdhar?.toJson(),
        "authorizedPersonPan": authorizedPersonPan?.toJson(),
        "otherMachineries": otherMachineries?.toJson(),
        "lastYearElectricityBill": lastYearElectricityBill?.toJson(),
        "airPollutionControlDevices": airPollutionControlDevices?.toJson(),
        "geoTaggedVideoUpload": geoTaggedVideoUpload?.toJson(),
      };
}

class AddressLine1 {
  dynamic auditValue;
  dynamic auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  List<dynamic>? additionalData;

  AddressLine1({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory AddressLine1.fromJson(Map<String, dynamic> json) => AddressLine1(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? []
            : List<dynamic>.from(json["additional_data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData == null
            ? []
            : List<dynamic>.from(additionalData!.map((x) => x)),
      };
}

class AirPollutionControlDevices {
  dynamic auditValue;
  String? auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  AirPollutionControlDevicesAdditionalData? additionalData;

  AirPollutionControlDevices({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory AirPollutionControlDevices.fromJson(Map<String, dynamic> json) =>
      AirPollutionControlDevices(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : AirPollutionControlDevicesAdditionalData.fromJson(
                json["additional_data"]),
      );

  Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
      };
}

class AirPollutionControlDevicesAdditionalData {
  String? fileKey;
  String? fileLink;

  AirPollutionControlDevicesAdditionalData({
    this.fileKey,
    this.fileLink,
  });

  factory AirPollutionControlDevicesAdditionalData.fromJson(
          Map<String, dynamic> json) =>
      AirPollutionControlDevicesAdditionalData(
        fileKey: json["fileKey"],
        fileLink: json["fileLink"],
      );

  Map<String, dynamic> toJson() => {
        "fileKey": fileKey,
        "fileLink": fileLink,
      };
}

class GpsLocationAuditor {
  dynamic auditValue;
  dynamic auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  GpsLocationAuditorAdditionalData? additionalData;

  GpsLocationAuditor({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory GpsLocationAuditor.fromJson(Map<String, dynamic> json) =>
      GpsLocationAuditor(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : GpsLocationAuditorAdditionalData.fromJson(
                json["additional_data"]),
      );

  Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
      };
}

class GpsLocationAuditorAdditionalData {
  String? lat;
  String? long;

  GpsLocationAuditorAdditionalData({
    this.lat,
    this.long,
  });

  factory GpsLocationAuditorAdditionalData.fromJson(
          Map<String, dynamic> json) =>
      GpsLocationAuditorAdditionalData(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

class OtherMachineries {
  dynamic auditValue;
  dynamic auditDocument;
  dynamic auditRemark;
  int? auditConfirmedStatus;
  OtherMachineriesAdditionalData? additionalData;

  OtherMachineries({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory OtherMachineries.fromJson(Map<String, dynamic> json) =>
      OtherMachineries(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : OtherMachineriesAdditionalData.fromJson(json["additional_data"]),
      );

  Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
      };
}

class OtherMachineriesAdditionalData {
  List<Om>? om;

  OtherMachineriesAdditionalData({
    this.om,
  });

  factory OtherMachineriesAdditionalData.fromJson(Map<String, dynamic> json) =>
      OtherMachineriesAdditionalData(
        om: json["om"] == null
            ? []
            : List<Om>.from(json["om"]!.map((x) => Om.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "om": om == null ? [] : List<dynamic>.from(om!.map((x) => x.toJson())),
      };
}

class Om {
  String? value;
  String? auditDocument;
  String? fileKey;
  String? fileLink;

  Om({
    this.value,
    this.auditDocument,
    this.fileKey,
    this.fileLink,
  });

  factory Om.fromJson(Map<String, dynamic> json) => Om(
        value: json["value"],
        auditDocument: json["audit_document"],
        fileKey: json["fileKey"],
        fileLink: json["fileLink"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "audit_document": auditDocument,
        "fileKey": fileKey,
        "fileLink": fileLink,
      };
}

class GeneralInfoStep1Data {
  String? gstNo;
  String? companyPan;
  String? companyIec;
  String? cto;
  String? authorizationUnderHomwRules;
  String? addressLine1;
  String? lat;
  String? long;
  String? authorizedPersonAdhar;
  String? authorizedPersonPan;
  List<dynamic>? detailsOfMachinery;
  String? airPollutionControlDevices;

  GeneralInfoStep1Data({
    this.gstNo,
    this.companyPan,
    this.companyIec,
    this.cto,
    this.authorizationUnderHomwRules,
    this.addressLine1,
    this.lat,
    this.long,
    this.authorizedPersonAdhar,
    this.authorizedPersonPan,
    this.detailsOfMachinery,
    this.airPollutionControlDevices,
  });

  factory GeneralInfoStep1Data.fromJson(Map<String, dynamic> json) =>
      GeneralInfoStep1Data(
        gstNo: json["gstNo"],
        companyPan: json["companyPan"],
        companyIec: json["companyIEC"],
        cto: json["cto"],
        authorizationUnderHomwRules: json["authorizationUnderHomwRules"],
        addressLine1: json["addressLine1"],
        lat: json["lat"],
        long: json["long"],
        authorizedPersonAdhar: json["authorizedPersonAdhar"],
        authorizedPersonPan: json["authorizedPersonPan"],
        detailsOfMachinery: json["detailsOfMachinery"] == null
            ? []
            : List<dynamic>.from(json["detailsOfMachinery"]!.map((x) => x)),
        airPollutionControlDevices: json["airPollutionControlDevices"],
      );

  Map<String, dynamic> toJson() => {
        "gstNo": gstNo,
        "companyPan": companyPan,
        "companyIEC": companyIec,
        "cto": cto,
        "authorizationUnderHomwRules": authorizationUnderHomwRules,
        "addressLine1": addressLine1,
        "lat": lat,
        "long": long,
        "authorizedPersonAdhar": authorizedPersonAdhar,
        "authorizedPersonPan": authorizedPersonPan,
        "detailsOfMachinery": detailsOfMachinery == null
            ? []
            : List<dynamic>.from(detailsOfMachinery!.map((x) => x)),
        "airPollutionControlDevices": airPollutionControlDevices,
      };
}

// import 'dart:convert';

// AuditorRecyclerForm1ResponseModel stateAndDistrictResponseModelFromJson(
//         String str) =>
//     AuditorRecyclerForm1ResponseModel.fromJson(json.decode(str));

// class AuditorRecyclerForm1ResponseModel {
//   Data? data;

//   AuditorRecyclerForm1ResponseModel({
//     this.data,
//   });

//   factory AuditorRecyclerForm1ResponseModel.fromJson(Map<String, dynamic> json) =>
//       AuditorRecyclerForm1ResponseModel(
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );
// }

// class Data {
//   String? auditPlanId;
//   GeneralInfoStep1Data? generalInfo;
//   AuditSummary? auditSummary;
//   Data({
//     this.auditPlanId,
//     this.generalInfo,
//     this.auditSummary,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         auditPlanId: json["auditPlanId"],
//         generalInfo: json["generalInfo"] == null
//             ? null
//             : GeneralInfoStep1Data.fromJson(json["generalInfo"]),
//         auditSummary: json["auditSummary"] == null
//             ? null
//             : AuditSummary.fromJson(json["auditSummary"]),
//       );
// }

// class AuditSummary {
//   AddressLine1? gstNo;
//   AddressLine1? companyPan;
//   AddressLine1? companyIec;
//   AddressLine1? cto;
//   AddressLine1? authorizationUnderHomwRules;
//   AddressLine1? addressLine1;
//   AddressLine1? gpsLocationRecycler;
//   GpsLocationAuditor? gpsLocationAuditor;
//   AirPollutionControlDevices? authorizedPersonAdhar;
//   AirPollutionControlDevices? authorizedPersonPan;
//   OtherMachineries? otherMachineries;
//   AirPollutionControlDevices? lastYearElectricityBill;
//   AirPollutionControlDevices? airPollutionControlDevices;
//   AirPollutionControlDevices? geoTaggedVideoUpload;

//   AuditSummary({
//     this.gstNo,
//     this.companyPan,
//     this.companyIec,
//     this.cto,
//     this.authorizationUnderHomwRules,
//     this.addressLine1,
//     this.gpsLocationRecycler,
//     this.gpsLocationAuditor,
//     this.authorizedPersonAdhar,
//     this.authorizedPersonPan,
//     this.otherMachineries,
//     this.lastYearElectricityBill,
//     this.airPollutionControlDevices,
//     this.geoTaggedVideoUpload,
//   });

//   factory AuditSummary.fromJson(Map<String, dynamic> json) => AuditSummary(
//         gstNo:
//             json["gstNo"] == null ? null : AddressLine1.fromJson(json["gstNo"]),
//         companyPan: json["companyPan"] == null
//             ? null
//             : AddressLine1.fromJson(json["companyPan"]),
//         companyIec: json["companyIEC"] == null
//             ? null
//             : AddressLine1.fromJson(json["companyIEC"]),
//         cto: json["cto"] == null ? null : AddressLine1.fromJson(json["cto"]),
//         authorizationUnderHomwRules: json["authorizationUnderHomwRules"] == null
//             ? null
//             : AddressLine1.fromJson(json["authorizationUnderHomwRules"]),
//         addressLine1: json["addressLine1"] == null
//             ? null
//             : AddressLine1.fromJson(json["addressLine1"]),
//         gpsLocationRecycler: json["gpsLocationRecycler"] == null
//             ? null
//             : AddressLine1.fromJson(json["gpsLocationRecycler"]),
//         gpsLocationAuditor: json["gpsLocationAuditor"] == null
//             ? null
//             : GpsLocationAuditor.fromJson(json["gpsLocationAuditor"]),
//         authorizedPersonAdhar: json["authorizedPersonAdhar"] == null
//             ? null
//             : AirPollutionControlDevices.fromJson(
//                 json["authorizedPersonAdhar"]),
//         authorizedPersonPan: json["authorizedPersonPan"] == null
//             ? null
//             : AirPollutionControlDevices.fromJson(json["authorizedPersonPan"]),
//         otherMachineries: json["otherMachineries"] == null
//             ? null
//             : OtherMachineries.fromJson(json["otherMachineries"]),
//         lastYearElectricityBill: json["lastYearElectricityBill"] == null
//             ? null
//             : AirPollutionControlDevices.fromJson(
//                 json["lastYearElectricityBill"]),
//         airPollutionControlDevices: json["airPollutionControlDevices"] == null
//             ? null
//             : AirPollutionControlDevices.fromJson(
//                 json["airPollutionControlDevices"]),
//         geoTaggedVideoUpload: json["geoTaggedVideoUpload"] == null
//             ? null
//             : AirPollutionControlDevices.fromJson(json["geoTaggedVideoUpload"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "gstNo": gstNo?.toJson(),
//         "companyPan": companyPan?.toJson(),
//         "companyIEC": companyIec?.toJson(),
//         "cto": cto?.toJson(),
//         "authorizationUnderHomwRules": authorizationUnderHomwRules?.toJson(),
//         "addressLine1": addressLine1?.toJson(),
//         "gpsLocationRecycler": gpsLocationRecycler?.toJson(),
//         "gpsLocationAuditor": gpsLocationAuditor?.toJson(),
//         "authorizedPersonAdhar": authorizedPersonAdhar?.toJson(),
//         "authorizedPersonPan": authorizedPersonPan?.toJson(),
//         "otherMachineries": otherMachineries?.toJson(),
//         "lastYearElectricityBill": lastYearElectricityBill?.toJson(),
//         "airPollutionControlDevices": airPollutionControlDevices?.toJson(),
//         "geoTaggedVideoUpload": geoTaggedVideoUpload?.toJson(),
//       };
// }

// class AddressLine1 {
//   dynamic auditValue;
//   dynamic auditDocument;
//   String? auditRemark;
//   int? auditConfirmedStatus;
//   List<dynamic>? additionalData;

//   AddressLine1({
//     this.auditValue,
//     this.auditDocument,
//     this.auditRemark,
//     this.auditConfirmedStatus,
//     this.additionalData,
//   });

//   factory AddressLine1.fromJson(Map<String, dynamic> json) => AddressLine1(
//         auditValue: json["audit_value"],
//         auditDocument: json["audit_document"],
//         auditRemark: json["audit_remark"],
//         auditConfirmedStatus: json["audit_confirmed_status"],
//         additionalData: json["additional_data"] == null
//             ? []
//             : List<dynamic>.from(json["additional_data"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "audit_value": auditValue,
//         "audit_document": auditDocument,
//         "audit_remark": auditRemark,
//         "audit_confirmed_status": auditConfirmedStatus,
//         "additional_data": additionalData == null
//             ? []
//             : List<dynamic>.from(additionalData!.map((x) => x)),
//       };
// }

// class AirPollutionControlDevices {
//   dynamic auditValue;
//   String? auditDocument;
//   String? auditRemark;
//   int? auditConfirmedStatus;
//   AirPollutionControlDevicesAdditionalData? additionalData;

//   AirPollutionControlDevices({
//     this.auditValue,
//     this.auditDocument,
//     this.auditRemark,
//     this.auditConfirmedStatus,
//     this.additionalData,
//   });

//   factory AirPollutionControlDevices.fromJson(Map<String, dynamic> json) =>
//       AirPollutionControlDevices(
//         auditValue: json["audit_value"],
//         auditDocument: json["audit_document"],
//         auditRemark: json["audit_remark"],
//         auditConfirmedStatus: json["audit_confirmed_status"],
//         additionalData: json["additional_data"] == null
//             ? null
//             : AirPollutionControlDevicesAdditionalData.fromJson(
//                 json["additional_data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "audit_value": auditValue,
//         "audit_document": auditDocument,
//         "audit_remark": auditRemark,
//         "audit_confirmed_status": auditConfirmedStatus,
//         "additional_data": additionalData?.toJson(),
//       };
// }

// class AirPollutionControlDevicesAdditionalData {
//   String? fileKey;
//   String? fileLink;

//   AirPollutionControlDevicesAdditionalData({
//     this.fileKey,
//     this.fileLink,
//   });

//   factory AirPollutionControlDevicesAdditionalData.fromJson(
//           Map<String, dynamic> json) =>
//       AirPollutionControlDevicesAdditionalData(
//         fileKey: json["fileKey"],
//         fileLink: json["fileLink"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fileKey": fileKey,
//         "fileLink": fileLink,
//       };
// }

// class GpsLocationAuditor {
//   dynamic auditValue;
//   dynamic auditDocument;
//   String? auditRemark;
//   int? auditConfirmedStatus;
//   GpsLocationAuditorAdditionalData? additionalData;

//   GpsLocationAuditor({
//     this.auditValue,
//     this.auditDocument,
//     this.auditRemark,
//     this.auditConfirmedStatus,
//     this.additionalData,
//   });

//   factory GpsLocationAuditor.fromJson(Map<String, dynamic> json) =>
//       GpsLocationAuditor(
//         auditValue: json["audit_value"],
//         auditDocument: json["audit_document"],
//         auditRemark: json["audit_remark"],
//         auditConfirmedStatus: json["audit_confirmed_status"],
//         additionalData: json["additional_data"] == null
//             ? null
//             : GpsLocationAuditorAdditionalData.fromJson(
//                 json["additional_data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "audit_value": auditValue,
//         "audit_document": auditDocument,
//         "audit_remark": auditRemark,
//         "audit_confirmed_status": auditConfirmedStatus,
//         "additional_data": additionalData?.toJson(),
//       };
// }

// class GpsLocationAuditorAdditionalData {
//   String? lat;
//   String? long;

//   GpsLocationAuditorAdditionalData({
//     this.lat,
//     this.long,
//   });

//   factory GpsLocationAuditorAdditionalData.fromJson(
//           Map<String, dynamic> json) =>
//       GpsLocationAuditorAdditionalData(
//         lat: json["lat"],
//         long: json["long"],
//       );

//   Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "long": long,
//       };
// }

// class OtherMachineries {
//   dynamic auditValue;
//   dynamic auditDocument;
//   dynamic auditRemark;
//   int? auditConfirmedStatus;
//   OtherMachineriesAdditionalData? additionalData;

//   OtherMachineries({
//     this.auditValue,
//     this.auditDocument,
//     this.auditRemark,
//     this.auditConfirmedStatus,
//     this.additionalData,
//   });

//   factory OtherMachineries.fromJson(Map<String, dynamic> json) =>
//       OtherMachineries(
//         auditValue: json["audit_value"],
//         auditDocument: json["audit_document"],
//         auditRemark: json["audit_remark"],
//         auditConfirmedStatus: json["audit_confirmed_status"],
//         additionalData: json["additional_data"] == null
//             ? null
//             : OtherMachineriesAdditionalData.fromJson(json["additional_data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "audit_value": auditValue,
//         "audit_document": auditDocument,
//         "audit_remark": auditRemark,
//         "audit_confirmed_status": auditConfirmedStatus,
//         "additional_data": additionalData?.toJson(),
//       };
// }

// class OtherMachineriesAdditionalData {
//   List<Om>? om;

//   OtherMachineriesAdditionalData({
//     this.om,
//   });

//   factory OtherMachineriesAdditionalData.fromJson(Map<String, dynamic> json) =>
//       OtherMachineriesAdditionalData(
//         om: json["om"] == null
//             ? []
//             : List<Om>.from(json["om"]!.map((x) => Om.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "om": om == null ? [] : List<dynamic>.from(om!.map((x) => x.toJson())),
//       };
// }

// class Om {
//   String? value;
//   String? auditDocument;
//   String? fileKey;
//   String? fileLink;

//   Om({
//     this.value,
//     this.auditDocument,
//     this.fileKey,
//     this.fileLink,
//   });

//   factory Om.fromJson(Map<String, dynamic> json) => Om(
//         value: json["value"],
//         auditDocument: json["audit_document"],
//         fileKey: json["fileKey"],
//         fileLink: json["fileLink"],
//       );

//   Map<String, dynamic> toJson() => {
//         "value": value,
//         "audit_document": auditDocument,
//         "fileKey": fileKey,
//         "fileLink": fileLink,
//       };
// }


// class GeneralInfoStep1Data {
//   String? gstNo;
//   String? companyPan;
//   String? companyIec;
//   String? cto;
//   String? authorizationUnderHomwRules;
//   String? addressLine1;
//   String? lat;
//   String? long;
//   String? authorizedPersonAdhar;
//   String? authorizedPersonPan;
//   Map<String, Nw>? detailsOfMachinery;
//   String? airPollutionControlDevices;

//   GeneralInfoStep1Data({
//     this.gstNo,
//     this.companyPan,
//     this.companyIec,
//     this.cto,
//     this.authorizationUnderHomwRules,
//     this.addressLine1,
//     this.lat,
//     this.long,
//     this.authorizedPersonAdhar,
//     this.authorizedPersonPan,
//     this.detailsOfMachinery,
//     this.airPollutionControlDevices,
//   });

//   factory GeneralInfoStep1Data.fromJson(Map<String, dynamic> json) =>
//       GeneralInfoStep1Data(
//         gstNo: json["gstNo"],
//         companyPan: json["companyPan"],
//         companyIec: json["companyIEC"],
//         cto: json["cto"],
//         authorizationUnderHomwRules: json["authorizationUnderHomwRules"],
//         addressLine1: json["addressLine1"],
//         lat: json["lat"],
//         long: json["long"],
//         authorizedPersonAdhar: json["authorizedPersonAdhar"],
//         authorizedPersonPan: json["authorizedPersonPan"],
//         detailsOfMachinery: json["detailsOfMachinery"].forEach(
//           (key, value) {
//             json["detailsOfMachinery"][key] = Nw.fromJson(value);
//           },
//         ),
//         airPollutionControlDevices: json["airPollutionControlDevices"],
//       );

//   Map<String, dynamic> toJson() => {
//         "gstNo": gstNo,
//         "companyPan": companyPan,
//         "companyIEC": companyIec,
//         "cto": cto,
//         "authorizationUnderHomwRules": authorizationUnderHomwRules,
//         "addressLine1": addressLine1,
//         "lat": lat,
//         "long": long,
//         "authorizedPersonAdhar": authorizedPersonAdhar,
//         "authorizedPersonPan": authorizedPersonPan,
// //"detailsOfMachinery": detailsOfMachinery?.toJson(),
//         "airPollutionControlDevices": airPollutionControlDevices,
//       };
// }

// class DetailsOfMachinery {
//   Nw? nw;

//   DetailsOfMachinery({
//     this.nw,
//   });

//   factory DetailsOfMachinery.fromJson(Map<String, dynamic> json) =>
//       DetailsOfMachinery(
//         nw: json["Nw"] == null ? null : Nw.fromJson(json["Nw"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "Nw": nw?.toJson(),
//       };
// }

// class Nw {
//   String? machineryInstalled;
//   String? power;
//   String? capacity;
//   String? machineryId;

//   Nw({
//     this.machineryInstalled,
//     this.power,
//     this.capacity,
//     this.machineryId,
//   });

//   factory Nw.fromJson(Map<String, dynamic> json) => Nw(
//         machineryInstalled: json["Machinery_Installed"],
//         power: json["Power"],
//         capacity: json["Capacity"],
//         machineryId: json["machinery_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Machinery_Installed": machineryInstalled,
//         "Power": power,
//         "Capacity": capacity,
//         "machinery_id": machineryId,
//       };
// }
