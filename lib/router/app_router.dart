import 'package:cpcb_tyre/views/screens/admin/admin_application_received_screen.dart';
import 'package:cpcb_tyre/views/screens/auth/login_screen.dart';
import 'package:cpcb_tyre/views/screens/onboarding/splash_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/procurement_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/recycler_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/recycler/recycler_home_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/procurement_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/retreaded_add_data_screen.dart';
import 'package:cpcb_tyre/views/screens/retrader/retreader_home_screen.dart';
import 'package:flutter/material.dart';
import '../constants/routes_constant.dart';
import '../views/screens/admin/admin_homescreen.dart';
import '../views/screens/producer/producer_home_screen.dart';
import '../views/screens/producer/sales_data_screen.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash Screen
      case AppRoutes.splashScreenRoute:
        return _getPageRoute(const SplashScreen(), settings);
      case AppRoutes.loginScreenRoute:
        return _getPageRoute( LoginScreen(), settings);
      case AppRoutes.producerHomeScreenRoute:
        return _getPageRoute(const ProducerHomeScreen(), settings);
      case AppRoutes.retraderHomeScreenRoute:
        return _getPageRoute(
          const RetraderHomeScreen(),
          settings,
        );
      case AppRoutes.addSalesDataScreenRoute:
        return _getPageRoute( SalesDataScreen(), settings);
      case AppRoutes.procurementAddDataScreenRoute:
        return _getPageRoute( ProcurementAddDataScreen(), settings);
      case AppRoutes.retreadedAddDataScreenRoute:
        return _getPageRoute( RetreadedAddDataScreen(), settings);
      case AppRoutes.recyclerHomeScreenRoute:
        return _getPageRoute(const RecyclerHomeScreen(), settings);
      case AppRoutes.recyclerAddDataScreenRoute:
        return _getPageRoute( RecyclerAddDataScreen(), settings);
      case AppRoutes.recyclerProcurementAddDataScreenRoute:
        return _getPageRoute(
             RecyclerProcurementAddDataScreen(), settings);
      case AppRoutes.adminHomeScreenRoute:
        return _getPageRoute(const AdminHomeScreen(), settings);
      case AppRoutes.adminApplicationReceivedRoute:
        return _getPageRoute(const AdminApplicationReceivedScreen(), settings);

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
