class AuditorRecyclerFormResponseModel {
  String? auditPlanId;
  GeneralInfoResponse? generalInfo;
  EndProducts? endProducts;
  int? quantityOfSales;

  AuditorRecyclerFormResponseModel({
    this.auditPlanId,
    this.generalInfo,
    this.endProducts,
    this.quantityOfSales,
  });

  factory AuditorRecyclerFormResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AuditorRecyclerFormResponseModel(
        auditPlanId: json["auditPlanId"],
        generalInfo: json["generalInfo"] == null
            ? null
            : GeneralInfoResponse.fromJson(json["generalInfo"]),
        endProducts: json["endProducts"] == null
            ? null
            : EndProducts.fromJson(json["endProducts"]),
        quantityOfSales: json["quantityOfSales"],
      );
}

class EndProducts {
  String? scrumRubber;
  String? crumRubber;
  String? crmb;
  String? recoveredCarbon;
  String? pyrolisisOilBatch;
  String? pyrolisisOilContinuous;

  EndProducts({
    this.scrumRubber,
    this.crumRubber,
    this.crmb,
    this.recoveredCarbon,
    this.pyrolisisOilBatch,
    this.pyrolisisOilContinuous,
  });

  factory EndProducts.fromJson(Map<String, dynamic> json) => EndProducts(
        scrumRubber: json["scrum_rubber"],
        crumRubber: json["crum_rubber"],
        crmb: json["crmb"],
        recoveredCarbon: json["recovered_carbon"],
        pyrolisisOilBatch: json["pyrolisis_oil_batch"],
        pyrolisisOilContinuous: json["pyrolisis_oil_continuous"],
      );
}

class GeneralInfoResponse {
  String? gstNo;
  String? companyPan;
  String? companyIec;
  String? cto;
  String? authorizationUnderHomwRules;
  String? addressLine1;
  String? lat;
  String? long;
  String? authorizedPersonAdhar;
  String? authorizedPersonPan;
  List<dynamic>? detailsOfMachinery;
  String? airPollutionControlDevices;

  GeneralInfoResponse({
    this.gstNo,
    this.companyPan,
    this.companyIec,
    this.cto,
    this.authorizationUnderHomwRules,
    this.addressLine1,
    this.lat,
    this.long,
    this.authorizedPersonAdhar,
    this.authorizedPersonPan,
    this.detailsOfMachinery,
    this.airPollutionControlDevices,
  });

  factory GeneralInfoResponse.fromJson(Map<String, dynamic> json) => GeneralInfoResponse(
        gstNo: json["gstNo"],
        companyPan: json["companyPan"],
        companyIec: json["companyIEC"],
        cto: json["cto"],
        authorizationUnderHomwRules: json["authorizationUnderHomwRules"],
        addressLine1: json["addressLine1"],
        lat: json["lat"],
        long: json["long"],
        authorizedPersonAdhar: json["authorizedPersonAdhar"],
        authorizedPersonPan: json["authorizedPersonPan"],
        detailsOfMachinery: json["detailsOfMachinery"] == null
            ? []
            : List<dynamic>.from(json["detailsOfMachinery"]!.map((x) => x)),
        airPollutionControlDevices: json["airPollutionControlDevices"],
      );
}
