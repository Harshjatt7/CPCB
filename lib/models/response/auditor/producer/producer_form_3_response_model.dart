// To parse this JSON data, do
//
//     final producerForm3ResponseModel = producerForm3ResponseModelFromJson(jsonString);

import 'dart:convert';

ProducerForm3ResponseModel producerForm3ResponseModelFromJson(String str) => ProducerForm3ResponseModel.fromJson(json.decode(str));

String producerForm3ResponseModelToJson(ProducerForm3ResponseModel data) => json.encode(data.toJson());

class ProducerForm3ResponseModel {
    String? auditPlanId;
    ProducerForm3Data? auditSummary;

    ProducerForm3ResponseModel({
        this.auditPlanId,
        this.auditSummary,
    });

    factory ProducerForm3ResponseModel.fromJson(Map<String, dynamic> json) => ProducerForm3ResponseModel(
        auditPlanId: json["auditPlanId"],
        auditSummary: json["auditSummary"] == null ? null : ProducerForm3Data.fromJson(json["auditSummary"]),
    );

    Map<String, dynamic> toJson() => {
        "auditPlanId": auditPlanId,
        "auditSummary": auditSummary?.toJson(),
    };
}

class ProducerForm3Data {
    MissReportingResponse? missReporting;
    FalseInformationResponse? falseInformation;

    ProducerForm3Data({
        this.missReporting,
        this.falseInformation,
    });

    factory ProducerForm3Data.fromJson(Map<String, dynamic> json) => ProducerForm3Data(
        missReporting: json["missReporting"] == null ? null : MissReportingResponse.fromJson(json["missReporting"]),
        falseInformation: json["falseInformation"] == null ? null : FalseInformationResponse.fromJson(json["falseInformation"]),
    );

    Map<String, dynamic> toJson() => {
        "missReporting": missReporting?.toJson(),
        "falseInformation": falseInformation?.toJson(),
    };
}

class FalseInformationResponse {
    dynamic auditValue;
    dynamic auditDocument;
    String? auditRemark;
    int? auditConfirmedStatus;
    FalseInformationResponseAdditionalData? additionalData;

    FalseInformationResponse({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory FalseInformationResponse.fromJson(Map<String, dynamic> json) => FalseInformationResponse(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null ? null : FalseInformationResponseAdditionalData.fromJson(json["additional_data"]),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class FalseInformationResponseAdditionalData {
    String? overallSummary;

    FalseInformationResponseAdditionalData({
        this.overallSummary,
    });

    factory FalseInformationResponseAdditionalData.fromJson(Map<String, dynamic> json) => FalseInformationResponseAdditionalData(
        overallSummary: json["overall_summary"],
    );

    Map<String, dynamic> toJson() => {
        "overall_summary": overallSummary,
    };
}

class MissReportingResponse {
    dynamic auditValue;
    dynamic auditDocument;
    dynamic auditRemark;
    int? auditConfirmedStatus;
    MissReportingResponseAdditionalData? additionalData;

    MissReportingResponse({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory MissReportingResponse.fromJson(Map<String, dynamic> json) => MissReportingResponse(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null ? null : MissReportingResponseAdditionalData.fromJson(json["additional_data"]),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class MissReportingResponseAdditionalData {
    String? deviationValue;

    MissReportingResponseAdditionalData({
        this.deviationValue,
    });

    factory MissReportingResponseAdditionalData.fromJson(Map<String, dynamic> json) => MissReportingResponseAdditionalData(
        deviationValue: json["deviation_value"],
    );

    Map<String, dynamic> toJson() => {
        "deviation_value": deviationValue,
    };
}
