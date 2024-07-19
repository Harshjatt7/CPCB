class AuditorRecyclerForm4RequestModel {
  ProductionInfoRequest? productionInfo;
  String? submit;

  AuditorRecyclerForm4RequestModel({
    this.productionInfo,
    this.submit,
  });

  Map<String, dynamic> toJson() => {
        "productionInfo": productionInfo?.toJson(),
        "submit": submit,
      };
}

class ProductionInfoRequest {
  InvoiceRequest? invoice;
  BuyersRequest? buyers;

  ProductionInfoRequest({
    this.invoice,
    this.buyers,
  });

  Map<String, dynamic> toJson() => {
        "invoice": invoice?.toJson(),
        "buyers": buyers?.toJson(),
      };
}

class BuyersRequest {
  String? auditConfirmedStatus;
  BuyersAdditionalRequestData? additionalData;
  String? auditRemark;

  BuyersRequest({
    this.auditConfirmedStatus,
    this.additionalData,
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
        "audit_remark": auditRemark,
      };
}

class BuyersAdditionalRequestData {
  String? numberOfBuyersContacted;

  BuyersAdditionalRequestData({
    this.numberOfBuyersContacted,
  });

  Map<String, dynamic> toJson() => {
        "numberOfBuyersContacted": numberOfBuyersContacted,
      };
}

class InvoiceRequest {
  String? auditConfirmedStatus;
  InvoiceAdditionalRequestData? additionalData;
  String? auditRemark;

  InvoiceRequest({
    this.auditConfirmedStatus,
    this.additionalData,
    this.auditRemark,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "additional_data": additionalData?.toJson(),
        "audit_remark": auditRemark,
      };
}

class InvoiceAdditionalRequestData {
  String? numberOfSuppliersContacted;

  InvoiceAdditionalRequestData({
    this.numberOfSuppliersContacted,
  });

  Map<String, dynamic> toJson() => {
        "numberOfSuppliersContacted": numberOfSuppliersContacted,
      };
}
