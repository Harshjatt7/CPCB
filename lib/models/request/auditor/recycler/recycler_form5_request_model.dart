class AuditorRecyclerForm5RequestModel {
  InvoiceAdditionalRequestDataRequest? wasteWaterGenerationAndDisposal;
  String? submit;
  String? auditPlanId;

  AuditorRecyclerForm5RequestModel({
    this.wasteWaterGenerationAndDisposal,
    this.submit,
    this.auditPlanId,
  });

  Map<String, dynamic> toJson() => {
        "wasteWaterGenerationAndDisposal":
            wasteWaterGenerationAndDisposal?.toJson(),
        "submit": submit,
        "auditPlanId": auditPlanId,
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

  Map<String, dynamic> toJson() => {
        "operational": operational,
      };
}

class SummaryRequest {
  String? auditRemark;

  SummaryRequest({
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_remark": auditRemark,
      };
}
