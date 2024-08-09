class AuditorPostModel {
  String? auditPlanId;

  AuditorPostModel({
    this.auditPlanId,
  });

  Map<String, dynamic> toJson() => {
        "auditPlanId": auditPlanId,
      };
}
