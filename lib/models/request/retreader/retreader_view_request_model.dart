import 'dart:convert';

String retreaderRequestModelToJson(RetreaderRequestModel data) => json.encode(data.toJson());

class RetreaderRequestModel {
    String? financialYear;
    String? supplierName;
    String? supplierAddress;
    String? supplierMobile;
    String? typeOfRawMaterial;
    String? processedQty;
    String? producedQty;
    String? wasteGeneratedQty;
    String? supplierGstNo;
    String? retreadedDate;

    RetreaderRequestModel({
        this.financialYear,
        this.supplierName,
        this.supplierAddress,
        this.supplierMobile,
        this.typeOfRawMaterial,
        this.processedQty,
        this.producedQty,
        this.wasteGeneratedQty,
        this.supplierGstNo,
        this.retreadedDate,
    });
    Map<String, dynamic> toJson() => {
        "financial_year": financialYear,
        "supplier_name": supplierName,
        "supplier_address": supplierAddress,
        "supplier_mobile": supplierMobile,
        "type_of_raw_material": typeOfRawMaterial,
        "processed_qty": processedQty,
        "produced_qty": producedQty,
        "waste_generated_qty": wasteGeneratedQty,
        "supplier_gst_no": supplierGstNo,
        "retreaded_date": retreadedDate,
    };
}
