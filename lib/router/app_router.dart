import 'package:cpcb_tyre/models/response/auditor/recycler/recycler_form4_response_model.dart';
import 'package:cpcb_tyre/models/screen_or_widegt_arguments/user_type_and_summary.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_application_received_screen.dart';
import 'package:cpcb_tyre/views/screens/admin/admin_summary_screen.dart';
import 'package:cpcb_tyre/views/screens/auditor/producer_form/producer_stepper_form.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_detail_view_entries_screen.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/recycler_procurement_list.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/reycler_stepper_form.dart';
import 'package:cpcb_tyre/views/screens/auth/login_screen.dart';
import 'package:cpcb_tyre/views/screens/custom/custom_home_screen.dart';
import 'package:cpcb_tyre/views/screens/onboarding/splash_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/procurement_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/recycler_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/recycler_home_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/procurement_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/retreaded_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/retreader_home_screen.dart';
import 'package:cpcb_tyre/views/screens/spcb/spcb_home_screen.dart';
import 'package:flutter/material.dart';
import '../constants/routes_constant.dart';
import '../models/response/auditor/recycler/recycler_form3_reponse_model.dart';
import '../views/screens/admin/admin_homescreen.dart';
import '../views/screens/auditor/auditor_home_screen.dart';
import '../views/screens/producer/producer_home_screen.dart';
import '../views/screens/producer/sales_data_screen.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash Screen
      case AppRoutes.splashScreenRoute:
        return _getPageRoute(SplashScreen(), settings);
      case AppRoutes.loginScreenRoute:
        return _getPageRoute(LoginScreen(), settings);
      case AppRoutes.producerHomeScreenRoute:
        return _getPageRoute(const ProducerHomeScreen(), settings);
      case AppRoutes.retraderHomeScreenRoute:
        return _getPageRoute(
          RetraderHomeScreen(),
          settings,
        );
      case AppRoutes.addSalesDataScreenRoute:
        return _getPageRoute(SalesDataScreen(), settings);
      case AppRoutes.procurementAddDataScreenRoute:
        return _getPageRoute(ProcurementAddDataScreen(), settings);
      case AppRoutes.retreadedAddDataScreenRoute:
        return _getPageRoute(RetreadedAddDataScreen(), settings);
      case AppRoutes.recyclerHomeScreenRoute:
        return _getPageRoute(RecyclerHomeScreen(), settings);
      case AppRoutes.recyclerAddDataScreenRoute:
        return _getPageRoute(RecyclerAddDataScreen(), settings);
      case AppRoutes.recyclerProcurementAddDataScreenRoute:
        return _getPageRoute(RecyclerProcurementAddDataScreen(), settings);
      case AppRoutes.adminHomeScreenRoute:
        return _getPageRoute(AdminHomeScreen(), settings);
      case AppRoutes.adminApplicationReceivedRoute:
        String userType = settings.arguments as String;
        return _getPageRoute(
            AdminApplicationReceivedScreen(
              userType: userType,
            ),
            settings);
      case AppRoutes.adminSummaryScreenRoute:
        return _getPageRoute(const AdminSummaryScreen(), settings);
      case AppRoutes.spcbHomeScreenRoute:
        return _getPageRoute(SpcbHomeScreen(), settings);
      case AppRoutes.customHomeScreenRoute:
        return _getPageRoute(const CustomHomeScreen(), settings);
      case AppRoutes.auditorHomeScreen:
        return _getPageRoute(AuditorHomeScreen(), settings);
      case AppRoutes.auditorRecyclerProcurementScreen:
        List<ProcurementDatum> procurementData =
            settings.arguments as List<ProcurementDatum>;
        return _getPageRoute(
            RecyclerProcurementList(
              //viewModel: viewModel,
              procurementData: procurementData,
            ),
            settings);
      case AppRoutes.auditorRecyclerDetailScreen:
        List<EprDatum> eprData = settings.arguments as List<EprDatum>;
        return _getPageRoute(
            RecyclerDetailScreen(
              eprData: eprData,
            ),
            settings);
      case AppRoutes.auditorProducerStepperScreen:
        CheckUserAndSummaryScreen userDetails =
            settings.arguments as CheckUserAndSummaryScreen;
        return _getPageRoute(
            ProducerStepper(userDetails: userDetails), settings);
      case AppRoutes.auditorRecyclerStepperScreen:
        CheckUserAndSummaryScreen userDetails =
            settings.arguments as CheckUserAndSummaryScreen;
        return _getPageRoute(
            RecyclerStepper(userDetails: userDetails), settings);

      // Will be displayed if no specified route is found.
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text('The Page ${settings.name} does not exists.'),
            ),
          ),
        );
    }
  }

  static PageRoute _getPageRoute(Widget child, RouteSettings settings) {
    return _FadeRoute(
        child: child, routeName: settings.name!, arguments: settings.arguments);
  }
}

class _FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;
  final Object? arguments;

  _FadeRoute({this.child, this.routeName, this.arguments})
      : super(
          settings: RouteSettings(name: routeName, arguments: arguments),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            // Turned off animation
            opacity: const AlwaysStoppedAnimation<double>(1),
            // replace above with 'animation' to enable fade animation
            child: child,
          ),
        );
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    required RouteSettings super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var animation1 = Tween(begin: 0.0, end: 0.0).animate(animation);

    final theme = Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions<T>(
      this,
      context,
      animation1,
      secondaryAnimation,
      child,
    );
  }
}
