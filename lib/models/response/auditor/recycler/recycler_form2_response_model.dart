// To parse this JSON data, do
//
//     final auditorRecyclerForm2ResponseModel = auditorRecyclerForm2ResponseModelFromJson(jsonString);

import 'dart:convert';

AuditorRecyclerForm2ResponseModel auditorRecyclerForm2ResponseModelFromJson(String str) => AuditorRecyclerForm2ResponseModel.fromJson(json.decode(str));

String auditorRecyclerForm2ResponseModelToJson(AuditorRecyclerForm2ResponseModel data) => json.encode(data.toJson());

class AuditorRecyclerForm2ResponseModel {
    Data? data;

    AuditorRecyclerForm2ResponseModel({
        this.data,
    });

    factory AuditorRecyclerForm2ResponseModel.fromJson(Map<String, dynamic> json) => AuditorRecyclerForm2ResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    String? auditPlanId;
    EndProducts? endProducts;
    int? quantityOfSales;
    ProcessingCapacity? processingCapacity;

    Data({
        this.auditPlanId,
        this.endProducts,
        this.quantityOfSales,
        this.processingCapacity,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        auditPlanId: json["auditPlanId"],
        endProducts: json["endProducts"] == null ? null : EndProducts.fromJson(json["endProducts"]),
        quantityOfSales: json["quantityOfSales"],
        processingCapacity: json["processingCapacity"] == null ? null : ProcessingCapacity.fromJson(json["processingCapacity"]),
    );

    Map<String, dynamic> toJson() => {
        "auditPlanId": auditPlanId,
        "endProducts": endProducts?.toJson(),
        "quantityOfSales": quantityOfSales,
        "processingCapacity": processingCapacity?.toJson(),
    };
}

class EndProducts {
    String? scrumRubber;
    String? crumRubber;
    String? crmb;
    String? recoveredCarbon;
    String? pyrolisisOilBatch;
    String? pyrolisisOilContinuous;

    EndProducts({
        this.scrumRubber,
        this.crumRubber,
        this.crmb,
        this.recoveredCarbon,
        this.pyrolisisOilBatch,
        this.pyrolisisOilContinuous,
    });

    factory EndProducts.fromJson(Map<String, dynamic> json) => EndProducts(
        scrumRubber: json["scrum_rubber"],
        crumRubber: json["crum_rubber"],
        crmb: json["crmb"],
        recoveredCarbon: json["recovered_carbon"],
        pyrolisisOilBatch: json["pyrolisis_oil_batch"],
        pyrolisisOilContinuous: json["pyrolisis_oil_continuous"],
    );

    Map<String, dynamic> toJson() => {
        "scrum_rubber": scrumRubber,
        "crum_rubber": crumRubber,
        "crmb": crmb,
        "recovered_carbon": recoveredCarbon,
        "pyrolisis_oil_batch": pyrolisisOilBatch,
        "pyrolisis_oil_continuous": pyrolisisOilContinuous,
    };
}

class ProcessingCapacity {
    PlanCapacityAssesment? planCapacityAssesment;
    ValueComparable? valueComparable;
    ElectricityVerification? electricityVerification;
    CAndDComparable? cAndDComparable;

    ProcessingCapacity({
        this.planCapacityAssesment,
        this.valueComparable,
        this.electricityVerification,
        this.cAndDComparable,
    });

    factory ProcessingCapacity.fromJson(Map<String, dynamic> json) => ProcessingCapacity(
        planCapacityAssesment: json["planCapacityAssesment"] == null ? null : PlanCapacityAssesment.fromJson(json["planCapacityAssesment"]),
        valueComparable: json["valueComparable"] == null ? null : ValueComparable.fromJson(json["valueComparable"]),
        electricityVerification: json["electricityVerification"] == null ? null : ElectricityVerification.fromJson(json["electricityVerification"]),
        cAndDComparable: json["cAndDComparable"] == null ? null : CAndDComparable.fromJson(json["cAndDComparable"]),
    );

    Map<String, dynamic> toJson() => {
        "planCapacityAssesment": planCapacityAssesment?.toJson(),
        "valueComparable": valueComparable?.toJson(),
        "electricityVerification": electricityVerification?.toJson(),
        "cAndDComparable": cAndDComparable?.toJson(),
    };
}

class CAndDComparable {
    dynamic auditValue;
    dynamic auditDocument;
    String? auditRemark;
    int? auditConfirmedStatus;
    List<dynamic>? additionalData;

