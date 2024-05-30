class SalesDataResponseModel {
  List<SalesData>? data;
  Links? links;
  Meta? meta;

  SalesDataResponseModel({
    this.data,
    this.links,
    this.meta,
  });

  factory SalesDataResponseModel.fromJson(Map<String, dynamic> json) =>
      SalesDataResponseModel(
        data: json["data"] == null
            ? []
            : List<SalesData>.from(json["data"]!.map((x) => SalesData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );
}

class SalesData {
  String? typeOfTyreManufacture;
  String? financialYear;
  String? month;
  String? motorCycle;
  String? passengerCar;
  String? scooter;
  String? truck;
  String? bus;
  String? lcv;
  String? tRear;
  String? other;
  String? total;
  String? producerType;

  SalesData({
    this.typeOfTyreManufacture,
    this.financialYear,
    this.month,
    this.motorCycle,
    this.passengerCar,
    this.scooter,
    this.truck,
    this.bus,
    this.lcv,
    this.tRear,
    this.other,
    this.total,
    this.producerType
  });

  factory SalesData.fromJson(Map<String, dynamic> json) => SalesData(
        typeOfTyreManufacture: json["type_of_tyre_manufacture"],
        financialYear: json["financial_year"],
        month: json["month"],
        motorCycle: json["motor_cycle"],
        passengerCar: json["passenger_car"],
        scooter: json["scooter"],
        truck: json["truck"],
        bus: json["bus"],
        lcv: json["lcv"],
        tRear: json["t_rear"],
        other: json["other"],
        total: json["total"],
        producerType: json["producer_type"],
      );
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

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
