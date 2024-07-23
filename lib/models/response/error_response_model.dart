// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) =>
    ErrorResponseModel.fromJson(json.decode(str));

class ErrorResponseModel {
  String? message;
  Error? errorResponse;
  ErrorsList? errorsList;

  ErrorResponseModel({
    this.message,
    this.errorResponse,
    this.errorsList,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        message: json["message"],
        errorResponse:
            json["error"] == null ? null : Error.fromJson(json["error"]),
        errorsList:
            json["errors"] == null ? null : ErrorsList.fromJson(json["errors"]),
      );
}

class Error {
  String? errorDescription;

  Error({
    this.errorDescription,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorDescription: json["errorDescription"],
      );
}

class ErrorsList {
  List<String>? financialYear;
  List<String>? processedQty;
  List<String>? producedQty;
  List<String>? retreadedDate;
  List<String>? sellerName;
  List<String>? sellerMobile;
  List<String>? sellerAddress;
  List<String>? rawMaterial;
  List<String>? purchasedQuantity;
  List<String>? invoiceNumber;
  List<String>? sellerGstNo;
  List<String>? purchaseDate;
  List<String>? procurementInvoiceFile;
  List<String>? financeYear;
  List<String>? wasteTyreSupplierName;
  List<String>? wasteTyreSupplierContact;
  List<String>? wasteTyreSupplierAddress;
  List<String>? typeOfRecycledMaterial;
  List<String>? wasteTyreSupplierGst;
  List<String>? wasteGeneratedQty;
  List<String>? recycledDate;
  List<String>? sourceTyre;
  List<String>? producerType;
  List<String>? typeOfTyreManufacture;
  List<String>? month;
  List<String>? total;
  List<String>? complaint;
  List<String>? companyNameAndAddressRemark;
  List<String>? producerCategoryRemark;
  List<String>? gstRemark;
  List<String>? panRemark;
  List<String>? iecRemark;
  List<String>? auditRemark;
  List<String>? summary;
  List<String>? contactedSuppliers;
  List<String>? contactedAuditRemark;
  List<String>? verifiedSuppliers;
  List<String>? verifiedAuditRemark;
  List<String>? physicallyContactedSuppliers;
  List<String>? physicallyContactedAuditRemark;
  List<String>? physicallyVerifiedSuppliers;
  List<String>? physicallyVerifiedAuditRemark;
  List<String>? capacityTypeofEndProduct;
  List<String>? plantProductionCapacity;
  List<String>? endProductProducedAuditDay;
  List<String>? plantPerYear;
  List<String>? plantPerDay;
  List<String>? plantPerShift;
  List<String>? actualProcessingCapacity;
  List<String>? powerOnAuditDay;
  List<String>? totalElectricityConsumption;
  List<String>? productionInfoInvoiceAuditConfirmedStatus;
  List<String>? productionInfoInvoiceAdditionalDataNumberOfSuppliersContacted;
  List<String>? productionInfoInvoiceAuditRemark;
  List<String>? productionInfoBuyersAuditConfirmedStatus;
  List<String>? productionInfoBuyersAdditionalDataNumberOfBuyersContacted;
  List<String>? productionInfoBuyersAuditRemark;
  List<String>? wasteWaterGenerationAndDisposalSummaryAuditRemark;
  List<String>? generalInfoGstNoAuditRemark;
  List<String>? generalInfoCompanyPanAuditRemark;
  List<String>? generalInfoCtoAuditRemark;
  List<String>? generalInfoAuthorizationUnderHomwRulesAuditRemark;
  List<String>? generalInfoAddressLine1AuditRemark;
  List<String>? generalInfoGpsLocationAuditorAdditionalDataLat;
  List<String>? generalInfoGpsLocationAuditorAdditionalDataLong;
  List<String>? generalInfoGpsLocationAuditorAuditRemark;
  List<String>? generalInfoLastYearElectricityBillAuditDocument;
  List<String>? generalInfoLastYearElectricityBillAuditRemark;
  List<String>? generalInfoGeoTaggedVideoUploadAuditDocument;
  List<String>? generalInfoGeoTaggedVideoUploadAuditRemark;

