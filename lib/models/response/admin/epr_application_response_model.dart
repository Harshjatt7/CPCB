class EprApplicationResponseModel {
  EPRApplicationData? eprApplicationData;
  int? status;

  EprApplicationResponseModel({
    this.eprApplicationData,
    this.status,
  });

  factory EprApplicationResponseModel.fromJson(Map<String, dynamic> json) =>
      EprApplicationResponseModel(
        eprApplicationData: json["data"] == null
            ? null
            : EPRApplicationData.fromJson(json["data"]),
        status: json["status"],
      );
}

class EPRApplicationData {
  String? name;
  num? applications;
  num? applicationUnderProcess;
  num? applicationPendingApplicant;
  num? applicationGranted;
  num? applicationUnderDh;
  num? applicationApprovedAuthority;
  num? applicationRejectedAuthority;
  num? applicationAwaitingApproval;
  num? outboxcount;
  num? inboxCount;
  num? certificateCount;

  EPRApplicationData({
    this.name,
    this.applications,
    this.applicationUnderProcess,
    this.applicationPendingApplicant,
    this.applicationGranted,
    this.applicationUnderDh,
    this.applicationApprovedAuthority,
    this.applicationRejectedAuthority,
    this.applicationAwaitingApproval,
    this.outboxcount,
    this.inboxCount,
    this.certificateCount,
  });

  factory EPRApplicationData.fromJson(Map<String, dynamic> json) =>
      EPRApplicationData(
        name: json["name"],
        applications: json["applications"],
        applicationUnderProcess: json["applicationUnderProcess"],
        applicationPendingApplicant: json["applicationPendingApplicant"],
        applicationGranted: json["applicationGranted"],
        applicationUnderDh: json["applicationUnderDh"],
        applicationApprovedAuthority: json["applicationApprovedAuthority"],
        applicationRejectedAuthority: json["applicationRejectedAuthority"],
        applicationAwaitingApproval: json["applicationAwaitingApproval"],
        outboxcount: json["outboxcount"],
        inboxCount: json["inboxCount"],
        certificateCount: json["certificateCount"],
      );
}
