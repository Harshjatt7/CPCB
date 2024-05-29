import 'dart:convert';

RecyclerProcurementConstantsResponseData
    recyclerProcurementConstantsResponseDataFromJson(String str) =>
        RecyclerProcurementConstantsResponseData.fromJson(json.decode(str));

class RecyclerProcurementConstantsResponseData {
  Data? data;

  RecyclerProcurementConstantsResponseData({
    this.data,
  });

  factory RecyclerProcurementConstantsResponseData.fromJson(
          Map<String, dynamic> json) =>
      RecyclerProcurementConstantsResponseData(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  RawMaterialType? rawMaterialType;
  List<String>? tyreSource;
  List<String>? financialYear;

  Data({
    this.rawMaterialType,
    this.tyreSource,
    this.financialYear,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rawMaterialType: json["rawMaterialType"] == null
            ? null
            : RawMaterialType.fromJson(json["rawMaterialType"]),
        tyreSource: json["tyreSource"] == null
            ? []
            : List<String>.from(json["tyreSource"]!.map((x) => x)),
        financialYear: json["financialYear"] == null
            ? []
            : List<String>.from(json["financialYear"]!.map((x) => x)),
      );
}

class RawMaterialType {
  String? tyres;
  String? flapsTubes;

  RawMaterialType({
    this.tyres,
    this.flapsTubes,
  });

  factory RawMaterialType.fromJson(Map<String, dynamic> json) =>
      RawMaterialType(
        tyres: json["Tyres"],
        flapsTubes: json["Flaps/Tubes"],
      );
}
