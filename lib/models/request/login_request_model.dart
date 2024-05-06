class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({this.password, this.username});

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}
