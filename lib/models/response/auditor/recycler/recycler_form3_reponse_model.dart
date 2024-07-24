class AuditorRecyclerForm3ResponseModel {
  RecyclerForm3Data? data;

  AuditorRecyclerForm3ResponseModel({
    this.data,
  });

  factory AuditorRecyclerForm3ResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AuditorRecyclerForm3ResponseModel(
        data: json["data"] == null
            ? null
            : RecyclerForm3Data.fromJson(json["data"]),
      );
}

class RecyclerForm3Data {
  List<ProcurementDatum>? procurementData;
  String? auditPlanId;
  ProcurementInfo? procurementInfo;

  RecyclerForm3Data({
    this.procurementData,
    this.auditPlanId,
    this.procurementInfo,
  });

  factory RecyclerForm3Data.fromJson(Map<String, dynamic> json) =>
      RecyclerForm3Data(
        procurementData: json["procurementData"] == null
            ? []
            : List<ProcurementDatum>.from(json["procurementData"]!
                .map((x) => ProcurementDatum.fromJson(x))),
        auditPlanId: json["auditPlanId"],
        procurementInfo: json["procurementInfo"] == null
            ? null
            : ProcurementInfo.fromJson(json["procurementInfo"]),
      );
}

class ProcurementDatum {
  int? id;
  int? userId;
  String? openingBalance;
  String? financeYear;
  String? sellerName;
  String? sellerMobile;
  String? sellerAddress;
  String? rawMaterial;
  String? materialType;
  String? purchasedQuantity;
  String? invoiceNumber;
  dynamic sellerGstNo;
  dynamic purchasedDate;
  String? sourceTyre;
  String? procurementInvoiceFile;
  int? isPublished;
  int? isOpeningBalance;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  ProcurementDatum({
    this.id,
    this.userId,
    this.openingBalance,
    this.financeYear,
    this.sellerName,
    this.sellerMobile,
    this.sellerAddress,
    this.rawMaterial,
    this.materialType,
    this.purchasedQuantity,
    this.invoiceNumber,
    this.sellerGstNo,
    this.purchasedDate,
    this.sourceTyre,
    this.procurementInvoiceFile,
    this.isPublished,
    this.isOpeningBalance,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ProcurementDatum.fromJson(Map<String, dynamic> json) =>
      ProcurementDatum(
        id: json["id"],
        userId: json["user_id"],
        openingBalance: json["opening_balance"],
        financeYear: json["finance_year"],
        sellerName: json["seller_name"],
        sellerMobile: json["seller_mobile"],
        sellerAddress: json["seller_address"],
        rawMaterial: json["raw_material"],
        materialType: json["material_type"],
        purchasedQuantity: json["purchased_quantity"],
        invoiceNumber: json["invoice_number"],
        sellerGstNo: json["seller_gst_no"],
        purchasedDate: json["purchased_date"],
        sourceTyre: json["source_tyre"],
        procurementInvoiceFile: json["procurement_invoice_file"],
        isPublished: json["is_published"],
        isOpeningBalance: json["is_opening_balance"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}

class ProcurementInfo {
  Contacted? contacted;
  Verified? verified;
  Contacted? physicallyContacted;
  Verified? physicallyVerified;

  ProcurementInfo({
    this.contacted,
    this.verified,
    this.physicallyContacted,
    this.physicallyVerified,
  });

  factory ProcurementInfo.fromJson(Map<String, dynamic> json) =>
      ProcurementInfo(
        contacted: json["contacted"] == null
            ? null
            : Contacted.fromJson(json["contacted"]),
        verified: json["verified"] == null
            ? null
            : Verified.fromJson(json["verified"]),
        physicallyContacted: json["physicallyContacted"] == null
            ? null
            : Contacted.fromJson(json["physicallyContacted"]),
        physicallyVerified: json["physicallyVerified"] == null
            ? null
            : Verified.fromJson(json["physicallyVerified"]),
      );
}

class Contacted {
  dynamic auditValue;
  dynamic auditDocument;
  dynamic auditRemark;
  int? auditConfirmedStatus;
  ContactedAdditionalData? additionalData;

  Contacted({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory Contacted.fromJson(Map<String, dynamic> json) => Contacted(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : ContactedAdditionalData.fromJson(json["additional_data"]),
      );
}

class ContactedAdditionalData {
  dynamic suppliers;

  ContactedAdditionalData({
    this.suppliers,
  });

  factory ContactedAdditionalData.fromJson(Map<String, dynamic> json) =>
      ContactedAdditionalData(
        suppliers: json["suppliers"],
      );
}

class Verified {
  dynamic auditValue;
  dynamic auditDocument;
  dynamic auditRemark;
  int? auditConfirmedStatus;
  PhysicallyVerifiedAdditionalData? additionalData;

  Verified({
    this.auditValue,
    this.auditDocument,
    this.auditRemark,
    this.auditConfirmedStatus,
    this.additionalData,
  });

  factory Verified.fromJson(Map<String, dynamic> json) => Verified(
        auditValue: json["audit_value"],
        auditDocument: json["audit_document"],
        auditRemark: json["audit_remark"],
        auditConfirmedStatus: json["audit_confirmed_status"],
        additionalData: json["additional_data"] == null
            ? null
            : PhysicallyVerifiedAdditionalData.fromJson(
                json["additional_data"]),
      );
}

class PhysicallyVerifiedAdditionalData {
  dynamic suppliers;
  int? suppliersNotVerified;

  PhysicallyVerifiedAdditionalData({
    this.suppliers,
    this.suppliersNotVerified,
  });

  factory PhysicallyVerifiedAdditionalData.fromJson(
          Map<String, dynamic> json) =>
      PhysicallyVerifiedAdditionalData(
        suppliers: json["suppliers"],
        suppliersNotVerified: json["suppliers_not_verified"],
      );
}
