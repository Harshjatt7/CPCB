class AuditorRecyclerForm1RequestModel {
  GenerralInfoRequest? generalInfo;
  String? submit;
  String? auditPlanId;

  AuditorRecyclerForm1RequestModel(
      {this.generalInfo, this.submit, this.auditPlanId});

  Map<String, dynamic> toJson() => {
        "generalInfo": generalInfo?.toJson(),
        "submit": submit,
        "auditPlanId": auditPlanId,
      };
}

class GenerralInfoRequest {
  AddressLine? gstNo;
  AddressLine? companyPan;
  AddressLine? companyIec;
  AddressLine? cto;
  AddressLine? authorizationUnderHomwRules;
  AddressLine? addressLine1;
  GpsLocationRecycler? gpsLocationRecycler;
  GpsLocationAuditorRequest? gpsLocationAuditor;
  AirPollutionControlDevicesRequest? authorizedPersonAdhar;
  AirPollutionControlDevicesRequest? authorizedPersonPan;
  OtherMachineriesRequest? otherMachineries;
  AirPollutionControlDevicesRequest? lastYearElectricityBill;
  AirPollutionControlDevicesRequest? airPollutionControlDevices;
  AirPollutionControlDevicesRequest? geoTaggedVideoUpload;
  DetailsOfMachinery? detailsOfMachinery;

  GenerralInfoRequest({
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
    this.detailsOfMachinery,
    this.lastYearElectricityBill,
    this.airPollutionControlDevices,
    this.geoTaggedVideoUpload,
  });

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
        "detailsOfMachinery": detailsOfMachinery?.toJson(),
        "lastYearElectricityBill": lastYearElectricityBill?.toJson(),
        "airPollutionControlDevices": airPollutionControlDevices?.toJson(),
        "geoTaggedVideoUpload": geoTaggedVideoUpload?.toJson(),
      };
}

class AddressLine {
  String? auditConfirmedStatus;
  String? auditRemark;

  AddressLine({
    this.auditConfirmedStatus,
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
      };
}

class AirPollutionControlDevicesRequest {
  String? auditConfirmedStatus;
  String? auditRemark;
  String? auditDocument;
  AirPollutionControlDevicesAdditionalDataRequest? additionalData;

  AirPollutionControlDevicesRequest({
    this.auditConfirmedStatus,
    this.auditRemark,
    this.auditDocument,
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
        "audit_document": auditDocument,
        "additional_data": additionalData?.toJson(),
      };
}

class AirPollutionControlDevicesAdditionalDataRequest {
  String? fileKey;
  String? fileLink;

  AirPollutionControlDevicesAdditionalDataRequest({
    this.fileKey,
    this.fileLink,
  });

  Map<String, dynamic> toJson() => {
        "fileKey": fileKey,
        "fileLink": fileLink,
      };
}

class DetailsOfMachinery {
  DetailsOfMachineryAdditionalData? additionalData;

  DetailsOfMachinery({
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
        "additional_data": additionalData?.toJson(),
      };
}

class DetailsOfMachineryAdditionalData {
  Map<String, Machinery>? machinery;

  DetailsOfMachineryAdditionalData({
    this.machinery,
  });

  Map<String, dynamic> toJson() => {
        'machinery':
            machinery?.map((key, value) => MapEntry(key, value.toJson())),
      };
}

class Machinery {
  final String auditConfirmedStatus;
  final String auditRemark;

  Machinery({
    required this.auditConfirmedStatus,
    required this.auditRemark,
  });

  Map<String, dynamic> toJson() {
    return {
      'audit_confirmed_status': auditConfirmedStatus,
      'audit_remark': auditRemark,
    };
  }
}

class GpsLocationAuditorRequest {
  String? auditConfirmedStatus;
  GpsLocationAuditorAdditionalDataRequest? additionalData;
  String? auditRemark;

  GpsLocationAuditorRequest({
    this.auditConfirmedStatus,
    this.additionalData,
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
        "audit_remark": auditRemark,
      };
}

class GpsLocationAuditorAdditionalDataRequest {
  String? lat;
  String? long;

  GpsLocationAuditorAdditionalDataRequest({
    this.lat,
    this.long,
  });

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

class GpsLocationRecycler {
  String? auditConfirmedStatus;

  GpsLocationRecycler({
    this.auditConfirmedStatus,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
      };
}

class OtherMachineriesRequest {
  OtherMachineriesAdditionalDataRequest? additionalData;

  OtherMachineriesRequest({
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
        "additional_data": additionalData?.toJson(),
      };
}

class OtherMachineriesAdditionalDataRequest {
  List<OmRequest>? om;

  OtherMachineriesAdditionalDataRequest({
    this.om,
  });

  Map<String, dynamic> toJson() => {
        "om": om == null ? [] : List<dynamic>.from(om!.map((x) => x.toJson())),
      };
}

class OmRequest {
  String? value;
  String? auditDocument;
  String? fileKey;
  String? fileLink;

  OmRequest({
    this.value,
    this.auditDocument,
    this.fileKey,
    this.fileLink,
  });

  Map<String, dynamic> toJson() => {
        "value": value,
        "audit_document": auditDocument,
        "fileKey": fileKey,
        "fileLink": fileLink,
      };
}
