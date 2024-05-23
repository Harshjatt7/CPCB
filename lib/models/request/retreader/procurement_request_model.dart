import 'dart:convert';

import 'package:dio/dio.dart';

String procurementRequestModelToJson(ProcurementRequestModel data) =>
    json.encode(data.toJson());

class ProcurementRequestModel {
  String? financialYear;
  String? sellerName;
  String? contactDetails;
  String? supplierAddress;
  String? sellerMobile;
  String? typeOfRawMaterial;
  String? supplierGstNo;
  String? purchaseDate;
  String? invoiceNumber;
  String? purchaseQuantity;
  MultipartFile? uploadInvoice;

  ProcurementRequestModel(
      {this.financialYear,
      this.sellerMobile,
      this.supplierAddress,
      this.sellerName,
      this.typeOfRawMaterial,
      this.supplierGstNo,
      this.contactDetails,
      this.invoiceNumber,
      this.purchaseDate,
      this.purchaseQuantity,
      this.uploadInvoice});
  Map<String, dynamic> toJson() => {
        "finance_year": financialYear,
        "seller_name": sellerName,
        "seller_address": supplierAddress,
        "seller_mobile": sellerMobile,
        "raw_material": typeOfRawMaterial,
        "seller_gst_no": supplierGstNo,
        "contact_details": contactDetails,
        "invoice_number": invoiceNumber,
        "purchased_date": purchaseDate,
        "purchased_quantity": purchaseQuantity,
        "procurement_invoice_file": uploadInvoice,
      };
}
