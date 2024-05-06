class LoginResponseModel {
  LoginData? data;
  LoginResponseModel({this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );
}

class LoginData {
  String? accessToken;
  String? refreshToken;
  bool? isSuccess;

  LoginData({this.accessToken, this.refreshToken, this.isSuccess});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      isSuccess: json["statusCode"] == 200 || json["statusCode"] == 201);
}
