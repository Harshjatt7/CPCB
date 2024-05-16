import 'package:cpcb_tyre/constants/enums/api_environments.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';

///[APIRoutes] class will be used to store all the API routes that we will use in the application.
class APIRoutes {
  MessageConstant msg = MessageConstant();

  static String baseUrl = "";

  final String loginAPIRoute = "api/login";
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
