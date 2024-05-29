
class RecyclerProcurementRequestModel {
  String? invoiceFile;
  String? financeYear;
  String? sourceTyres;
  String? sellerName;
  String? sellerMobile;
  String? sellerAddress;
  String? rawMaterial;
  String? purchasedQuantity;
  String? invoiceNumber;
  String? sellerGstNo;
  String? purchasedDate;

  RecyclerProcurementRequestModel({
    this.invoiceFile,
    this.financeYear,
    this.sourceTyres,
    this.sellerName,
    this.sellerMobile,
    this.sellerAddress,
    this.rawMaterial,
    this.purchasedQuantity,
    this.invoiceNumber,
    this.sellerGstNo,
    this.purchasedDate,
  });

  Map<String, dynamic> toJson() => {
    "invoice_file": invoiceFile,
    "finance_year": financeYear,
    "source_tyre": sourceTyres,
    "seller_name": sellerName,
    "seller_mobile": sellerMobile,
    "seller_address": sellerAddress,
    "raw_material": rawMaterial,
    "purchased_quantity": purchasedQuantity,
    "invoice_number": invoiceNumber,
    "seller_gst_no": sellerGstNo,
    "purchased_date": purchasedDate,
  };
}
