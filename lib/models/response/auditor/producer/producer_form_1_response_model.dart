import 'dart:convert';

ProducerForm1ResponseModel producerForm1ResponseModelFromJson(String str) =>
    ProducerForm1ResponseModel.fromJson(json.decode(str));

class ProducerForm1ResponseModel {
  ProducerForm1ProducerForm1Data? data;

  ProducerForm1ResponseModel({
    this.data,
  });

  factory ProducerForm1ResponseModel.fromJson(Map<String, dynamic> json) =>
      ProducerForm1ResponseModel(
        data: json["data"] == null
            ? null
            : ProducerForm1ProducerForm1Data.fromJson(json["data"]),
      );
}

class ProducerForm1ProducerForm1Data {
  String? auditPlanId;
  CompanyDetailsResponse? companyDetails;
  AuditSummary? auditSummary;

  ProducerForm1ProducerForm1Data({
    this.auditPlanId,
    this.companyDetails,
    this.auditSummary,
  });

  factory ProducerForm1ProducerForm1Data.fromJson(Map<String, dynamic> json) =>
      ProducerForm1ProducerForm1Data(
        auditPlanId: json["auditPlanId"],
        companyDetails: json["companyDetails"] == null
            ? null
            : CompanyDetailsResponse.fromJson(json["companyDetails"]),
        auditSummary: (json["auditSummary"] == null ||
                (json["auditSummary"] != null &&
                    json["auditSummary"].length == 0))
            ? null
            : AuditSummary.fromJson(json["auditSummary"]),
      );
}

class AuditSummary {
  CompanyCin? companyNameAddress;
  CompanyCin? producerCategory;
  CompanyCin? companyGst;
  CompanyCin? companyPan;
  CompanyCin? companyCin;
  CompanyCin? companyIec;

  AuditSummary({
    this.companyNameAddress,
    this.producerCategory,
    this.companyGst,
    this.companyPan,
    this.companyCin,
    this.companyIec,
  });

  factory AuditSummary.fromJson(Map<String, dynamic> json) => AuditSummary(
        companyNameAddress: json["companyNameAddress"] == null
            ? null
            : CompanyCin.fromJson(json["companyNameAddress"]),
        producerCategory: json["producerCategory"] == null
            ? null
            : CompanyCin.fromJson(json["producerCategory"]),
        companyGst: json["companyGst"] == null
            ? null
            : CompanyCin.fromJson(json["companyGst"]),
        companyPan: json["companyPan"] == null
            ? null
            : CompanyCin.fromJson(json["companyPan"]),
        companyCin: json["companyCin"] == null
            ? null
            : CompanyCin.fromJson(json["companyCin"]),
        companyIec: json["companyIec"] == null
            ? null
            : CompanyCin.fromJson(json["companyIec"]),
      );
}

class CompanyCin {
  dynamic auditValue;
  dynamic auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  List<dynamic>? additionalProducerForm1ProducerForm1Data;

  CompanyCin({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalProducerForm1ProducerForm1Data,
  });

  factory CompanyCin.fromJson(Map<String, dynamic> json) => CompanyCin(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalProducerForm1ProducerForm1Data:
            json["additional_data"] == null
                ? []
                : List<dynamic>.from(json["additional_data"]!.map((x) => x)),
      );
}

class CompanyDetailsResponse {
  String? companyNameAndAddress;
  String? categoryOfProducer;
  String? gstNo;
  String? gstFilePath;
  String? panOfCompany;
  String? panFilePath;
  String? cinNo;
  String? cinFilePath;
  String? iec;
  String? iecFilePath;
  String? gstFileName;
  String? panFileName;
  String? cinFileName;
  String? iecFileName;
  String? gstApiFilePath;
  String? panApiFilePath;
  String? cinApiFilePath;
  String? iecApiFilePath;

  CompanyDetailsResponse({
    this.companyNameAndAddress,
    this.categoryOfProducer,
    this.gstNo,
    this.gstFilePath,
    this.panOfCompany,
    this.panFilePath,
    this.cinNo,
    this.cinFilePath,
    this.iec,
    this.iecFilePath,
    this.gstFileName,
    this.panFileName,
    this.cinFileName,
    this.iecFileName,
    this.gstApiFilePath,
    this.panApiFilePath,
    this.cinApiFilePath,
    this.iecApiFilePath,
  });

  factory CompanyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsResponse(
        companyNameAndAddress: json["companyNameAndAddress"],
        categoryOfProducer: json["categoryOfProducer"],
        gstNo: json["gstNo"],
        gstFilePath: json["gstFilePath"],
        panOfCompany: json["panOfCompany"],
        panFilePath: json["panFilePath"],
        cinNo: json["cinNo"],
        cinFilePath: json["cinFilePath"],
        iec: json["iec"],
        iecFilePath: json["iecFilePath"],
        gstFileName: json["gstFileName"],
        panFileName: json["panFileName"],
        cinFileName: json["cinFileName"],
        iecFileName: json["iecFileName"],
        gstApiFilePath: json["gstApiFilePath"],
        panApiFilePath: json["panApiFilePath"],
        cinApiFilePath: json["cinApiFilePath"],
        iecApiFilePath: json["iecApiFilePath"],
      );
}
