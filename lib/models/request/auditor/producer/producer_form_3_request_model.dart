import 'dart:convert';

String producerForm3RequestModelToJson(ProducerForm3RequestModel data) => json.encode(data.toJson());

class ProducerForm3RequestModel {
    SummaryReport? summaryReport;
    String? submit;

    ProducerForm3RequestModel({
        this.summaryReport,
        this.submit,
    });

    Map<String, dynamic> toJson() => {
        "summaryReport": summaryReport?.toJson(),
        "submit": submit,
    };
}

class SummaryReport {
    MissReportingResponse? missReporting;
    FalseInformationResponse? falseInformation;

    SummaryReport({
        this.missReporting,
        this.falseInformation,
    });

    Map<String, dynamic> toJson() => {
        "missReporting": missReporting?.toJson(),
        "falseInformation": falseInformation?.toJson(),
    };
}

class FalseInformationResponse {
    String? auditConfirmedStatus;
    String? auditRemark;
    FalseInformationAdditionalDataResponse? additionalData;

    FalseInformationResponse({
        this.auditConfirmedStatus,
        this.auditRemark,
        this.additionalData,
    });

    Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
        "additional_data": additionalData?.toJson(),
    };
}

class FalseInformationAdditionalDataResponse {
    String? overallSummary;

    FalseInformationAdditionalDataResponse({
        this.overallSummary,
    });

    Map<String, dynamic> toJson() => {
        "overall_summary": overallSummary,
    };
}

class MissReportingResponse {
    String? auditConfirmedStatus;
    MissReportingAdditionalDataResponse? additionalData;

    MissReportingResponse({
        this.auditConfirmedStatus,
        this.additionalData,
    });

    Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class MissReportingAdditionalDataResponse {
    String? deviationValue;

    MissReportingAdditionalDataResponse({
        this.deviationValue,
    });

    Map<String, dynamic> toJson() => {
        "deviation_value": deviationValue,
    };
}
