import 'package:cpcb_tyre/views/screens/auth/login_page.dart';
import 'package:cpcb_tyre/views/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import '../constants/routes_constant.dart';
import '../views/screens/producer/producer_home_page.dart';
import '../views/screens/producer/sales_data_screen.dart';
import '../views/screens/retrader/retrader_home_screen.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash Screen
      case AppRoutes.splashScreenRoute:
        return _getPageRoute(const SplashScreen(), settings);
      case AppRoutes.loginPageRoute:
        return _getPageRoute(const LoginPage(), settings);
      case AppRoutes.producerHomeScreen:
        return _getPageRoute(const ProducerHomePage(), settings);
      case AppRoutes.addSalesDataScreen:
        return _getPageRoute(const SalesDataScreen(), settings);
      case AppRoutes.retraderHomeScreen:
        return _getPageRoute(const RetraderHomePage(), settings);

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