  ErrorsList({
    this.financialYear,
    this.processedQty,
    this.producedQty,
    this.retreadedDate,
    this.sellerName,
    this.sellerMobile,
    this.sellerAddress,
    this.rawMaterial,
    this.purchasedQuantity,
    this.invoiceNumber,
    this.sellerGstNo,
    this.purchaseDate,
    this.procurementInvoiceFile,
    this.financeYear,
    this.wasteTyreSupplierName,
    this.wasteTyreSupplierContact,
    this.wasteTyreSupplierAddress,
    this.typeOfRecycledMaterial,
    this.wasteTyreSupplierGst,
    this.wasteGeneratedQty,
    this.sourceTyre,
    this.recycledDate,
    this.producerType,
    this.typeOfTyreManufacture,
    this.month,
    this.total,
    this.complaint,
    this.companyNameAndAddressRemark,
    this.producerCategoryRemark,
    this.panRemark,
    this.gstRemark,
    this.iecRemark,
    this.auditRemark,
    this.summary,
    this.actualProcessingCapacity,
    this.capacityTypeofEndProduct,
    this.contactedAuditRemark,
    this.contactedSuppliers,
    this.endProductProducedAuditDay,
    this.physicallyContactedAuditRemark,
    this.physicallyVerifiedAuditRemark,
    this.physicallyContactedSuppliers,
    this.physicallyVerifiedSuppliers,
    this.plantPerDay,
    this.plantPerShift,
    this.plantPerYear,
    this.plantProductionCapacity,
    this.powerOnAuditDay,
    this.totalElectricityConsumption,
    this.verifiedAuditRemark,
    this.verifiedSuppliers,
    this.productionInfoInvoiceAuditConfirmedStatus,
    this.productionInfoInvoiceAdditionalDataNumberOfSuppliersContacted,
    this.productionInfoInvoiceAuditRemark,
    this.productionInfoBuyersAuditConfirmedStatus,
    this.productionInfoBuyersAdditionalDataNumberOfBuyersContacted,
    this.productionInfoBuyersAuditRemark,
    this.wasteWaterGenerationAndDisposalSummaryAuditRemark,
    this.generalInfoAddressLine1AuditRemark,
    this.generalInfoAuthorizationUnderHomwRulesAuditRemark,
    this.generalInfoCompanyPanAuditRemark,
    this.generalInfoCtoAuditRemark,
    this.generalInfoGpsLocationAuditorAdditionalDataLat,
    this.generalInfoGstNoAuditRemark,
    this.generalInfoGpsLocationAuditorAdditionalDataLong,
    this.generalInfoGpsLocationAuditorAuditRemark,
    this.generalInfoLastYearElectricityBillAuditDocument,
    this.generalInfoLastYearElectricityBillAuditRemark,
    this.generalInfoGeoTaggedVideoUploadAuditDocument,
    this.generalInfoGeoTaggedVideoUploadAuditRemark,
  });

