import 'dart:convert';

String producerForm1RequestModelToJson(ProducerForm1RequestModel data) =>
    json.encode(data.toJson());

class ProducerForm1RequestModel {
  CompanyDetails? companyDetails;
  String? submit;
  String? auditPlanId;

  ProducerForm1RequestModel({
    this.companyDetails,
    this.submit,
    this.auditPlanId,
  });

  Map<String, dynamic> toJson() => {
        "companyDetails": companyDetails?.toJson(),
        "submit": submit,
        "auditPlanId": auditPlanId,
      };
}

class CompanyDetails {
  CompanyData? companyNameAddress;
  CompanyData? producerCategory;
  CompanyData? companyGst;
  CompanyData? companyPan;
  CompanyData? companyCin;
  CompanyData? companyIec;

  CompanyDetails({
    this.companyNameAddress,
    this.producerCategory,
    this.companyGst,
    this.companyPan,
    this.companyCin,
    this.companyIec,
  });

  Map<String, dynamic> toJson() => {
        "companyNameAddress": companyNameAddress?.toJson(),
        "producerCategory": producerCategory?.toJson(),
        "companyGst": companyGst?.toJson(),
        "companyPan": companyPan?.toJson(),
        "companyCin": companyCin?.toJson(),
        "companyIec": companyIec?.toJson(),
      };
}

class CompanyData {
  String? auditConfirmedStatus;
  String? auditRemark;

  CompanyData({
    this.auditConfirmedStatus,
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
      };
}
