class SpcbUsersResponseModel {
  SPCBData? spcbData;
  int? status;

  SpcbUsersResponseModel({
    this.spcbData,
    this.status,
  });

  factory SpcbUsersResponseModel.fromJson(Map<String, dynamic> json) =>
      SpcbUsersResponseModel(
        spcbData: json["data"] == null ? null : SPCBData.fromJson(json["data"]),
        status: json["status"],
      );
}

class SPCBData {
  ProducerData? producerData;
  ProducerData? retreaderData;
  ProducerData? recyclerData;

  SPCBData({this.producerData, this.recyclerData, this.retreaderData});

  factory SPCBData.fromJson(Map<String, dynamic> json) => SPCBData(
        producerData: json["producerData"] == null
            ? null
            : ProducerData.fromJson(json["producerData"]),
        recyclerData: json["recyclerData"] == null
            ? null
            : ProducerData.fromJson(json["recyclerData"]),
        retreaderData: json["retreaderData"] == null
            ? null
            : ProducerData.fromJson(json["retreaderData"]),
      );
}

class ProducerData {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  ProducerData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ProducerData.fromJson(Map<String, dynamic> json) => ProducerData(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class Data {
  String? regNum;
  dynamic registrationDate;
  String? stateName;
  String? name;
  String? addressLine1;
  int? userId;

  Data({
    this.regNum,
    this.registrationDate,
    this.stateName,
    this.name,
    this.addressLine1,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        regNum: json["reg_num"],
        registrationDate: json["registration_date"],
        stateName: json["stateName"],
        name: json["name"],
        addressLine1: json["addressLine1"],
        userId: json["userId"],
      );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
