class EprOblicationsResponseModel {
  EprOblicationsData? data;
  int? status;

  EprOblicationsResponseModel({
    this.data,
    this.status,
  });

  factory EprOblicationsResponseModel.fromJson(Map<String, dynamic> json) =>
      EprOblicationsResponseModel(
        data: json["data"] == null
            ? null
            : EprOblicationsData.fromJson(json["data"]),
        status: json["status"],
      );
}

class EprOblicationsData {
  num? newTyreManufacturers;
  num? newTyreProducedDomestically;
  double? newTyreImported;
  num? newTyreImportedAndImportedVehicles;
  num? newTyreImportedExclusivelyForNewVehiclesManufacturedDomestically;
  num? wasteTyreImported;

  EprOblicationsData({
    this.newTyreManufacturers,
    this.newTyreProducedDomestically,
    this.newTyreImported,
    this.newTyreImportedAndImportedVehicles,
    this.newTyreImportedExclusivelyForNewVehiclesManufacturedDomestically,
    this.wasteTyreImported,
  });

  factory EprOblicationsData.fromJson(Map<String, dynamic> json) =>
      EprOblicationsData(
        newTyreManufacturers: json["new_tyre manufacturers"]?.toDouble(),
        newTyreProducedDomestically:
            json["new_tyre_produced domestically"]?.toDouble(),
        newTyreImported: json["new_tyre_imported"]?.toDouble(),
        newTyreImportedAndImportedVehicles:
            json["new_tyre_imported_and_imported_vehicles"],
        newTyreImportedExclusivelyForNewVehiclesManufacturedDomestically: json[
                "new_tyre_imported_exclusively_for_new_vehicles_manufactured_domestically"]
            ?.toDouble(),
        wasteTyreImported: json["waste_tyre_imported"]?.toDouble(),
      );
}
