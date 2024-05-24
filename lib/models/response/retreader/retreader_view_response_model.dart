import 'dart:convert';

RetreaderResponseModel retreaderResponseModelFromJson(String str) =>
    RetreaderResponseModel.fromJson(json.decode(str));

class RetreaderResponseModel {
  List<RetreadedData>? data;
  Links? links;
  Meta? meta;
  num? status;

  RetreaderResponseModel({
    this.data,
    this.links,
    this.meta,
    this.status,
  });

  factory RetreaderResponseModel.fromJson(Map<String, dynamic> json) =>
      RetreaderResponseModel(
        data: json["data"] == null
            ? []
            : List<RetreadedData>.from(
                json["data"]!.map((x) => RetreadedData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        status: json["status"],
      );
}

class RetreadedData {
  String? id;
  String? financialYear;
  String? wasteTyreSupplierName;
  String? addressOfWasteTyreSupplier;
  String? contactDetails;
  String? gstNumber;
  String? typeOfRawMaterial;
  num? quantityProcessed;
  num? quantityProduced;
  num? quantityOfWasteGenerated;
  String? retreadedDate;

  RetreadedData({
    this.id,
    this.financialYear,
    this.wasteTyreSupplierName,
    this.addressOfWasteTyreSupplier,
    this.contactDetails,
    this.gstNumber,
    this.typeOfRawMaterial,
    this.quantityProcessed,
    this.quantityProduced,
    this.quantityOfWasteGenerated,
    this.retreadedDate,
  });

  factory RetreadedData.fromJson(Map<String, dynamic> json) => RetreadedData(
        id: json["id"],
        financialYear: json["financial_year"],
        wasteTyreSupplierName: json["waste_tyre_supplier_name"],
        addressOfWasteTyreSupplier: json["address_of_waste_tyre_supplier"],
        contactDetails: json["contact_details"],
        gstNumber: json["gst_number"],
        typeOfRawMaterial: json["type_of_raw_material"],
        quantityProcessed: json["quantity_processed"],
        quantityProduced: json["quantity_produced"],
        quantityOfWasteGenerated: json["quantity_of_waste_generated"],
        retreadedDate: json["retreaded_date"],
      );
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );
}

class Meta {
  num? currentPage;
  num? from;
  num? lastPage;
  String? path;
  num? perPage;
  num? to;
  num? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );
}
