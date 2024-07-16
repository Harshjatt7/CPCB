

class AuditorRecyclerForm1RequestModel {
    GeneralInfo? generalInfo;
    String? submit;

    AuditorRecyclerForm1RequestModel({
        this.generalInfo,
        this.submit,
    });

    

    Map<String, dynamic> toJson() => {
        "generalInfo": generalInfo?.toJson(),
        "submit": submit,
    };
}

class GeneralInfo {
    AddressLine1? gstNo;
    AddressLine1? companyPan;
    AddressLine1? companyIec;
    AddressLine1? cto;
    AddressLine1? authorizationUnderHomwRules;
    AddressLine1? addressLine1;
    GpsLocationRecycler? gpsLocationRecycler;
    GpsLocationAuditor? gpsLocationAuditor;
    AirPollutionControlDevices? authorizedPersonAdhar;
    AirPollutionControlDevices? authorizedPersonPan;
    OtherMachineries? otherMachineries;
    AirPollutionControlDevices? lastYearElectricityBill;
    AirPollutionControlDevices? airPollutionControlDevices;
    AirPollutionControlDevices? geoTaggedVideoUpload;

    GeneralInfo({
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
    String? auditConfirmedStatus;
    String? auditRemark;

    AddressLine1({
        this.auditConfirmedStatus,
        this.auditRemark,
    });


    Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
    };
}

class AirPollutionControlDevices {
    String? auditConfirmedStatus;
    String? auditRemark;
    String? auditDocument;
    AirPollutionControlDevicesAdditionalData? additionalData;

    AirPollutionControlDevices({
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

class AirPollutionControlDevicesAdditionalData {
    String? fileKey;
    String? fileLink;

    AirPollutionControlDevicesAdditionalData({
        this.fileKey,
        this.fileLink,
    });

    Map<String, dynamic> toJson() => {
        "fileKey": fileKey,
        "fileLink": fileLink,
    };
}

class GpsLocationAuditor {
    String? auditConfirmedStatus;
    GpsLocationAuditorAdditionalData? additionalData;
    String? auditRemark;

    GpsLocationAuditor({
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

class GpsLocationAuditorAdditionalData {
    String? lat;
    String? long;

    GpsLocationAuditorAdditionalData({
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

class OtherMachineries {
    OtherMachineriesAdditionalData? additionalData;

    OtherMachineries({
        this.additionalData,
    });

    Map<String, dynamic> toJson() => {
        "additional_data": additionalData?.toJson(),
    };
}

class OtherMachineriesAdditionalData {
    List<Om>? om;

    OtherMachineriesAdditionalData({
        this.om,
    });

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

    Map<String, dynamic> toJson() => {
        "value": value,
        "audit_document": auditDocument,
        "fileKey": fileKey,
        "fileLink": fileLink,
    };
}
