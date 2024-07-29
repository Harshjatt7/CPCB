class AuditorRecyclerForm4ResponseModel {
  Data? data;

  AuditorRecyclerForm4ResponseModel({
    this.data,
  });

  factory AuditorRecyclerForm4ResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AuditorRecyclerForm4ResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  List<EprDatum>? eprData;
  String? auditPlanId;
  ProductionInfo? productionInfo;

  Data({
    this.eprData,
    this.auditPlanId,
    this.productionInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        eprData: json["eprData"] == null
            ? []
            : List<EprDatum>.from(
                json["eprData"]!.map((x) => EprDatum.fromJson(x))),
        auditPlanId: json["auditPlanId"],
        productionInfo: (json["productionInfo"] == null ||
                (json["productionInfo"] != null &&
                    json["productionInfo"].length == 0))
            ? null
            : ProductionInfo.fromJson(json["productionInfo"]),
      );
}

class EprDatum {
  num? id;
  num? userId;
  String? name;
  String? address;
  String? mobile;
  String? gstNumber;
  DateTime? startDate;
  String? financeYear;
  String? enteryDate;
  dynamic invoiceAmout;
  dynamic gstAmout;
  String? invoiceNumber;
  dynamic materialReclaimed;
  String? materialReclaimedFactor;
  String? materialRecoveredFactor;
  String? materialModifiedCrumbFactor;
  String? materialCrumbFactor;
  String? materialPyrolysisFactor;
  dynamic materialRecovered;
  dynamic materialModifiedCrumb;
  dynamic materialCrumb;
  String? materialPyrolysis;
  num? materialReclaimedWeight;
  num? materialRecoveredWeight;
  num? materialModifiedCrumbWeight;
  num? materialCrumbWeight;
  num? materialPyrolysisWeght;
  String? invoiceFile;
  String? buyerName;
  String? buyerAddress;
  String? sourceTyre;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? invoiceLink;
  String? invoiceLinkApi;

  EprDatum({
    this.id,
    this.userId,
    this.name,
    this.address,
    this.mobile,
    this.gstNumber,
    this.startDate,
    this.financeYear,
    this.enteryDate,
    this.invoiceAmout,
    this.gstAmout,
    this.invoiceNumber,
    this.materialReclaimed,
    this.materialReclaimedFactor,
    this.materialRecoveredFactor,
    this.materialModifiedCrumbFactor,
    this.materialCrumbFactor,
    this.materialPyrolysisFactor,
    this.materialRecovered,
    this.materialModifiedCrumb,
    this.materialCrumb,
    this.materialPyrolysis,
    this.materialReclaimedWeight,
    this.materialRecoveredWeight,
    this.materialModifiedCrumbWeight,
    this.materialCrumbWeight,
    this.materialPyrolysisWeght,
    this.invoiceFile,
    this.buyerName,
    this.buyerAddress,
    this.sourceTyre,
    this.createdAt,
    this.updatedAt,
    this.invoiceLink,
    this.invoiceLinkApi,
  });

  factory EprDatum.fromJson(Map<String, dynamic> json) => EprDatum(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        address: json["address"],
        mobile: json["mobile"],
        gstNumber: json["gst_number"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        financeYear: json["finance_year"],
        enteryDate: json["entery_date"],
        invoiceAmout: json["invoice_amout"],
        gstAmout: json["gst_amout"],
        invoiceNumber: json["invoice_number"],
        materialReclaimed: json["material_reclaimed"],
        materialReclaimedFactor: json["material_reclaimed_factor"],
        materialRecoveredFactor: json["material_recovered_factor"],
        materialModifiedCrumbFactor: json["material_modified_crumb_factor"],
        materialCrumbFactor: json["material_crumb_factor"],
        materialPyrolysisFactor: json["material_pyrolysis_factor"],
        materialRecovered: json["material_recovered"],
        materialModifiedCrumb: json["material_modified_crumb"],
        materialCrumb: json["material_crumb"],
        materialPyrolysis: json["material_pyrolysis"],
        materialReclaimedWeight: json["material_reclaimed_weight"],
        materialRecoveredWeight: json["material_recovered_weight"],
        materialModifiedCrumbWeight: json["material_modified_crumb_weight"],
        materialCrumbWeight: json["material_crumb_weight"],
        materialPyrolysisWeght: json["material_pyrolysis_weght"],
        invoiceFile: json["invoice_file"],
        buyerName: json["buyer_name"],
        buyerAddress: json["buyer_address"],
        sourceTyre: json["source_tyre"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        invoiceLink: json["invoiceLink"],
        invoiceLinkApi: json["invoiceLinkApi"],
      );
}

class ProductionInfo {
  Invoice? invoice;
  Buyers? buyers;

  ProductionInfo({
    this.invoice,
    this.buyers,
  });

  factory ProductionInfo.fromJson(Map<String, dynamic> json) => ProductionInfo(
        invoice:
            json["invoice"] == null ? null : Invoice.fromJson(json["invoice"]),
        buyers: json["buyers"] == null ? null : Buyers.fromJson(json["buyers"]),
      );
}

class Buyers {
  String? auditValue;
  String? auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  BuyersAdditionalData? additionalData;

  Buyers({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory Buyers.fromJson(Map<String, dynamic> json) => Buyers(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : BuyersAdditionalData.fromJson(json["additional_data"]),
      );
}

class BuyersAdditionalData {
  String? numberOfBuyersContacted;

  BuyersAdditionalData({
    this.numberOfBuyersContacted,
  });

  factory BuyersAdditionalData.fromJson(Map<String, dynamic> json) =>
      BuyersAdditionalData(
        numberOfBuyersContacted: json["numberOfBuyersContacted"],
      );
}

class Invoice {
  String? auditValue;
  String? auditDocument;
  String? auditRemark;
  int? auditConfirmedStatus;
  InvoiceAdditionalData? additionalData;

  Invoice({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : InvoiceAdditionalData.fromJson(json["additional_data"]),
      );
}

class InvoiceAdditionalData {
  String? numberOfSuppliersContacted;

  InvoiceAdditionalData({
    this.numberOfSuppliersContacted,
  });

  factory InvoiceAdditionalData.fromJson(Map<String, dynamic> json) =>
      InvoiceAdditionalData(
        numberOfSuppliersContacted: json["numberOfSuppliersContacted"],
      );
}
