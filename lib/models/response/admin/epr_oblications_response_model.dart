class EprOblicationsResponseModel {
  CommonEprOblicationData? data;
  int? status;

  EprOblicationsResponseModel({
    this.data,
    this.status,
  });

  factory EprOblicationsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      EprOblicationsResponseModel(
        data: json["data"] == null
            ? null
            : CommonEprOblicationData.fromJson(json["data"]),
        status: json["status"],
      );
}

class CommonEprOblicationData {
  CrumbRubber? reclaimedRubber;
  CrumbRubber? recoverCarbon;
  CrumbRubber? crumbRubberModifiedBitumenCrmb;
  CrumbRubber? crumbRubber;
  CrumbRubber? tpoChar;
  CrumbRubber? retreadedTyre;

  CommonEprOblicationData(
      {this.reclaimedRubber,
      this.recoverCarbon,
      this.crumbRubberModifiedBitumenCrmb,
      this.crumbRubber,
      this.tpoChar,
      this.retreadedTyre});

  factory CommonEprOblicationData.fromJson(Map<String, dynamic> json) =>
      CommonEprOblicationData(
        reclaimedRubber: json["Reclaimed rubber"] == null
            ? null
            : CrumbRubber.fromJson(json["Reclaimed rubber"]),
        recoverCarbon: json["Recover carbon"] == null
            ? null
            : CrumbRubber.fromJson(json["Recover carbon"]),
        crumbRubberModifiedBitumenCrmb:
            json["Crumb rubber modified bitumen(CRMB)"] == null
                ? null
                : CrumbRubber.fromJson(
                    json["Crumb rubber modified bitumen(CRMB)"]),
        crumbRubber: json["Crumb rubber"] == null
            ? null
            : CrumbRubber.fromJson(json["Crumb rubber"]),
        tpoChar: json["TPO & Char"] == null
            ? null
            : CrumbRubber.fromJson(json["TPO & Char"]),
        retreadedTyre: json["Retreaded tyre"] == null
            ? null
            : CrumbRubber.fromJson(json["Retreaded tyre"]),
      );
}

class CrumbRubber {
  String? name;
  int? earnedCredit;
  int? creditTransfered;

  CrumbRubber({
    this.name,
    this.earnedCredit,
    this.creditTransfered,
  });

  factory CrumbRubber.fromJson(Map<String, dynamic> json) => CrumbRubber(
        name: json["name"],
        earnedCredit: json["earnedCredit"],
        creditTransfered: json["creditTransfered"],
      );
}
