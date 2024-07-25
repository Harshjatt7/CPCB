class AddRecyclerDataConstantsResponseModel {
  AddRecyclerDataConstantsData? data;

  AddRecyclerDataConstantsResponseModel({
    this.data,
  });

  factory AddRecyclerDataConstantsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AddRecyclerDataConstantsResponseModel(
        data: json["data"] == null
            ? null
            : AddRecyclerDataConstantsData.fromJson(json["data"]),
      );
}

class AddRecyclerDataConstantsData {
  List<String>? tyreOfRecyclerMaterial;
  List<String>? financialYear;
  List<String>? sourceTyre;

  AddRecyclerDataConstantsData({
    this.tyreOfRecyclerMaterial,
    this.financialYear,
    this.sourceTyre,
  });

  factory AddRecyclerDataConstantsData.fromJson(Map<String, dynamic> json) =>
      AddRecyclerDataConstantsData(
        tyreOfRecyclerMaterial: json["tyreOfRecyclerMaterial"] == null
            ? []
            : List<String>.from(json["tyreOfRecyclerMaterial"]!.map((x) => x)),
        financialYear: json["financialYear"] == null
            ? []
            : List<String>.from(json["financialYear"]!.map((x) => x)),
        sourceTyre: json["source_tyre"] == null
            ? []
            : List<String>.from(json["source_tyre"]!.map((x) => x)),
      );
}
