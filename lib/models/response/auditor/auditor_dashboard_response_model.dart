class AuditorDashBoardResponseModel {
  AuditorDashboardData? data;
  int? status;

  AuditorDashBoardResponseModel({
    this.data,
    this.status,
  });

  factory AuditorDashBoardResponseModel.fromJson(Map<String, dynamic> json) =>
      AuditorDashBoardResponseModel(
        data: json["data"] == null ? null : AuditorDashboardData.fromJson(json["data"]),
        status: json["status"],
      );
}

class AuditorDashboardData {
  int? total;
  int? started;
  int? pending;
  int? completed;
  String? name;
  String? email;
  String? mobileNumber;
  String? agencyName;
  String? state;
  String? userType;

  AuditorDashboardData({
    this.total,
    this.started,
    this.pending,
    this.completed,
    this.name,
    this.email,
    this.mobileNumber,
    this.agencyName,
    this.state,
    this.userType,
  });

  factory AuditorDashboardData.fromJson(Map<String, dynamic> json) => AuditorDashboardData(
        total: json["total"],
        started: json["started"],
        pending: json["pending"],
        completed: json["completed"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        agencyName: json["agencyName"],
        state: json["state"],
        userType: json["userType"],
      );
}
