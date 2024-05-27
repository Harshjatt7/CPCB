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
  // List<String>? financialYear;

  AddRecyclerDataConstantsData({
    this.tyreOfRecyclerMaterial,
    //this.financialYear,
  });

  factory AddRecyclerDataConstantsData.fromJson(Map<String, dynamic> json) =>
      AddRecyclerDataConstantsData(
        tyreOfRecyclerMaterial: json["tyreOfRecyclerMaterial"] == null
            ? []
            : List<String>.from(json["tyreOfRecyclerMaterial"]!.map((x) => x)),
        // financialYear: json["financialYear"] == null
        //     ? null
        //     : List<String>.from(json["financialYear"]!.map((x) => x)),
      );
}
