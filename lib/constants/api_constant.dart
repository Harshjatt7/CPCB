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
  final String recyclerProcurementDataAPIRoute =
      "api/recycler/get-procuremnt-data";
  final String retreaderDownloadApplicationAPIRoute =
      "api/retreader/download-application";
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
