import '../retreader/procurement_response_model.dart';

class RecyclerDataListResponseModel {
  List<RecyclerDataListData>? data;
  Links? links;
  Meta? meta;
  num? status;

  RecyclerDataListResponseModel({
    this.data,
    this.links,
    this.meta,
    this.status,
  });

  factory RecyclerDataListResponseModel.fromJson(Map<String, dynamic> json) =>
      RecyclerDataListResponseModel(
        data: json["data"] == null
            ? []
            : List<RecyclerDataListData>.from(
                json["data"]!.map((x) => RecyclerDataListData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        status: json["status"],
      );
}

class RecyclerDataListData {
  String? financialYear;
  dynamic wasteTyreSupplierName;
  dynamic wasteTyreSupplierContact;
  dynamic wasteTyreSupplierAddress;
  String? typeOfRecycledMaterial;
  String? wasteTyreSupplierGst;
  num? processedQty;
  num? producedQty;
  num? wasteGeneratedQty;
  String? recycledDate;

  RecyclerDataListData({
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

  factory RecyclerDataListData.fromJson(Map<String, dynamic> json) =>
      RecyclerDataListData(
        financialYear: json["financial_year"],
        wasteTyreSupplierName: json["waste_tyre_supplier_name"],
        wasteTyreSupplierContact: json["waste_tyre_supplier_contact"],
        wasteTyreSupplierAddress: json["waste_tyre_supplier_address"],
        typeOfRecycledMaterial: json["type_of_recycled_material"],
        wasteTyreSupplierGst: json["waste_tyre_supplier_gst"],
        processedQty: json["processed_qty"],
        producedQty: json["produced_qty"],
        wasteGeneratedQty: json["waste_generated_qty"],
        recycledDate: json["recycled_date"],
      );
}
