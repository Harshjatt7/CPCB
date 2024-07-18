
class AuditorRecyclerForm2RequestModel {
  ProcessingCapacity? processingCapacity;
  String? submit;

  AuditorRecyclerForm2RequestModel({
    this.processingCapacity,
    this.submit,
  });

  Map<String, dynamic> toJson() => {
        "processingCapacity": processingCapacity?.toJson(),
        "submit": submit,
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

  Map<String, dynamic> toJson() => {
        "planCapacityAssesment": planCapacityAssesment?.toJson(),
        "valueComparable": valueComparable?.toJson(),
        "electricityVerification": electricityVerification?.toJson(),
        "cAndDComparable": cAndDComparable?.toJson(),
      };
}

class CAndDComparable {
  String? auditConfirmedStatus;
  String? auditRemark;

  CAndDComparable({
    this.auditConfirmedStatus,
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
      };
}

class ElectricityVerification {
  ElectricityVerificationAdditionalData? additionalData;

  ElectricityVerification({
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
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

  Map<String, dynamic> toJson() => {
        "power_on_audit_day": powerOnAuditDay,
        "total_electricity_consumption": totalElectricityConsumption,
        "annual_power_consumption": annualPowerConsumption,
      };
}

class PlanCapacityAssesment {
  PlanCapacityAssesmentAdditionalData? additionalData;

  PlanCapacityAssesment({
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
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

  Map<String, dynamic> toJson() => {
        "type_of_end_product": typeOfEndProduct == null
            ? []
            : List<dynamic>.from(typeOfEndProduct!.map((x) => x)),
        "plant_production_capacity": plantProductionCapacity,
        "end_product_produced_on_audit_day": endProductProducedOnAuditDay,
        "plant_operational_per_year": plantOperationalPerYear,
        "plant_operational_per_shift": plantOperationalPerShift,
        "plant_operational_per_day": plantOperationalPerDay,
        "actual_processing_capacity_derived": actualProcessingCapacityDerived,
      };
}

class ValueComparable {
  String? auditConfirmedStatus;
  ValueComparableAdditionalData? additionalData;

  ValueComparable({
    this.auditConfirmedStatus,
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
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

  Map<String, dynamic> toJson() => {
        "actual_processing_capacity": actualProcessingCapacity,
        "difference_in_actual_processing": differenceInActualProcessing,
      };
}

