import 'dart:convert';

String addRecyclerDataRequestModelToJson(AddRecyclerDataRequestModel data) =>
    json.encode(data.toJson());

class AddRecyclerDataRequestModel {
  String? financialYear;
  String? wasteTyreSupplierName;
  String? wasteTyreSupplierContact;
  String? wasteTyreSupplierAddress;
  String? typeOfRecycledMaterial;
  String? wasteTyreSupplierGst;
  num? processedQty;
  num? producedQty;
  num? wasteGeneratedQty;
  String? recycledDate;

  AddRecyclerDataRequestModel({
    this.financialYear,
    this.wasteTyreSupplierName,
    this.wasteTyreSupplierContact,
    this.wasteTyreSupplierAddress,
    this.typeOfRecycledMaterial,
    this.wasteTyreSupplierGst,
    this.processedQty,
    this.producedQty,
    this.wasteGeneratedQty,
    this.recycledDate,
  });

  Map<String, dynamic> toJson() => {
        "financial_year": financialYear,
        "waste_tyre_supplier_name": wasteTyreSupplierName,
        "waste_tyre_supplier_contact": wasteTyreSupplierContact,
        "waste_tyre_supplier_address": wasteTyreSupplierAddress,
        "type_of_recycled_material": typeOfRecycledMaterial,
        "waste_tyre_supplier_gst": wasteTyreSupplierGst,
        "processed_qty": processedQty,
        "produced_qty": producedQty,
        "waste_generated_qty": wasteGeneratedQty,
        "recycled_date": recycledDate,
      };
}