  factory ErrorsList.fromJson(Map<String, dynamic> json) => ErrorsList(
        financialYear: json["financial_year"] == null
            ? []
            : List<String>.from(json["financial_year"]!.map((x) => x)),
        processedQty: json["processed_qty"] == null
            ? []
            : List<String>.from(json["processed_qty"]!.map((x) => x)),
        producedQty: json["produced_qty"] == null
            ? []
            : List<String>.from(json["produced_qty"]!.map((x) => x)),
        retreadedDate: json["retreaded_date"] == null
            ? []
            : List<String>.from(json["retreaded_date"]!.map((x) => x)),
        sellerName: json["seller_name"] == null
            ? []
            : List<String>.from(json["seller_name"]!.map((x) => x)),
        sellerMobile: json["seller_mobile"] == null
            ? []
            : List<String>.from(json["seller_mobile"]!.map((x) => x)),
        sellerAddress: json["seller_address"] == null
            ? []
            : List<String>.from(json["seller_address"]!.map((x) => x)),
        rawMaterial: json["raw_material"] == null
            ? []
            : List<String>.from(json["raw_material"]!.map((x) => x)),
        purchasedQuantity: json["purchased_quantity"] == null
            ? []
            : List<String>.from(json["purchased_quantity"]!.map((x) => x)),
        invoiceNumber: json["invoice_number"] == null
            ? []
            : List<String>.from(json["invoice_number"]!.map((x) => x)),
        sellerGstNo: json["seller_gst_no"] == null
            ? []
            : List<String>.from(json["seller_gst_no"]!.map((x) => x)),
        purchaseDate: json["purchased_date"] == null
            ? []
            : List<String>.from(json["purchased_date"]!.map((x) => x)),
        procurementInvoiceFile: json["procurement_invoice_file"] == null
            ? []
            : List<String>.from(
                json["procurement_invoice_file"]!.map((x) => x)),
        financeYear: json["finance_year"] == null
            ? []
            : List<String>.from(json["finance_year"]!.map((x) => x)),
        wasteTyreSupplierName: json["waste_tyre_supplier_name"] == null
            ? []
            : List<String>.from(
                json["waste_tyre_supplier_name"]!.map((x) => x)),
        wasteTyreSupplierContact: json["waste_tyre_supplier_contact"] == null
            ? []
            : List<String>.from(
                json["waste_tyre_supplier_contact"]!.map((x) => x)),
        wasteTyreSupplierAddress: json["waste_tyre_supplier_address"] == null
            ? []
            : List<String>.from(
                json["waste_tyre_supplier_address"]!.map((x) => x)),
        wasteTyreSupplierGst: json["waste_tyre_supplier_gst"] == null
            ? []
            : List<String>.from(json["waste_tyre_supplier_gst"]!.map((x) => x)),
        wasteGeneratedQty: json["waste_generated_qty"] == null
            ? []
            : List<String>.from(json["waste_generated_qty"]!.map((x) => x)),
        recycledDate: json["recycled_date"] == null
            ? []
            : List<String>.from(json["recycled_date"]!.map((x) => x)),
        typeOfRecycledMaterial: json["type_of_recycled_material"] == null
            ? []
            : List<String>.from(
                json["type_of_recycled_material"]!.map((x) => x)),
        sourceTyre: json["source_tyre"] == null
            ? []
            : List<String>.from(json["source_tyre"]!.map((x) => x)),
        producerType: json["producer_type"] == null
            ? []
            : List<String>.from(json["producer_type"]!.map((x) => x)),
        typeOfTyreManufacture: json["type_of_tyre_manufacture"] == null
            ? []
            : List<String>.from(
                json["type_of_tyre_manufacture"]!.map((x) => x)),
        month: json["month"] == null
            ? []
            : List<String>.from(json["month"]!.map((x) => x)),
        total: json["total"] == null
            ? []
            : List<String>.from(json["total"]!.map((x) => x)),
        complaint: json["complaint"] == null
            ? []
            : List<String>.from(json["complaint"]!.map((x) => x)),
        companyNameAndAddressRemark:
            json["companyDetails.companyNameAddress.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["companyDetails.companyNameAddress.audit_remark"]!
                        .map((x) => x)),
        producerCategoryRemark:
            json["companyDetails.producerCategory.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["companyDetails.producerCategory.audit_remark"]!
                        .map((x) => x)),
        panRemark: json["companyDetails.companyPan.audit_remark"] == null
            ? []
            : List<String>.from(
                json["companyDetails.companyPan.audit_remark"]!.map((x) => x)),
        gstRemark: json["companyDetails.companyPan.audit_remark"] == null
            ? []
            : List<String>.from(
                json["companyDetails.companyPan.audit_remark"]!.map((x) => x)),
        iecRemark: json["companyDetails.companyIec.audit_remark"] == null
            ? []
            : List<String>.from(
                json["companyDetails.companyIec.audit_remark"]!.map((x) => x)),
        auditRemark: json["summaryReport.falseInformation.audit_remark"] == null
            ? []
            : List<String>.from(
                json["summaryReport.falseInformation.audit_remark"]!
                    .map((x) => x)),
        summary: json[
                    "summaryReport.falseInformation.additional_data.overall_summary"] ==
                null
            ? []
            : List<String>.from(json[
                    "summaryReport.falseInformation.additional_data.overall_summary"]!
                .map((x) => x)),
        contactedSuppliers:
            json["procurementInfo.contacted.additional_data.suppliers"] == null
                ? []
                : List<String>.from(
                    json["procurementInfo.contacted.additional_data.suppliers"]!
                        .map((x) => x)),
        contactedAuditRemark: json["procurementInfo.contacted.audit_remark"] ==
                null
            ? []
            : List<String>.from(
                json["procurementInfo.contacted.audit_remark"]!.map((x) => x)),
        verifiedSuppliers:
            json["procurementInfo.verified.additional_data.suppliers"] == null
                ? []
                : List<String>.from(
                    json["procurementInfo.verified.additional_data.suppliers"]!
                        .map((x) => x)),
        verifiedAuditRemark: json["procurementInfo.verified.audit_remark"] ==
                null
            ? []
            : List<String>.from(
                json["procurementInfo.verified.audit_remark"]!.map((x) => x)),
        physicallyContactedSuppliers: json[
                    "procurementInfo.physicallyContacted.additional_data.suppliers"] ==
                null
            ? []
            : List<String>.from(json[
                    "procurementInfo.physicallyContacted.additional_data.suppliers"]!
                .map((x) => x)),
        physicallyContactedAuditRemark:
            json["procurementInfo.physicallyContacted.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["procurementInfo.physicallyContacted.audit_remark"]!
                        .map((x) => x)),
        physicallyVerifiedSuppliers: json[
                    "procurementInfo.physicallyVerified.additional_data.suppliers"] ==
                null
            ? []
            : List<String>.from(json[
                    "procurementInfo.physicallyVerified.additional_data.suppliers"]!
                .map((x) => x)),
        physicallyVerifiedAuditRemark:
            json["procurementInfo.physicallyVerified.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["procurementInfo.physicallyVerified.audit_remark"]!
                        .map((x) => x)),
        capacityTypeofEndProduct: json[
                    "processingCapacity.planCapacityAssesment.additional_data.type_of_end_product"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.planCapacityAssesment.additional_data.type_of_end_product"]!
                .map((x) => x)),
        plantProductionCapacity: json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_production_capacity"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_production_capacity"]!
                .map((x) => x)),
        endProductProducedAuditDay: json[
                    "processingCapacity.planCapacityAssesment.additional_data.end_product_produced_on_audit_day"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.planCapacityAssesment.additional_data.end_product_produced_on_audit_day"]!
                .map((x) => x)),
        plantPerYear: json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_operational_per_year"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_operational_per_year"]!
                .map((x) => x)),
        plantPerDay: json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_operational_per_day"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_operational_per_day"]!
                .map((x) => x)),
        plantPerShift: json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_operational_per_shift"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.planCapacityAssesment.additional_data.plant_operational_per_shift"]!
                .map((x) => x)),
        actualProcessingCapacity: json[
                    "processingCapacity.valueComparable.additional_data.actual_processing_capacity"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.valueComparable.additional_data.actual_processing_capacity"]!
                .map((x) => x)),
        powerOnAuditDay: json[
                    "processingCapacity.electricityVerification.additional_data.power_on_audit_day"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.electricityVerification.additional_data.power_on_audit_day"]!
                .map((x) => x)),
        totalElectricityConsumption: json[
                    "processingCapacity.electricityVerification.additional_data.total_electricity_consumption"] ==
                null
            ? []
            : List<String>.from(json[
                    "processingCapacity.electricityVerification.additional_data.total_electricity_consumption"]!
                .map((x) => x)),
        productionInfoInvoiceAuditConfirmedStatus:
            json["productionInfo.invoice.audit_confirmed_status"] == null
                ? []
                : List<String>.from(
                    json["productionInfo.invoice.audit_confirmed_status"]!
                        .map((x) => x)),
        productionInfoInvoiceAdditionalDataNumberOfSuppliersContacted: json[
                    "productionInfo.invoice.additional_data.numberOfSuppliersContacted"] ==
                null
            ? []
            : List<String>.from(json[
                    "productionInfo.invoice.additional_data.numberOfSuppliersContacted"]!
                .map((x) => x)),
        productionInfoInvoiceAuditRemark:
            json["productionInfo.invoice.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["productionInfo.invoice.audit_remark"]!.map((x) => x)),
        productionInfoBuyersAuditConfirmedStatus:
            json["productionInfo.buyers.audit_confirmed_status"] == null
                ? []
                : List<String>.from(
                    json["productionInfo.buyers.audit_confirmed_status"]!
                        .map((x) => x)),
        productionInfoBuyersAdditionalDataNumberOfBuyersContacted: json[
                    "productionInfo.buyers.additional_data.numberOfBuyersContacted"] ==
                null
            ? []
            : List<String>.from(json[
                    "productionInfo.buyers.additional_data.numberOfBuyersContacted"]!
                .map((x) => x)),
        productionInfoBuyersAuditRemark:
            json["productionInfo.buyers.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["productionInfo.buyers.audit_remark"]!.map((x) => x)),
        wasteWaterGenerationAndDisposalSummaryAuditRemark:
            json["wasteWaterGenerationAndDisposal.summary.audit_remark"] == null
                ? []
                : List<String>.from(json[
                        "wasteWaterGenerationAndDisposal.summary.audit_remark"]!
                    .map((x) => x)),
        generalInfoGstNoAuditRemark:
            json["generalInfo.gstNo.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.gstNo.audit_remark"]!.map((x) => x)),
        generalInfoCompanyPanAuditRemark:
            json["generalInfo.companyPan.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.companyPan.audit_remark"]!.map((x) => x)),
        generalInfoCtoAuditRemark: json["generalInfo.cto.audit_remark"] == null
            ? []
            : List<String>.from(
                json["generalInfo.cto.audit_remark"]!.map((x) => x)),
        generalInfoAuthorizationUnderHomwRulesAuditRemark:
            json["generalInfo.authorizationUnderHomwRules.audit_remark"] == null
                ? []
                : List<String>.from(json[
                        "generalInfo.authorizationUnderHomwRules.audit_remark"]!
                    .map((x) => x)),
        generalInfoAddressLine1AuditRemark:
            json["generalInfo.addressLine1.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.addressLine1.audit_remark"]!
                        .map((x) => x)),
        generalInfoGpsLocationAuditorAdditionalDataLat:
            json["generalInfo.gpsLocationAuditor.additional_data.lat"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.gpsLocationAuditor.additional_data.lat"]!
                        .map((x) => x)),
        generalInfoGpsLocationAuditorAdditionalDataLong:
            json["generalInfo.gpsLocationAuditor.additional_data.long"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.gpsLocationAuditor.additional_data.long"]!
                        .map((x) => x)),
        generalInfoGpsLocationAuditorAuditRemark:
            json["generalInfo.gpsLocationAuditor.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.gpsLocationAuditor.audit_remark"]!
                        .map((x) => x)),
        generalInfoLastYearElectricityBillAuditDocument:
            json["generalInfo.lastYearElectricityBill.audit_document"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.lastYearElectricityBill.audit_document"]!
                        .map((x) => x)),
        generalInfoLastYearElectricityBillAuditRemark:
            json["generalInfo.lastYearElectricityBill.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.lastYearElectricityBill.audit_remark"]!
                        .map((x) => x)),
        generalInfoGeoTaggedVideoUploadAuditDocument:
            json["generalInfo.geoTaggedVideoUpload.audit_document"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.geoTaggedVideoUpload.audit_document"]!
                        .map((x) => x)),
        generalInfoGeoTaggedVideoUploadAuditRemark:
            json["generalInfo.geoTaggedVideoUpload.audit_remark"] == null
                ? []
                : List<String>.from(
                    json["generalInfo.geoTaggedVideoUpload.audit_remark"]!
                        .map((x) => x)),
      );
}
