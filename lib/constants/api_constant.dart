import 'package:cpcb_tyre/constants/enums/api_environments.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';

///[APIRoutes] class will be used to store all the API routes that we will use in the application.
class APIRoutes {
  MessageConstant msg = MessageConstant();

  static String baseUrl = "";

  final String loginAPIRoute = "api/login";
  final String producerDashboardAPIRoute = "api/producer/dashboard";
  final String retreaderDashboardAPIRoute = "api/retreader/dashboard";
  final String recyclerDashboardAPIRoute = "api/recycler/dashboard";
  final String profileAPIRoute = "api/user-profile";
  final String retreaderAPIRoute = "api/retreader/retreaded-data";
  final String procurementAPIRoute = "api/retreader/add-procurement-data";
  final String refreshTokenAPIRoute = "api/refresh-token";
  final String logoutAPIRoute = "api/logout";
  final String downloadRetreaderPaymentReciptAPIRoute =
      "api/retreader/download-invoice";
  final String downloadRecyclerPaymentReciptAPIRoute =
      "api/recycler/download-invoice";
  final String downloadProducerPaymentReciptAPIRoute =
      "api/producer/download-invoice";
  final String retreaderGetProcurementDataAPIRoute =
      "api/retreader/get-procurement-data";
  final String reyclerProcurementAddDataAPIRoute =
      "api/recycler/add-procuremnt-data-recycler";
  final String reyclerProcurementConstantDataAPIRoute =
      "api/recycler/add-procuremnt-constant-recycler";
  final String recyclerProcurementDataAPIRoute =
      "api/recycler/get-procuremnt-data";
  final String getRecyclerData = "api/recycler/get-recycled-data";
  final String getRecyclerDataConstants =
      "api/recycler/add-recycled-data-constant";
  final String addRecycledData = "api/recycler/add-recycled-data";
  final String retreaderDownloadApplicationAPIRoute =
      "api/retreader/download-application";
  final String producerSalesDataAPIRoute = "api/producer/add-sales-data";
  final String producerSalesDataConstantAPIRoute =
      "api/producer/add-sales-data-constant-list";
  final String producerSalesDataList = "api/producer/sales-data-list";
  final String adminApplicationReceived =
      "api/admin/list-applications-received";
  final String adminEPRApplicationsAPIRoute = "api/admin/application-counts/";
  final String adminEPROblicationsAPIRoute = "api/admin/activity-overview/";
  final String adminDownloadInvoiceAPIRoute = "api/admin/download-transaction/";
  final String adminSummaryAPIRoute = "api/admin/summary-all-users";
  final String adminDownloadApplicationAPIRoute =
      "api/admin/download-application/";
  final String customDownloadCertificateAPIRoute = "api/download-certificate";
  final String customProducerAPIRoute = "api/producers";
  final String spcbRaiseUserComplaintAPIRoute = "api/spcb/raise-user-complaint";
  final String spcbGetAllUsersAPIRoute = "api/spcb/get-all-users/";

  // WEB URLs
  final String forgotPasswordWebUrl = "forgotPassword";
}

extension ApiBaseURL on ApiEnvironments {
  String get baseUrl {
    switch (this) {
      case ApiEnvironments.dev:
        return "https://dev-cpcb-tyre.writso.com/";
      case ApiEnvironments.qa:
        return "https://qa2-cpcb-tyre.writso.com/";
      case ApiEnvironments.prod:
        return "PROD BASE URL";
    }
  }
}
