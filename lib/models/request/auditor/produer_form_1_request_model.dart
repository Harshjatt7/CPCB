import 'dart:convert';

String producerForm1RequestModelToJson(ProducerForm1RequestModel data) => json.encode(data.toJson());

class ProducerForm1RequestModel {
    CompanyDetails? companyDetails;

    ProducerForm1RequestModel({
        this.companyDetails,
    });

    Map<String, dynamic> toJson() => {
        "companyDetails": companyDetails?.toJson(),
    };
}

class CompanyDetails {
    CompanyCin? companyNameAddress;
    CompanyCin? producerCategory;
    CompanyCin? companyGst;
    CompanyCin? companyPan;
    CompanyCin? companyCin;
    CompanyCin? companyIec;

    CompanyDetails({
        this.companyNameAddress,
        this.producerCategory,
        this.companyGst,
        this.companyPan,
        this.companyCin,
        this.companyIec,
    });

    Map<String, dynamic> toJson() => {
        "companyNameAddress": companyNameAddress?.toJson(),
        "producerCategory": producerCategory?.toJson(),
        "companyGst": companyGst?.toJson(),
        "companyPan": companyPan?.toJson(),
        "companyCin": companyCin?.toJson(),
        "companyIec": companyIec?.toJson(),
    };
}

class CompanyCin {
    String? auditConfirmedStatus;
    String? auditRemark;

    CompanyCin({
        this.auditConfirmedStatus,
        this.auditRemark,
    });

    Map<String, dynamic> toJson() => {
        "audit_confirmed_status": auditConfirmedStatus,
        "audit_remark": auditRemark,
    };
}
