import 'dart:convert';

AuditPlanListResponseModel auditPlanListResponseModelFromJson(String str) => AuditPlanListResponseModel.fromJson(json.decode(str));

class AuditPlanListResponseModel {
    List<AuditPlanListData>? data;

    AuditPlanListResponseModel({
        this.data,
    });

    factory AuditPlanListResponseModel.fromJson(Map<String, dynamic> json) => AuditPlanListResponseModel(
        data: json["data"] == null ? [] : List<AuditPlanListData>.from(json["data"]!.map((x) => AuditPlanListData.fromJson(x))),
    );

}

class AuditPlanListData {
    String? id;
    int? userId;
    String? unitName;
    String? regNum;
    int? type;
    String? legalName;
    String? district;
    String? state;
    String? quarter;
    String? financialYear;
    dynamic startDate;
    DateTime? endDate;
    String? status;
    int? statusPercentage;
    String? address;
    String? gstin;

    AuditPlanListData({
        this.id,
        this.userId,
        this.unitName,
        this.regNum,
        this.type,
        this.legalName,
        this.district,
        this.state,
        this.quarter,
        this.financialYear,
        this.startDate,
        this.endDate,
        this.status,
        this.statusPercentage,
        this.address,
        this.gstin,
    });

    factory AuditPlanListData.fromJson(Map<String, dynamic> json) => AuditPlanListData(
        id: json["id"],
        userId: json["user_id"],
        unitName: json["unit_name"],
        regNum: json["reg_num"],
        type: json["type"],
        legalName: json["legal_name"],
        district: json["district"],
        state: json["state"],
        quarter: json["quarter"],
        financialYear: json["financial_year"],
        startDate: json["start_date"],
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        statusPercentage: json["status_percentage"],
        address: json["address"],
        gstin: json["gstin"],
    );

}
