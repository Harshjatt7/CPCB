import 'dart:convert';

ProducerForm2ResponseModel producerForm2ResponseModelFromJson(String str) =>
    ProducerForm2ResponseModel.fromJson(json.decode(str));

class ProducerForm2ResponseModel {
  ProducerForm2Data? data;
  AuditSummary? auditSummary;

  ProducerForm2ResponseModel({this.data, this.auditSummary});

  factory ProducerForm2ResponseModel.fromJson(Map<String, dynamic> json) =>
      ProducerForm2ResponseModel(
        data: json["data"] == null
            ? null
            : ProducerForm2Data.fromJson(json["data"]),
        auditSummary: json["auditSummary"] == null
            ? null
            : AuditSummary.fromJson(json["auditSummary"]),
      );
}

class ProducerForm2Data {
  String? auditPlanId;
  ProducerSalesData? salesData;

  ProducerForm2Data({
    this.auditPlanId,
    this.salesData,
  });

  factory ProducerForm2Data.fromJson(Map<String, dynamic> json) =>
      ProducerForm2Data(
        auditPlanId: json["auditPlanId"],
        salesData: json["salesData"] == null
            ? null
            : ProducerSalesData.fromJson(json["salesData"]),
      );
}

class AuditSummary {
  SalesP? salesP2;
  SalesP? salesP1;

  AuditSummary({
    this.salesP2,
    this.salesP1,
  });

  factory AuditSummary.fromJson(Map<String, dynamic> json) => AuditSummary(
        salesP2:
            json["salesP2"] == null ? null : SalesP.fromJson(json["salesP2"]),
        salesP1:
            json["salesP1"] == null ? null : SalesP.fromJson(json["salesP1"]),
      );

  Map<String, dynamic> toJson() => {
        "salesP2": salesP2?.toJson(),
        "salesP1": salesP1?.toJson(),
      };
}

class SalesP {
  dynamic auditValue;
  dynamic auditDocument;
  dynamic auditRemark;
  int? auditConfirmedStatus;
  List<dynamic>? additionalData;

  SalesP({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory SalesP.fromJson(Map<String, dynamic> json) => SalesP(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? []
            : List<dynamic>.from(json["additional_data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData == null
            ? []
            : List<dynamic>.from(additionalData!.map((x) => x)),
      };
}

class ProducerSalesData {
  List<Producers>? p1;
  List<Producers>? p2;
  List<Producers>? p3;
  List<Producers>? p4;
  List<Producers>? p5;
  List<Producers>? p6;

  ProducerSalesData({
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.p6,
  });

  factory ProducerSalesData.fromJson(Map<String, dynamic> json) =>
      ProducerSalesData(
        p1: json["p1"] == null
            ? []
            : List<Producers>.from(
                json["p1"]!.map((x) => Producers.fromJson(x))),
        p2: json["p2"] == null
            ? []
            : List<Producers>.from(
                json["p2"]!.map((x) => Producers.fromJson(x))),
        p3: json["p3"] == null
            ? []
            : List<Producers>.from(
                json["p3"]!.map((x) => Producers.fromJson(x))),
        p4: json["p4"] == null
            ? []
            : List<Producers>.from(
                json["p4"]!.map((x) => Producers.fromJson(x))),
        p5: json["p5"] == null
            ? []
            : List<Producers>.from(
                json["p5"]!.map((x) => Producers.fromJson(x))),
        p6: json["p6"] == null
            ? []
            : List<Producers>.from(
                json["p6"]!.map((x) => Producers.fromJson(x))),
      );
}

class Producers {
  int? id;
  String? userId;
  String? typeOfTyreManufacture;
  String? financialYear;
  int? month;
  String? motorCycle;
  String? passengerCar;
  String? scooter;
  String? truck;
  String? bus;
  String? lcv;
  String? tRear;
  String? otr;
  String? other;
  String? total;
  String? selectStatus;
  int? roleId;
  int? applicationStatus;
  int? status;
  int? appId;
  int? totalGst;

  Producers({
    this.id,
    this.userId,
    this.typeOfTyreManufacture,
    this.financialYear,
    this.month,
    this.motorCycle,
    this.passengerCar,
    this.scooter,
    this.truck,
    this.bus,
    this.lcv,
    this.tRear,
    this.otr,
    this.other,
    this.total,
    this.selectStatus,
    this.roleId,
    this.applicationStatus,
    this.status,
    this.appId,
    this.totalGst,
  });

  factory Producers.fromJson(Map<String, dynamic> json) => Producers(
        id: json["id"],
        userId: json["user_id"],
        typeOfTyreManufacture: json["type_of_tyre_manufacture"],
        financialYear: json["financial_year"],
        month: json["month"],
        motorCycle: json["motor_cycle"],
        passengerCar: json["passenger_car"],
        scooter: json["scooter"],
        truck: json["truck"],
        bus: json["bus"],
        lcv: json["lcv"],
        tRear: json["t_rear"],
        otr: json["otr"],
        other: json["other"],
        total: json["total"],
        selectStatus: json["select_status"],
        roleId: json["role_id"],
        applicationStatus: json["ApplicationStatus"],
        status: json["status"],
        appId: json["app_id"],
        totalGst: json["totalGST"],
      );
}
