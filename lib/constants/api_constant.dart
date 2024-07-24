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
  final String recyclerDownloadCertificateAPIRoute =
      "api/recycler/download-certificate";
  final String auditorDashboardAPIRoute = "api/auditor/dashboard";
  final String auditorAuditPlanListAPIRoute = "api/auditor/audit-plans";
  final String auditorAuditPlanDetailAPIRoute =
      "api/auditor/audit-plan-details";
  final String auditorProducerForm1ResponseAPIRoute =
      "api/auditor/checklist/producer/company-details";
  final String auditorProducerForm1RequestAPIRoute =
      "api/auditor/checklist/producer/company-details-store";
  final String auditorProducerForm2ResponseAPIRoute =
      "api/auditor/checklist/producer/producer-sales-data";
  final String auditorProducerForm2RequestAPIRoute =
      "api/auditor/checklist/producer/producer-sales-data-store";
  final String auditorProducerForm3RequestAPIRoute =
      "api/auditor/checklist/producer/summary-report-store";
  final String auditorProducerForm3ResponseAPIRoute =
      "api/auditor/checklist/producer/summary-report";

  final String auditorRecyclerForm1APIRoute = "api/auditor/recyclerChecklist";
  final String auditorRecyclerForm2APIRoute =
      "api/auditor/checklist/recycler/processing-capacity";
  final String auditorRecyclerForm3APIRoute =
      "api/auditor/recyclerChecklist/procurement-information";
  final String auditorRecyclerForm4APIRoute =
      "api/auditor/recyclerChecklist/production-information";
  final String auditorRecyclerForm5APIRoute =
      "api/auditor/recyclerChecklist/waste-water-generation-and-disposal";
  final String auditorRetreaderForm1APIRoute =
      "api/auditor/retreaderChecklist";
  final String auditorRetreaderForm2APIRoute =
      "api/auditor/checklist/retreader/processing-capacity";
  final String auditorRetreaderForm3APIRoute =
      "api/auditor/retreaderChecklist/procurement-information";
  final String auditorRetreaderForm4APIRoute =
      "api/auditor/retreaderChecklist/production-information";
  final String auditorRetreaderForm5APIRoute =
      "api/auditor/retreaderChecklist/waste-water-generation-and-disposal";

  final String auditorRecyclerForm1RequestAPIRoute =
      "api/auditor/recyclerChecklist/store-general-information";
  final String auditorRecyclerForm4RequestAPIRoute =
     "api/auditor/retreaderChecklist/store-production-information";
  final String auditorRecyclerForm5RequestAPIRoute =
      "api/auditor/recyclerChecklist/store-waste-water-generation-and-disposal";
  final String auditorRetreaderForm1RequestAPIRoute =
      "api/auditor/retreaderChecklist/store-general-information";
  final String auditorRetreaderForm4RequestAPIRoute =
      "api/auditor/retreaderChecklist/store-production-information";
  final String auditorRetreaderForm5RequestAPIRoute =
      "api/auditor/retreaderChecklist/store-waste-water-generation-and-disposal";
  final String recyclerFileUploadAPIRoute =
      "api/auditor/recyclerChecklist/file-upload/mobile";
  final String retreaderFileUploadAPIRoute =
      "api/auditor/retreaderChecklist/file-upload/mobile";
  final String auditorUploadFileViewer = "api/view-file";
  final String auditorRecyclerForm1PostAPIRoute =
      "api/auditor/recyclerChecklist/store-general-information";
  final String auditorRecyclerForm2PostAPIRoute =
      "api/auditor/checklist/recycler/processing-capacity-store";
  final String auditorRetreaderForm2PostAPIRoute =
      "api/auditor/checklist/retreader/processing-capacity-store";
  final String auditorRecyclerForm3PostAPIRoute =
      "api/auditor/recyclerChecklist/store-procurement-information";
  final String auditorRetreaderForm3PostAPIRoute =
      "api/auditor/retreaderChecklist/store-procurement-information";
  final String auditorPerformAcknowledge = "api/auditor/perform-acknowledge";
  final String auditorStartAcknowlege = "api/auditor/perform-start";

  // WEB URLs
  final String forgotPasswordWebUrl = "forgotPassword";
  final String initiateRegistrationWebUrl = "initiateRegistration";
}

extension ApiBaseURL on ApiEnvironments {
  String get baseUrl {
    switch (this) {
      case ApiEnvironments.dev:
        return "https://dev-cpcb-tyre.writso.com/";
      case ApiEnvironments.qa:
        // return "http://192.168.4.228:8000/";
        return "https://qa2-cpcb-tyre.writso.com/";
      case ApiEnvironments.prod:
        return "PROD BASE URL";
    }
  }
}
