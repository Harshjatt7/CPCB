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

  ErrorsList(
      {this.financialYear,
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
      this.recycledDate});
      

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
      );

  Map<String, dynamic> toJson() => {
        "financial_year": financialYear == null
            ? []
            : List<dynamic>.from(financialYear!.map((x) => x)),
        "processed_qty": processedQty == null
            ? []
            : List<dynamic>.from(processedQty!.map((x) => x)),
        "produced_qty": producedQty == null
            ? []
            : List<dynamic>.from(producedQty!.map((x) => x)),
        "retreaded_date": retreadedDate == null
            ? []
            : List<dynamic>.from(retreadedDate!.map((x) => x)),
        "seller_name": sellerName == null
            ? []
            : List<dynamic>.from(sellerName!.map((x) => x)),
        "seller_mobile": sellerMobile == null
            ? []
            : List<dynamic>.from(sellerMobile!.map((x) => x)),
        "seller_address": sellerAddress == null
            ? []
            : List<dynamic>.from(sellerAddress!.map((x) => x)),
        "raw_material": rawMaterial == null
            ? []
            : List<dynamic>.from(rawMaterial!.map((x) => x)),
        "purchased_quantity": purchasedQuantity == null
            ? []
            : List<dynamic>.from(purchasedQuantity!.map((x) => x)),
        "invoice_number": invoiceNumber == null
            ? []
            : List<dynamic>.from(invoiceNumber!.map((x) => x)),
        "seller_gst_no": sellerGstNo == null
            ? []
            : List<dynamic>.from(sellerGstNo!.map((x) => x)),
        "purchased_date": purchaseDate == null
            ? []
            : List<dynamic>.from(purchaseDate!.map((x) => x)),
        "procurement_invoice_file": procurementInvoiceFile == null
            ? []
            : List<dynamic>.from(procurementInvoiceFile!.map((x) => x)),
        "finance_year": financeYear == null
            ? []
            : List<dynamic>.from(financeYear!.map((x) => x)),
        "waste_tyre_supplier_name": wasteTyreSupplierName == null
            ? []
            : List<dynamic>.from(wasteTyreSupplierName!.map((x) => x)),
        "waste_tyre_supplier_contact": wasteTyreSupplierContact == null
            ? []
            : List<dynamic>.from(wasteTyreSupplierContact!.map((x) => x)),
        "waste_tyre_supplier_address": wasteTyreSupplierAddress == null
            ? []
            : List<dynamic>.from(wasteTyreSupplierAddress!.map((x) => x)),
        "waste_tyre_supplier_gst": wasteTyreSupplierGst == null
            ? []
            : List<dynamic>.from(wasteTyreSupplierGst!.map((x) => x)),
        "waste_generated_qty": wasteGeneratedQty == null
            ? []
            : List<dynamic>.from(wasteGeneratedQty!.map((x) => x)),
        "recycled_date": recycledDate == null
            ? []
            : List<dynamic>.from(recycledDate!.map((x) => x)),
        "type_of_recycled_material": typeOfRecycledMaterial == null
            ? []
            : List<dynamic>.from(typeOfRecycledMaterial!.map((x) => x)),
        "source_tyre": sourceTyre == null
            ? []
            : List<dynamic>.from(sourceTyre!.map((x) => x)),
      };
}
