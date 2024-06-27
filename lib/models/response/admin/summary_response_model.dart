import 'dart:convert';

AdminSummaryResponseData adminSummaryResponseDataFromJson(String str) =>
    AdminSummaryResponseData.fromJson(json.decode(str));

class AdminSummaryResponseData {
  SummaryDataResponse? data;

  AdminSummaryResponseData({
    this.data,
  });

  factory AdminSummaryResponseData.fromJson(Map<String, dynamic> json) =>
      AdminSummaryResponseData(
        data: json["data"] == null
            ? null
            : SummaryDataResponse.fromJson(json["data"]),
      );
}

class SummaryDataResponse {
  Producer? producer;
  Recycler? recycler;
  Retreader? retreader;

  SummaryDataResponse({
    this.producer,
    this.recycler,
    this.retreader,
  });

  factory SummaryDataResponse.fromJson(Map<String, dynamic> json) =>
      SummaryDataResponse(
        producer: json["Producer"] == null
            ? null
            : Producer.fromJson(json["Producer"]),
        recycler: json["Recycler"] == null
            ? null
            : Recycler.fromJson(json["Recycler"]),
        retreader: json["Retreader"] == null
            ? null
            : Retreader.fromJson(json["Retreader"]),
      );
}

class Producer {
  double? totalEprObligation;

  Producer({
    this.totalEprObligation,
  });

  factory Producer.fromJson(Map<String, dynamic> json) => Producer(
        totalEprObligation: json["totalEprObligation"]?.toDouble(),
      );
}

class Recycler {
  int? earnedCredit;
  int? creditTransfered;

  Recycler({
    this.earnedCredit,
    this.creditTransfered,
  });

  factory Recycler.fromJson(Map<String, dynamic> json) => Recycler(
        earnedCredit: json["earnedCredit"],
        creditTransfered: json["creditTransfered"],
      );
}

class Retreader {
  int? totalCredit;
  int? creditTransfered;

  Retreader({
    this.totalCredit,
    this.creditTransfered,
  });

  factory Retreader.fromJson(Map<String, dynamic> json) => Retreader(
        totalCredit: json["totalCredit"],
        creditTransfered: json["creditTransfered"],
      );
}
