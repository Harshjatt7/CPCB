import 'package:cpcb_tyre/utils/helper/helper_functions.dart';

class DashboardResponseModel {
  DashboardData? data;

  DashboardResponseModel({
    this.data,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardResponseModel(
        data:
            json["data"] == null ? null : DashboardData.fromJson(json["data"]),
      );
}

class DashboardData {
  String? userType;
  String? currentStatus;
  String? dateOfApplication;
  String? uniqueRegistrationNumber;
  String? dateOfRegistration;
  String? registrationExpiryDate;
  bool? downloadApplication;
  bool? downloadInvoice;
  EprCredits? eprCredits;
  ProcurementData? procurementData;
  ProcessedStock? processedStock;
  AnnualReturn? annualReturn;
  EnvironmentCompensation? environmentCompensation;
  EprCompliance? eprCompliance;

  DashboardData(
      {this.userType,
      this.currentStatus,
      this.dateOfApplication,
      this.uniqueRegistrationNumber,
      this.dateOfRegistration,
      this.registrationExpiryDate,
      this.downloadApplication,
      this.downloadInvoice,
      this.eprCredits,
      this.procurementData,
      this.processedStock,
      this.annualReturn,
      this.environmentCompensation,
      this.eprCompliance});

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        userType: json["user_type"],
        currentStatus: json["current_status"],
        dateOfApplication: json["date_of_application"] != null
            ? HelperFunctions()
                .getFormattedDate(json['date_of_application'].toString())
            : null,
        uniqueRegistrationNumber: json["unique_registration_number"],
        dateOfRegistration: json["date_of_registration"] != null
            ? HelperFunctions()
                .getFormattedDate(json['date_of_registration'].toString())
            : null,
        registrationExpiryDate: json["registration_expiry_date"] != null
            ? HelperFunctions()
                .getFormattedDate(json['registration_expiry_date'].toString())
            : null,
        downloadApplication: json["download_application"],
        downloadInvoice: json["download_invoice"],
        eprCompliance: json["epr_compliance"] == null
            ? null
            : EprCompliance.fromJson(json["epr_compliance"]),
        eprCredits: json["epr_credits"] == null
            ? null
            : EprCredits.fromJson(json["epr_credits"]),
        procurementData: json["procurement_data"] == null
            ? null
            : ProcurementData.fromJson(json["procurement_data"]),
        processedStock: json["processed_stock"] == null
            ? null
            : ProcessedStock.fromJson(json["processed_stock"]),
        annualReturn: json["annual_return"] == null
            ? null
            : AnnualReturn.fromJson(json["annual_return"]),
        environmentCompensation: json["environment_compensation"] == null
            ? null
            : EnvironmentCompensation.fromJson(
                json["environment_compensation"]),
      );
}

class AnnualReturn {
  num? financialYear;
  String? dueDate;
  String? currentStatus;
  String? dateOfAnnualReturnFiling;

  AnnualReturn({
    this.financialYear,
    this.dueDate,
    this.currentStatus,
    this.dateOfAnnualReturnFiling,
  });

  factory AnnualReturn.fromJson(Map<String, dynamic> json) => AnnualReturn(
        financialYear: json["financial_year"],
        dueDate: json["due_date"],
        currentStatus: json["current_status"],
        dateOfAnnualReturnFiling: json["date_of_annual_return_filing"],
      );
}

class EprCompliance {
  String? year;
  num? eprObligation;
  num? eprFulfilled;
  num? eprObligationRemaining;

  EprCompliance({
    this.year,
    this.eprObligation,
    this.eprFulfilled,
    this.eprObligationRemaining,
  });

  factory EprCompliance.fromJson(Map<String, dynamic> json) => EprCompliance(
        year: json["year"],
        eprObligation: json["eprObligation"],
        eprFulfilled: json["eprFulfilled"],
        eprObligationRemaining: json["eprObligationRemaining"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "eprObligation": eprObligation,
        "eprFulfilled": eprFulfilled,
        "eprObligationRemaining": eprObligationRemaining,
      };
}

class EnvironmentCompensation {
  String? dateOfEc;
  String? currentStatus;
  String? type;
  String? amount;

  EnvironmentCompensation({
    this.dateOfEc,
    this.currentStatus,
    this.type,
    this.amount,
  });

  factory EnvironmentCompensation.fromJson(Map<String, dynamic> json) =>
      EnvironmentCompensation(
        dateOfEc: json["date_of_ec"],
        currentStatus: json["current_status"],
        type: json["type"],
        amount: json["amount"],
      );
}

class EprCredits {
  num? creditsGenerated;
  num? creditsTransferred;
  num? creditsAvailable;

  EprCredits({
    this.creditsGenerated,
    this.creditsTransferred,
    this.creditsAvailable,
  });

  factory EprCredits.fromJson(Map<String, dynamic> json) => EprCredits(
        creditsGenerated: json["credits_generated"],
        creditsTransferred: json["credits_transferred"],
        creditsAvailable: json["credits_available"],
      );
}

class ProcessedStock {
  num? totalProduced;
  num? totalSold;
  num? availableProcessedStock;

  ProcessedStock({
    this.totalProduced,
    this.totalSold,
    this.availableProcessedStock,
  });

  factory ProcessedStock.fromJson(Map<String, dynamic> json) => ProcessedStock(
        totalProduced: json["total_produced"],
        totalSold: json["total_sold"],
        availableProcessedStock: json["available_processed_stock"],
      );
}

class ProcurementData {
  num? totalProcurement;
  num? totalProcurementProcessed;
  num? availableStock;

  ProcurementData({
    this.totalProcurement,
    this.totalProcurementProcessed,
    this.availableStock,
  });

  factory ProcurementData.fromJson(Map<String, dynamic> json) =>
      ProcurementData(
        totalProcurement: json["total_procurement"],
        totalProcurementProcessed: json["total_procurement_processed"],
        availableStock: json["available_stock"],
      );
}
