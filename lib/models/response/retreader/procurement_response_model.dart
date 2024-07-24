class ProcurementResponseModel {
  List<ProcurementAddData>? data;
  Links? links;
  Meta? meta;
  int? status;

  ProcurementResponseModel({
    this.data,
    this.links,
    this.meta,
    this.status,
  });

  factory ProcurementResponseModel.fromJson(Map<String, dynamic> json) =>
      ProcurementResponseModel(
        data: json["data"] == null
            ? []
            : List<ProcurementAddData>.from(
                json["data"]!.map((x) => ProcurementAddData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        status: json["status"],
      );
}

class ProcurementAddData {
  String? financeYear;
  String? sellerName;
  String? sellerMobile;
  String? sellerAddress;
  String? invoiceNumber;
  String? sellerGstNo;
  String? rawMaterial;
  int? isPublished;
  String? purchasedDate;
  int? isOpeningBalance;
  dynamic openingBalance;
  String? purchasedQuantity;
  String? quantityReceived;
  String? sourceTyre;

  ProcurementAddData(
      {this.financeYear,
      this.sellerName,
      this.sellerMobile,
      this.sellerAddress,
      this.invoiceNumber,
      this.sellerGstNo,
      this.rawMaterial,
      this.isPublished,
      this.purchasedDate,
      this.isOpeningBalance,
      this.openingBalance,
      this.purchasedQuantity,
      this.quantityReceived,
      this.sourceTyre,
      });

  factory ProcurementAddData.fromJson(Map<String, dynamic> json) =>
      ProcurementAddData(
        financeYear: json["finance_year"],
        sellerName: json["seller_name"],
        sellerMobile: json["seller_mobile"],
        sellerAddress: json["seller_address"],
        invoiceNumber: json["invoice_number"],
        sellerGstNo: json["seller_gst_no"],
        rawMaterial: json["raw_material"],
        isPublished: json["is_published"],
        purchasedDate: json["purchased_date"],
        isOpeningBalance: json["is_opening_balance"],
        openingBalance: json["opening_balance"],
        purchasedQuantity: json["purchased_quantity"],
        quantityReceived: json["quantity_received"],
        sourceTyre: json["source_tyre"],
      );
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

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
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

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
