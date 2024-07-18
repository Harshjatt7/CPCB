class DocumentResponseModel {
  DocumentData? data;

  DocumentResponseModel({
    this.data,
  });

  factory DocumentResponseModel.fromJson(Map<String, dynamic> json) =>
      DocumentResponseModel(
        data: json["data"] == null ? null : DocumentData.fromJson(json["data"]),
      );
}

class DocumentData {
  String? fileUrl;
  String? fileName;
  String? fileKey;

  DocumentData({
    this.fileUrl,
    this.fileName,
    this.fileKey,
  });

  factory DocumentData.fromJson(Map<String, dynamic> json) => DocumentData(
        fileUrl: json["fileUrl"],
        fileName: json["fileName"],
        fileKey: json["fileKey"],
      );
}
