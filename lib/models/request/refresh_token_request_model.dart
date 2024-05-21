class RefreshTokenRequestModel {
  String? refreshToken;

  RefreshTokenRequestModel({
    this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
        "refresh_token": refreshToken,
      };
}
