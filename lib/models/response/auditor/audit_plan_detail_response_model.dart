import 'dart:convert';

AuditPlanDetailResponseModel auditPlanDetailResponseModelFromJson(String str) => AuditPlanDetailResponseModel.fromJson(json.decode(str));

class AuditPlanDetailResponseModel {
    List<AuditPlanDetailData>? data;

    AuditPlanDetailResponseModel({
        this.data,
    });

    factory AuditPlanDetailResponseModel.fromJson(Map<String, dynamic> json) => AuditPlanDetailResponseModel(
        data: json["data"] == null ? [] : List<AuditPlanDetailData>.from(json["data"]!.map((x) => AuditPlanDetailData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AuditPlanDetailData {
    String? id;
    String? unitName;
    String? regNum;
    int? type;
    String? legalName;
    String? district;
    String? state;
    String? quarter;
    String? financialYear;
    DateTime? startDate;
    DateTime? endDate;
    String? status;
    int? statusPercentage;
    String? address;
    String? gstin;
    RouteData? routeData;

    AuditPlanDetailData({
        this.id,
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
        this.routeData,
    });

    factory AuditPlanDetailData.fromJson(Map<String, dynamic> json) => AuditPlanDetailData(
        id: json["id"],
        unitName: json["unit_name"],
        regNum: json["reg_num"],
        type: json["type"],
        legalName: json["legal_name"],
        district: json["district"],
        state: json["state"],
        quarter: json["quarter"],
        financialYear: json["financial_year"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        statusPercentage: json["status_percentage"],
        address: json["address"],
        gstin: json["gstin"],
        routeData: json["routeData"] == null ? null : RouteData.fromJson(json["routeData"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "unit_name": unitName,
        "reg_num": regNum,
        "type": type,
        "legal_name": legalName,
        "district": district,
        "state": state,
        "quarter": quarter,
        "financial_year": financialYear,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "status_percentage": statusPercentage,
        "address": address,
        "gstin": gstin,
        "routeData": routeData?.toJson(),
    };
}

class RouteData {
    String? name;
    String? routeDataClass;
    String? link;
    String? api;

    RouteData({
        this.name,
        this.routeDataClass,
        this.link,
        this.api,
    });

    factory RouteData.fromJson(Map<String, dynamic> json) => RouteData(
        name: json["name"],
        routeDataClass: json["class"],
        link: json["link"],
        api: json["api"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "class": routeDataClass,
        "link": link,
        "api": api,
    };
}
