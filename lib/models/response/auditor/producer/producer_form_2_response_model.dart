// To parse this JSON data, do
//
//     final producerForm2ResponseModel = producerForm2ResponseModelFromJson(jsonString);

import 'dart:convert';

ProducerForm2ResponseModel producerForm2ResponseModelFromJson(String str) => ProducerForm2ResponseModel.fromJson(json.decode(str));

String producerForm2ResponseModelToJson(ProducerForm2ResponseModel data) => json.encode(data.toJson());

class ProducerForm2ResponseModel {
    ProducerForm2ResponseData? data;

    ProducerForm2ResponseModel({
        this.data,
    });

    factory ProducerForm2ResponseModel.fromJson(Map<String, dynamic> json) => ProducerForm2ResponseModel(
        data: json["data"] == null ? null : ProducerForm2ResponseData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class ProducerForm2ResponseData {
    String? auditPlanId;
    ProducerForm2SalesData? salesData;
    AuditSummaryForm2Response? auditSummary;

    ProducerForm2ResponseData({
        this.auditPlanId,
        this.salesData,
        this.auditSummary,
    });

    factory ProducerForm2ResponseData.fromJson(Map<String, dynamic> json) => ProducerForm2ResponseData(
        auditPlanId: json["auditPlanId"],
        salesData: json["salesData"] == null ? null : ProducerForm2SalesData.fromJson(json["salesData"]),
        auditSummary: json["auditSummary"] == null ? null : AuditSummaryForm2Response.fromJson(json["auditSummary"]),
    );

    Map<String, dynamic> toJson() => {
        "auditPlanId": auditPlanId,
        "salesData": salesData?.toJson(),
        "auditSummary": auditSummary?.toJson(),
    };
}

class AuditSummaryForm2Response {
    SalesP? salesP2;
    SalesP? salesP1;
    SalesP? salesP3;
    SalesP? salesP4;
    SalesP? salesP5;
    SalesP? salesP6;

    AuditSummaryForm2Response({
        this.salesP2,
        this.salesP1,
        this.salesP3,
        this.salesP4,
        this.salesP5,
        this.salesP6,
    });

    factory AuditSummaryForm2Response.fromJson(Map<String, dynamic> json) => AuditSummaryForm2Response(
        salesP2: json["salesP2"] == null ? null : SalesP.fromJson(json["salesP2"]),
        salesP1: json["salesP1"] == null ? null : SalesP.fromJson(json["salesP1"]),
        salesP3: json["salesP3"] == null ? null : SalesP.fromJson(json["salesP3"]),
        salesP4: json["salesP4"] == null ? null : SalesP.fromJson(json["salesP4"]),
        salesP5: json["salesP5"] == null ? null : SalesP.fromJson(json["salesP5"]),
        salesP6: json["salesP6"] == null ? null : SalesP.fromJson(json["salesP6"]),
    );

    Map<String, dynamic> toJson() => {
        "salesP2": salesP2?.toJson(),
        "salesP1": salesP1?.toJson(),
        "salesP3": salesP3?.toJson(),
        "salesP4": salesP4?.toJson(),
        "salesP5": salesP5?.toJson(),
        "salesP6": salesP6?.toJson(),
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
        additionalData: json["additional_data"] == null ? [] : List<dynamic>.from(json["additional_data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData == null ? [] : List<dynamic>.from(additionalData!.map((x) => x)),
    };
}

class ProducerForm2SalesData {
    List<Producer>? p1;
    List<Producer>? p2;
    List<Producer>? p3;
    List<Producer>? p4;
    List<Producer>? p5;
    List<Producer>? p6;

    ProducerForm2SalesData({
        this.p1,
        this.p2,
        this.p3,
        this.p4,
        this.p5,
        this.p6,
    });

    factory ProducerForm2SalesData.fromJson(Map<String, dynamic> json) => ProducerForm2SalesData(
        p1: json["p1"] == null ? [] : List<Producer>.from(json["p1"]!.map((x) => Producer.fromJson(x))),
        p2: json["p2"] == null ? [] : List<Producer>.from(json["p2"]!.map((x) => Producer.fromJson(x))),
        p3: json["p3"] == null ? [] : List<Producer>.from(json["p3"]!.map((x) => Producer.fromJson(x))),
        p4: json["p4"] == null ? [] : List<Producer>.from(json["p4"]!.map((x) => Producer.fromJson(x))),
        p5: json["p5"] == null ? [] : List<Producer>.from(json["p5"]!.map((x) => Producer.fromJson(x))),
        p6: json["p6"] == null ? [] : List<Producer>.from(json["p6"]!.map((x) => Producer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "p1": p1 == null ? [] : List<dynamic>.from(p1!.map((x) => x)),
        "p2": p2 == null ? [] : List<dynamic>.from(p2!.map((x) => x.toJson())),
        "p3": p3 == null ? [] : List<dynamic>.from(p3!.map((x) => x)),
        "p4": p4 == null ? [] : List<dynamic>.from(p4!.map((x) => x)),
        "p5": p5 == null ? [] : List<dynamic>.from(p5!.map((x) => x)),
        "p6": p6 == null ? [] : List<dynamic>.from(p6!.map((x) => x)),
    };
}

class Producer {
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

    Producer({
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

    factory Producer.fromJson(Map<String, dynamic> json) => Producer(
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

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type_of_tyre_manufacture": typeOfTyreManufacture,
        "financial_year": financialYear,
        "month": month,
        "motor_cycle": motorCycle,
        "passenger_car": passengerCar,
        "scooter": scooter,
        "truck": truck,
        "bus": bus,
        "lcv": lcv,
        "t_rear": tRear,
        "otr": otr,
        "other": other,
        "total": total,
        "select_status": selectStatus,
        "role_id": roleId,
        "ApplicationStatus": applicationStatus,
        "status": status,
        "app_id": appId,
        "totalGST": totalGst,
    };
}
