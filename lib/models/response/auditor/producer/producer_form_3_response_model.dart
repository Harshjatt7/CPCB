// To parse this JSON data, do
//
//     final producerForm3ResponseModel = producerForm3ResponseModelFromJson(jsonString);

import 'dart:convert';

ProducerForm3ResponseModel producerForm3ResponseModelFromJson(String str) => ProducerForm3ResponseModel.fromJson(json.decode(str));

String producerForm3ResponseModelToJson(ProducerForm3ResponseModel data) => json.encode(data.toJson());

class ProducerForm3ResponseModel {
    ProducerForm3Data? data;

    ProducerForm3ResponseModel({
        this.data,
    });

    factory ProducerForm3ResponseModel.fromJson(Map<String, dynamic> json) => ProducerForm3ResponseModel(
        data: json["data"] == null ? null : ProducerForm3Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class ProducerForm3Data {
    String? auditPlanId;
    ProducerForm3AuditSummary? auditSummary;

    ProducerForm3Data({
        this.auditPlanId,
        this.auditSummary,
    });

    factory ProducerForm3Data.fromJson(Map<String, dynamic> json) => ProducerForm3Data(
        auditPlanId: json["auditPlanId"],
        auditSummary: json["auditSummary"] == null ? null : ProducerForm3AuditSummary.fromJson(json["auditSummary"]),
    );

    Map<String, dynamic> toJson() => {
        "auditPlanId": auditPlanId,
        "auditSummary": auditSummary?.toJson(),
    };
}

class ProducerForm3AuditSummary {
    MissReporting? missReporting;
    FalseInformation? falseInformation;

    ProducerForm3AuditSummary({
        this.missReporting,
        this.falseInformation,
    });

    factory ProducerForm3AuditSummary.fromJson(Map<String, dynamic> json) => ProducerForm3AuditSummary(
        missReporting: json["missReporting"] == null ? null : MissReporting.fromJson(json["missReporting"]),
        falseInformation: json["falseInformation"] == null ? null : FalseInformation.fromJson(json["falseInformation"]),
    );

    Map<String, dynamic> toJson() => {
        "missReporting": missReporting?.toJson(),
        "falseInformation": falseInformation?.toJson(),
    };
}

class FalseInformation {
    dynamic auditValue;
    dynamic auditDocument;
    String? auditRemark;
    int? auditConfirmedStatus;
    FalseInformationAdditionalData? additionalData;

    FalseInformation({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory FalseInformation.fromJson(Map<String, dynamic> json) => FalseInformation(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null ? null : FalseInformationAdditionalData.fromJson(json["additional_data"]),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class FalseInformationAdditionalData {
    String? overallSummary;

    FalseInformationAdditionalData({
        this.overallSummary,
    });

    factory FalseInformationAdditionalData.fromJson(Map<String, dynamic> json) => FalseInformationAdditionalData(
        overallSummary: json["overall_summary"],
    );

    Map<String, dynamic> toJson() => {
        "overall_summary": overallSummary,
    };
}

class MissReporting {
    dynamic auditValue;
    dynamic auditDocument;
    dynamic auditRemark;
    int? auditConfirmedStatus;
    MissReportingAdditionalData? additionalData;

    MissReporting({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory MissReporting.fromJson(Map<String, dynamic> json) => MissReporting(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null ? null : MissReportingAdditionalData.fromJson(json["additional_data"]),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class MissReportingAdditionalData {
    String? deviationValue;

    MissReportingAdditionalData({
        this.deviationValue,
    });

    factory MissReportingAdditionalData.fromJson(Map<String, dynamic> json) => MissReportingAdditionalData(
        deviationValue: json["deviation_value"],
    );

    Map<String, dynamic> toJson() => {
        "deviation_value": deviationValue,
    };
}
