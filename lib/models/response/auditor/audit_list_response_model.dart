// To parse this JSON data, do
//
//     final auditPlanListResponseModel = auditPlanListResponseModelFromJson(jsonString);

import 'dart:convert';

AuditPlanListResponseModel auditPlanListResponseModelFromJson(String str) =>
    AuditPlanListResponseModel.fromJson(json.decode(str));

class AuditPlanListResponseModel {
  List<AuditPlanListData>? data;
  int? status;
  Meta? meta;
  Links? links;

  AuditPlanListResponseModel({this.data, this.status, this.meta, this.links});

  factory AuditPlanListResponseModel.fromJson(Map<String, dynamic> json) =>
      AuditPlanListResponseModel(
        data: json["data"] == null
            ? []
            : List<AuditPlanListData>.from(
                json["data"]!.map((x) => AuditPlanListData.fromJson(x))),
        status: json["status"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
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
  String? startDate;
  String? endDate;
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

  factory AuditPlanListData.fromJson(Map<String, dynamic> json) =>
      AuditPlanListData(
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
        endDate: json["end_date"],
        status: json["status"],
        statusPercentage: json["status_percentage"],
        address: json["address"],
        gstin: json["gstin"],
      );
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
