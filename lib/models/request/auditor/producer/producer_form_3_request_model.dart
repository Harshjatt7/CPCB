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
    MissReporting? missReporting;
    FalseInformation? falseInformation;

    SummaryReport({
        this.missReporting,
        this.falseInformation,
    });

    Map<String, dynamic> toJson() => {
        "missReporting": missReporting?.toJson(),
        "falseInformation": falseInformation?.toJson(),
    };
}

class FalseInformation {
    String? auditConfirmedStatus;
    String? auditRemark;
    FalseInformationAdditionalData? additionalData;

    FalseInformation({
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

class FalseInformationAdditionalData {
    String? overallSummary;

    FalseInformationAdditionalData({
        this.overallSummary,
    });

    Map<String, dynamic> toJson() => {
        "overall_summary": overallSummary,
    };
}

class MissReporting {
    String? auditConfirmedStatus;
    MissReportingAdditionalData? additionalData;

    MissReporting({
        this.auditConfirmedStatus,
        this.additionalData,
    });

    Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class MissReportingAdditionalData {
    String? deviationValue;

    MissReportingAdditionalData({
        this.deviationValue,
    });

    Map<String, dynamic> toJson() => {
        "deviation_value": deviationValue,
    };
}
