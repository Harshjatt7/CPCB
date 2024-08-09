import 'dart:convert';

String recyclerForm3RequestModelToJson(RecyclerForm3RequestModel data) =>
    json.encode(data.toJson());

class RecyclerForm3RequestModel {
  ProcurementInfoRequest? procurementInfo;
  String? submit;
  String? auditPlanId;

  RecyclerForm3RequestModel({
    this.procurementInfo,
    this.submit,
    this.auditPlanId,
  });

  Map<String, dynamic> toJson() => {
        "procurementInfo": procurementInfo?.toJson(),
        "submit": submit,
        "auditPlanId": auditPlanId,
      };
}

class ProcurementInfoRequest {
  ContactedRequest? contacted;
  VerifiedRequest? verified;
  ContactedRequest? physicallyContacted;
  VerifiedRequest? physicallyVerified;

  ProcurementInfoRequest({
    this.contacted,
    this.verified,
    this.physicallyContacted,
    this.physicallyVerified,
  });

  Map<String, dynamic> toJson() => {
        "contacted": contacted?.toJson(),
        "verified": verified?.toJson(),
        "physicallyContacted": physicallyContacted?.toJson(),
        "physicallyVerified": physicallyVerified?.toJson(),
      };
}

class ContactedRequest {
  String? auditConfirmedStatus;
  ContactedRequestAdditionalData? additionalData;
  dynamic auditRemark;

  ContactedRequest({
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

class ContactedRequestAdditionalData {
  num? suppliers;

  ContactedRequestAdditionalData({
    this.suppliers,
  });

  Map<String, dynamic> toJson() => {
        "suppliers": suppliers,
      };
}

class VerifiedRequest {
  String? auditConfirmedStatus;
  PhysicallyVerifiedRequestAdditionalData? additionalData;
  dynamic auditRemark;

  VerifiedRequest({
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

class PhysicallyVerifiedRequestAdditionalData {
  num? suppliers;
  num? suppliersNotVerifiedRequest;

  PhysicallyVerifiedRequestAdditionalData({
    this.suppliers,
    this.suppliersNotVerifiedRequest,
  });

  Map<String, dynamic> toJson() => {
        "suppliers": suppliers,
        "suppliers_not_verified": suppliersNotVerifiedRequest,
      };
}
