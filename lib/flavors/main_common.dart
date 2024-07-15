import 'package:cpcb_tyre/controllers/base_api_controllers.dart';
import 'package:cpcb_tyre/views/screens/auditor/recycler_form/reycler_stepper_form.dart';
import 'package:cpcb_tyre/views/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:cpcb_tyre/theme/themes.dart';
import 'package:cpcb_tyre/viewmodels/material_app_viewmodel.dart';
import 'package:cpcb_tyre/views/screens/base_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import '../router/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  Locale? currentLocale = const Locale('en');
  String localeName = "en";
  final _appTheme = AppTheme();

  void setLocale(Locale value) {
    setState(() {
      currentLocale = value;
      localeName = value.languageCode;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Localization directory
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return BaseView<MaterialAppViewModel>(
        onModelReady: (viewmodel) {},
        viewModel: MaterialAppViewModel(),
        builder: (context, viewmodel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CPCB Tyre',
            localizationsDelegates: [
              // delegate from flutter_localization
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              LocalJsonLocalization.delegate,
            ],
            onGenerateRoute: PageRouter.generateRoute,
            theme: _appTheme.lightTheme(context),
            supportedLocales: const [
              Locale('en'),
              Locale('en_GB'),
            ],
            darkTheme: _appTheme.darkTheme(context),
            locale: currentLocale,
            navigatorKey: APIBase.navigatorKey,
            home: SplashScreen(),
          );
        });
  }
}
