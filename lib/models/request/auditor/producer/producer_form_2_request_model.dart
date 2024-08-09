import 'dart:convert';

String producerForm2RequestModelToJson(ProducerForm2RequestModel data) =>
    json.encode(data.toJson());

class ProducerForm2RequestModel {
  ProducerRequestSalesData? producerSalesData;
  String? submit;
  String? auditPlanId;

  ProducerForm2RequestModel({
    this.producerSalesData,
    this.submit,
    this.auditPlanId,
  });

  Map<String, dynamic> toJson() => {
        "producerSalesData": producerSalesData?.toJson(),
        "submit": submit,
        "auditPlanId": auditPlanId,
      };
}

class ProducerRequestSalesData {
  ProducerSalesDetail? salesP1;
  ProducerSalesDetail? salesP2;
  ProducerSalesDetail? salesP3;
  ProducerSalesDetail? salesP4;
  ProducerSalesDetail? salesP5;
  ProducerSalesDetail? salesP6;

  ProducerRequestSalesData({
    this.salesP1,
    this.salesP2,
    this.salesP3,
    this.salesP4,
    this.salesP5,
    this.salesP6,
  });

  Map<String, dynamic> toJson() => {
        "salesP1": salesP1?.toJson(),
        "salesP2": salesP2?.toJson(),
        "salesP3": salesP3?.toJson(),
        "salesP4": salesP4?.toJson(),
        "salesP5": salesP5?.toJson(),
        "salesP6": salesP6?.toJson(),
      };
}

class ProducerSalesDetail {
  String? auditConfirmedStatus;

  ProducerSalesDetail({
    this.auditConfirmedStatus,
  });

  Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
      };
}
