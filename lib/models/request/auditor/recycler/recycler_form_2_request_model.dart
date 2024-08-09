import 'dart:convert';

String recyclerForm2RequestModelToJson(RecyclerForm2RequestModel data) =>
    json.encode(data.toJson());

class RecyclerForm2RequestModel {
  ProcessingCapacityRequest? processingCapacity;
  String? submit;
  String? auditPlanId;

  RecyclerForm2RequestModel({
    this.processingCapacity,
    this.submit,
    this.auditPlanId,
  });

  Map<String, dynamic> toJson() => {
        "processingCapacity": processingCapacity?.toJson(),
        "submit": submit,
        "auditPlanId": auditPlanId,
      };
}

class ProcessingCapacityRequest {
  PlanCapacityAssesmentRequest? planCapacityAssesment;
  ValueComparableRequest? valueComparable;
  ElectricityVerificationRequest? electricityVerification;
  CAndDComparableRequest? cAndDComparable;

  ProcessingCapacityRequest({
    this.planCapacityAssesment,
    this.valueComparable,
    this.electricityVerification,
    this.cAndDComparable,
  });

  Map<String, dynamic> toJson() => {
        "planCapacityAssesment": planCapacityAssesment?.toJson(),
        "valueComparable": valueComparable?.toJson(),
        "electricityVerification": electricityVerification?.toJson(),
        "cAndDComparable": cAndDComparable?.toJson(),
      };
}

class CAndDComparableRequest {
  String? auditConfirmedStatus;
  String? auditRemark;

  CAndDComparableRequest({
    this.auditConfirmedStatus,
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
      };
}

class ElectricityVerificationRequest {
  ElectricityVerificationRequestAdditionalData? additionalData;

  ElectricityVerificationRequest({
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
        "additional_data": additionalData?.toJson(),
      };
}

class ElectricityVerificationRequestAdditionalData {
  String? powerOnAuditDay;
  String? totalElectricityConsumption;
  num? annualPowerConsumption;

  ElectricityVerificationRequestAdditionalData({
    this.powerOnAuditDay,
    this.totalElectricityConsumption,
    this.annualPowerConsumption,
  });

  Map<String, dynamic> toJson() => {
        "power_on_audit_day": powerOnAuditDay,
        "total_electricity_consumption": totalElectricityConsumption,
        "annual_power_consumption": annualPowerConsumption,
      };
}

class PlanCapacityAssesmentRequest {
  PlanCapacityAssesmentRequestAdditionalData? additionalData;

  PlanCapacityAssesmentRequest({
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
        "additional_data": additionalData?.toJson(),
      };
}

class PlanCapacityAssesmentRequestAdditionalData {
  List<String>? typeOfEndProduct;
  String? plantProductionCapacity;
  String? endProductProducedOnAuditDay;
  String? plantOperationalPerYear;
  String? plantOperationalPerShift;
  String? plantOperationalPerDay;
  num? actualProcessingCapacityRequestDerived;

  PlanCapacityAssesmentRequestAdditionalData({
    this.typeOfEndProduct,
    this.plantProductionCapacity,
    this.endProductProducedOnAuditDay,
    this.plantOperationalPerYear,
    this.plantOperationalPerShift,
    this.plantOperationalPerDay,
    this.actualProcessingCapacityRequestDerived,
  });

  Map<String, dynamic> toJson() => {
        "type_of_end_product": typeOfEndProduct == null
            ? []
            : List<dynamic>.from(typeOfEndProduct!.map((x) => x)),
        "plant_production_capacity": plantProductionCapacity,
        "end_product_produced_on_audit_day": endProductProducedOnAuditDay,
        "plant_operational_per_year": plantOperationalPerYear,
        "plant_operational_per_shift": plantOperationalPerShift,
        "plant_operational_per_day": plantOperationalPerDay,
        "actual_processing_capacity_derived":
            actualProcessingCapacityRequestDerived,
      };
}

class ValueComparableRequest {
  String? auditConfirmedStatus;
  ValueComparableRequestAdditionalData? additionalData;

  ValueComparableRequest({
    this.auditConfirmedStatus,
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
      };
}

class ValueComparableRequestAdditionalData {
  String? actualProcessingCapacityRequest;
  num? differenceInActualProcessing;

  ValueComparableRequestAdditionalData({
    this.actualProcessingCapacityRequest,
    this.differenceInActualProcessing,
  });

  factory ValueComparableRequestAdditionalData.fromJson(
          Map<String, dynamic> json) =>
      ValueComparableRequestAdditionalData(
        actualProcessingCapacityRequest: json["actual_processing_capacity"],
        differenceInActualProcessing: json["difference_in_actual_processing"],
      );

  Map<String, dynamic> toJson() => {
        "actual_processing_capacity": actualProcessingCapacityRequest,
        "difference_in_actual_processing": differenceInActualProcessing,
      };
}
