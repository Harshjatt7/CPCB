

class RawMaterialResponseModel {
    RawMaterialData? data;
    int? status;

    RawMaterialResponseModel({
        this.data,
        this.status,
    });

    factory RawMaterialResponseModel.fromJson(Map<String, dynamic> json) => RawMaterialResponseModel(
        data: json["data"] == null ? null : RawMaterialData.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
    };
}

class RawMaterialData {
    String? radial;
    String? biasPly;

    RawMaterialData({
        this.radial,
        this.biasPly,
    });

    factory RawMaterialData.fromJson(Map<String, dynamic> json) => RawMaterialData(
        radial: json["Radial"],
        biasPly: json["BiasPly"],
    );

    Map<String, dynamic> toJson() => {
        "Radial": radial,
        "BiasPly": biasPly,
    };
}
