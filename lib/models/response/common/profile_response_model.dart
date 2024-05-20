class ProfileResponseModel {
  ProfileData? data;

  ProfileResponseModel({
    this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );
}

class ProfileData {
  String? id;
  String? userType;
  String? name;
  String? mobileNumber;
  String? email;
  dynamic companyContactNo;
  String? companyPan;
  String? gstNo;
  dynamic companyIec;
  dynamic cinNo;
  dynamic authorizationNumber;
  String? addressLine1;
  dynamic addressLine2;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? authorizedPersonName;
  String? authorizedDesignation;
  String? authorizedPersonEmailId;
  String? authorizedcontactNumber;
  String? authorizedPersonAdhar;
  dynamic authorizedPersonAddressLine1;
  dynamic authorizedPersonAddressLine2;
  dynamic authorizedPersonAddressCountry;
  dynamic authorizedPersonAddressState;
  dynamic authorizedPersonAddressCity;
  dynamic authorizedPersonAddressPinCode;
  dynamic lastChangedPasswordDateTime;
  dynamic authorizedFileName;
  dynamic whitelistedCompany;
  int? isPublished;

  ProfileData({
    this.id,
    this.userType,
    this.name,
    this.mobileNumber,
    this.email,
    this.companyContactNo,
    this.companyPan,
    this.gstNo,
    this.companyIec,
    this.cinNo,
    this.authorizationNumber,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    this.pincode,
    this.authorizedPersonName,
    this.authorizedDesignation,
    this.authorizedPersonEmailId,
    this.authorizedcontactNumber,
    this.authorizedPersonAdhar,
    this.authorizedPersonAddressLine1,
    this.authorizedPersonAddressLine2,
    this.authorizedPersonAddressCountry,
    this.authorizedPersonAddressState,
    this.authorizedPersonAddressCity,
    this.authorizedPersonAddressPinCode,
    this.lastChangedPasswordDateTime,
    this.authorizedFileName,
    this.whitelistedCompany,
    this.isPublished,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        userType: json["user_type"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        companyContactNo: json["companyContactNo"],
        companyPan: json["companyPan"],
        gstNo: json["gstNo"],
        companyIec: json["companyIEC"],
        cinNo: json["cinNo"],
        authorizationNumber: json["authorizationNumber"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        authorizedPersonName: json["authorizedPersonName"],
        authorizedDesignation: json["authorizedDesignation"],
        authorizedPersonEmailId: json["authorizedPersonEmailId"],
        authorizedcontactNumber: json["authorizedcontactNumber"],
        authorizedPersonAdhar: json["authorizedPersonAdhar"],
        authorizedPersonAddressLine1: json["authorizedPersonAddressLine1"],
        authorizedPersonAddressLine2: json["authorizedPersonAddressLine2"],
        authorizedPersonAddressCountry: json["authorizedPersonAddressCountry"],
        authorizedPersonAddressState: json["authorizedPersonAddressState"],
        authorizedPersonAddressCity: json["authorizedPersonAddressCity"],
        authorizedPersonAddressPinCode: json["authorizedPersonAddressPinCode"],
        lastChangedPasswordDateTime: json["last_changed_password_date_time"],
        authorizedFileName: json["authorized_file_name"],
        whitelistedCompany: json["whitelisted_company"],
        isPublished: json["is_published"],
      );
}
