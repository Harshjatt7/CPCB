class LoginRequestModel {
  String? email;
  String? password;
  String? userType;

  LoginRequestModel({this.password, this.email, this.userType});

  Map<String, dynamic> toJson() =>
      {"email": email, "password": password, "user_type": userType?.toLowerCase()};
}
