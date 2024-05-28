import 'dart:convert';

RecyclerResponseData responseDataFromJson(String str) =>
    RecyclerResponseData.fromJson(json.decode(str));

class RecyclerResponseData {
  RecyclerData? data;

  RecyclerResponseData({
    this.data,
  });

  factory RecyclerResponseData.fromJson(Map<String, dynamic> json) => RecyclerResponseData(
        data: json["data"] == null ? null : RecyclerData.fromJson(json["data"]),
      );
}

class RecyclerData {
  Map<String, String>? rawMaterialType;
  List<String>? tyreSource;
  List<String>? financialYear;

  RecyclerData({
    this.rawMaterialType,
    this.tyreSource,
    this.financialYear,
  });

  factory RecyclerData.fromJson(Map<String, dynamic> json) => RecyclerData(
        rawMaterialType: Map.from(json["rawMaterialType"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        tyreSource: json["tyreSource"] == null
            ? null
            : List<String>.from(json["tyreSource"].map((x) => x)),
        financialYear: json["financialYear"] == null
            ? null
            : List<String>.from(json["financialYear"].map((x) => x)),
      );
}
