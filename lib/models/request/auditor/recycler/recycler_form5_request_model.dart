class AuditorRecyclerForm5RequestModel {
  InvoiceAdditionalRequestDataRequest? wasteWaterGenerationAndDisposal;
  String? submit;

  AuditorRecyclerForm5RequestModel({
    this.wasteWaterGenerationAndDisposal,
    this.submit,
  });

  factory AuditorRecyclerForm5RequestModel.fromJson(
          Map<String, dynamic> json) =>
      AuditorRecyclerForm5RequestModel(
        wasteWaterGenerationAndDisposal:
            json["wasteWaterGenerationAndDisposal"] == null
                ? null
                : InvoiceAdditionalRequestDataRequest.fromJson(
                    json["wasteWaterGenerationAndDisposal"]),
        submit: json["submit"],
      );

  Map<String, dynamic> toJson() => {
        "wasteWaterGenerationAndDisposal":
            wasteWaterGenerationAndDisposal?.toJson(),
        "submit": submit,
      };
}

class InvoiceAdditionalRequestDataRequest {
  EtpInstalledRequest? etpInstalled;
  EtpCapacityRequest? etpCapacity;
  SummaryRequest? summary;

  InvoiceAdditionalRequestDataRequest({
    this.etpInstalled,
    this.etpCapacity,
    this.summary,
  });

  factory InvoiceAdditionalRequestDataRequest.fromJson(Map<String, dynamic> json) =>
      InvoiceAdditionalRequestDataRequest(
        etpInstalled: json["etpInstalled"] == null
            ? null
            : EtpInstalledRequest.fromJson(json["etpInstalled"]),
        etpCapacity: json["etpCapacity"] == null
            ? null
            : EtpCapacityRequest.fromJson(json["etpCapacity"]),
        summary:
            json["summary"] == null ? null : SummaryRequest.fromJson(json["summary"]),
      );

  Map<String, dynamic> toJson() => {
        "etpInstalled": etpInstalled?.toJson(),
        "etpCapacity": etpCapacity?.toJson(),
        "summary": summary?.toJson(),
      };
}

class EtpCapacityRequest {
  String? auditConfirmedStatus;
  EtpCapacityAdditionalDataRequest? additionalData;
  dynamic auditRemark;

  EtpCapacityRequest({
    this.auditConfirmedStatus,
    this.additionalData,
    this.auditRemark,
  });

  factory EtpCapacityRequest.fromJson(Map<String, dynamic> json) => EtpCapacityRequest(
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : EtpCapacityAdditionalDataRequest.fromJson(json["additional_data"]),
        auditRemark: json["audit_remark"],
      );

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
        "audit_remark": auditRemark,
      };
}

class EtpCapacityAdditionalDataRequest {
  dynamic capacity;

  EtpCapacityAdditionalDataRequest({
    this.capacity,
  });

  factory EtpCapacityAdditionalDataRequest.fromJson(Map<String, dynamic> json) =>
      EtpCapacityAdditionalDataRequest(
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "capacity": capacity,
      };
}

class EtpInstalledRequest {
  String? auditConfirmedStatus;
  EtpInstalledAdditionalDataRequest? additionalData;
  String? auditRemark;

  EtpInstalledRequest({
    this.auditConfirmedStatus,
    this.additionalData,
    this.auditRemark,
  });

  factory EtpInstalledRequest.fromJson(Map<String, dynamic> json) => EtpInstalledRequest(
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : EtpInstalledAdditionalDataRequest.fromJson(json["additional_data"]),
        auditRemark: json["audit_remark"],
      );

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
        "audit_remark": auditRemark,
      };
}

class EtpInstalledAdditionalDataRequest {
  String? operational;

  EtpInstalledAdditionalDataRequest({
    this.operational,
  });

  factory EtpInstalledAdditionalDataRequest.fromJson(Map<String, dynamic> json) =>
      EtpInstalledAdditionalDataRequest(
        operational: json["operational"],
      );

  Map<String, dynamic> toJson() => {
        "operational": operational,
      };
}

class SummaryRequest {
  String? auditRemark;

  SummaryRequest({
    this.auditRemark,
  });

  factory SummaryRequest.fromJson(Map<String, dynamic> json) => SummaryRequest(
        auditRemark: json["audit_remark"],
      );

  Map<String, dynamic> toJson() => {
        "audit_remark": auditRemark,
      };
}
