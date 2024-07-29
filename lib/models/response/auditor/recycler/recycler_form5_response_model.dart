class AuditorRecyclerForm5ResponseModel {
  RecyclerForm5Data? data;

  AuditorRecyclerForm5ResponseModel({
    this.data,
  });

  factory AuditorRecyclerForm5ResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AuditorRecyclerForm5ResponseModel(
        data: json["data"] == null
            ? null
            : RecyclerForm5Data.fromJson(json["data"]),
      );
}

class RecyclerForm5Data {
  String? auditPlanId;
  WasteWaterGenerationAndDisposal? wasteWaterGenerationAndDisposal;

  RecyclerForm5Data({
    this.auditPlanId,
    this.wasteWaterGenerationAndDisposal,
  });

  factory RecyclerForm5Data.fromJson(Map<String, dynamic> json) =>
      RecyclerForm5Data(
        auditPlanId: json["auditPlanId"],
        wasteWaterGenerationAndDisposal:
            (json["wasteWaterGenerationAndDisposal"] == null ||
                    (json["wasteWaterGenerationAndDisposal"] != null &&
                        json["wasteWaterGenerationAndDisposal"].length == 0))
                ? null
                : WasteWaterGenerationAndDisposal.fromJson(
                    json["wasteWaterGenerationAndDisposal"]),
      );
}

class WasteWaterGenerationAndDisposal {
  EtpInstalled? etpInstalled;
  EtpCapacity? etpCapacity;
  Summary? summary;

  WasteWaterGenerationAndDisposal({
    this.etpInstalled,
    this.etpCapacity,
    this.summary,
  });

  factory WasteWaterGenerationAndDisposal.fromJson(Map<String, dynamic> json) =>
      WasteWaterGenerationAndDisposal(
        etpInstalled: json["etpInstalled"] == null
            ? null
            : EtpInstalled.fromJson(json["etpInstalled"]),
        etpCapacity: json["etpCapacity"] == null
            ? null
            : EtpCapacity.fromJson(json["etpCapacity"]),
        summary:
            json["summary"] == null ? null : Summary.fromJson(json["summary"]),
      );
}

class EtpCapacity {
  dynamic auditValue;
  dynamic auditDocument;
  dynamic auditRemark;
  int? auditConfirmedStatus;
  EtpCapacityAdditionalData? additionalData;

  EtpCapacity({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory EtpCapacity.fromJson(Map<String, dynamic> json) => EtpCapacity(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : EtpCapacityAdditionalData.fromJson(json["additional_data"]),
      );
}

class EtpCapacityAdditionalData {
  String? capacity;

  EtpCapacityAdditionalData({
    this.capacity,
  });

  factory EtpCapacityAdditionalData.fromJson(Map<String, dynamic> json) =>
      EtpCapacityAdditionalData(
        capacity: json["capacity"],
      );
}

class EtpInstalled {
  dynamic auditValue;
  dynamic auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  EtpInstalledAdditionalData? additionalData;

  EtpInstalled({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory EtpInstalled.fromJson(Map<String, dynamic> json) => EtpInstalled(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : EtpInstalledAdditionalData.fromJson(json["additional_data"]),
      );
}

class EtpInstalledAdditionalData {
  String? operational;

  EtpInstalledAdditionalData({
    this.operational,
  });

  factory EtpInstalledAdditionalData.fromJson(Map<String, dynamic> json) =>
      EtpInstalledAdditionalData(
        operational: json["operational"],
      );
}

class Summary {
  dynamic auditValue;
  dynamic auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  List<dynamic>? additionalData;

  Summary({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? []
            : List<dynamic>.from(json["additional_data"]!.map((x) => x)),
      );
}