    CAndDComparable({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory CAndDComparable.fromJson(Map<String, dynamic> json) => CAndDComparable(
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

class ElectricityVerification {
    dynamic auditValue;
    dynamic auditDocument;
    dynamic auditRemark;
    int? auditConfirmedStatus;
    ElectricityVerificationAdditionalData? additionalData;

    ElectricityVerification({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory ElectricityVerification.fromJson(Map<String, dynamic> json) => ElectricityVerification(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null ? null : ElectricityVerificationAdditionalData.fromJson(json["additional_data"]),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class ElectricityVerificationAdditionalData {
    String? powerOnAuditDay;
    String? totalElectricityConsumption;
    int? annualPowerConsumption;

    ElectricityVerificationAdditionalData({
        this.powerOnAuditDay,
        this.totalElectricityConsumption,
        this.annualPowerConsumption,
    });

    factory ElectricityVerificationAdditionalData.fromJson(Map<String, dynamic> json) => ElectricityVerificationAdditionalData(
        powerOnAuditDay: json["power_on_audit_day"],
        totalElectricityConsumption: json["total_electricity_consumption"],
        annualPowerConsumption: json["annual_power_consumption"],
    );

    Map<String, dynamic> toJson() => {
        "power_on_audit_day": powerOnAuditDay,
        "total_electricity_consumption": totalElectricityConsumption,
        "annual_power_consumption": annualPowerConsumption,
    };
}

class PlanCapacityAssesment {
    dynamic auditValue;
    dynamic auditDocument;
    dynamic auditRemark;
    int? auditConfirmedStatus;
    PlanCapacityAssesmentAdditionalData? additionalData;

    PlanCapacityAssesment({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory PlanCapacityAssesment.fromJson(Map<String, dynamic> json) => PlanCapacityAssesment(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null ? null : PlanCapacityAssesmentAdditionalData.fromJson(json["additional_data"]),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class PlanCapacityAssesmentAdditionalData {
    List<String>? typeOfEndProduct;
    String? plantProductionCapacity;
    String? endProductProducedOnAuditDay;
    String? plantOperationalPerYear;
    String? plantOperationalPerShift;
    String? plantOperationalPerDay;
    int? actualProcessingCapacityDerived;

    PlanCapacityAssesmentAdditionalData({
        this.typeOfEndProduct,
        this.plantProductionCapacity,
        this.endProductProducedOnAuditDay,
        this.plantOperationalPerYear,
        this.plantOperationalPerShift,
        this.plantOperationalPerDay,
        this.actualProcessingCapacityDerived,
    });

    factory PlanCapacityAssesmentAdditionalData.fromJson(Map<String, dynamic> json) => PlanCapacityAssesmentAdditionalData(
        typeOfEndProduct: json["type_of_end_product"] == null ? [] : List<String>.from(json["type_of_end_product"]!.map((x) => x)),
        plantProductionCapacity: json["plant_production_capacity"],
        endProductProducedOnAuditDay: json["end_product_produced_on_audit_day"],
        plantOperationalPerYear: json["plant_operational_per_year"],
        plantOperationalPerShift: json["plant_operational_per_shift"],
        plantOperationalPerDay: json["plant_operational_per_day"],
        actualProcessingCapacityDerived: json["actual_processing_capacity_derived"],
    );

    Map<String, dynamic> toJson() => {
        "type_of_end_product": typeOfEndProduct == null ? [] : List<dynamic>.from(typeOfEndProduct!.map((x) => x)),
        "plant_production_capacity": plantProductionCapacity,
        "end_product_produced_on_audit_day": endProductProducedOnAuditDay,
        "plant_operational_per_year": plantOperationalPerYear,
        "plant_operational_per_shift": plantOperationalPerShift,
        "plant_operational_per_day": plantOperationalPerDay,
        "actual_processing_capacity_derived": actualProcessingCapacityDerived,
    };
}

class ValueComparable {
    dynamic auditValue;
    dynamic auditDocument;
    dynamic auditRemark;
    int? auditConfirmedStatus;
    ValueComparableAdditionalData? additionalData;

    ValueComparable({
        this.auditValue,
        this.auditDocument,
        this.auditRemark,
        this.auditConfirmedStatus,
        this.additionalData,
    });

    factory ValueComparable.fromJson(Map<String, dynamic> json) => ValueComparable(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null ? null : ValueComparableAdditionalData.fromJson(json["additional_data"]),
    );

    Map<String, dynamic> toJson() => {
        "audit_value": auditValue,
        "audit_document": auditDocument,
        "audit_remark": auditRemark,
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
    };
}

class ValueComparableAdditionalData {
    String? actualProcessingCapacity;
    int? differenceInActualProcessing;

    ValueComparableAdditionalData({
        this.actualProcessingCapacity,
        this.differenceInActualProcessing,
    });

    factory ValueComparableAdditionalData.fromJson(Map<String, dynamic> json) => ValueComparableAdditionalData(
        actualProcessingCapacity: json["actual_processing_capacity"],
        differenceInActualProcessing: json["difference_in_actual_processing"],
    );

    Map<String, dynamic> toJson() => {
        "actual_processing_capacity": actualProcessingCapacity,
        "difference_in_actual_processing": differenceInActualProcessing,
    };
}
