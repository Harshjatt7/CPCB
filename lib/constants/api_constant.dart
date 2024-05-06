import 'package:cpcb_tyre/constants/enums/api_environments.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';

///[APIRoutes] class will be used to store all the API routes that we will use in the application.
class APIRoutes {
  MessageConstant msg = MessageConstant();

  static String baseUrl = "";

  final String demoRoute = "/api/abc";
}

extension ApiBaseURL on ApiEnvironments {
  String get baseUrl {
    switch (this) {
      case ApiEnvironments.dev:
        return "DEV BASE URL";
      case ApiEnvironments.qa:
        return "QA BASE URL";
      case ApiEnvironments.prod:
        return "PROD BASE URL";
    }
  }
}
