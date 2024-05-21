import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginData? data;

  LoginResponseModel({
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        data: LoginData.fromJson(json["data"]),
      );
}

class LoginData {
  String? token;
  String? refreshToken;

  LoginData({
    this.token,
    this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        refreshToken: json["refresh_token"],
      );
}
