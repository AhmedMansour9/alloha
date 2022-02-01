import 'package:alloha/provider/auth_provider.dart';
import 'package:alloha/provider/localization_provider.dart';
import 'package:alloha/theme/light_theme.dart';
import 'package:alloha/util/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;
import 'helper/router_helper.dart';
import 'localization/app_localization.dart';
import 'util/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<AuthProvider>()),
    ],
    child: MediaQuery(data: MediaQueryData(), child: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static final navigatorKey = new GlobalKey<NavigatorState>();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    RouterHelper.setupRouter();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    Locale language = Provider.of<LocalizationProvider>(context).locale;
    print("language is $language");
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode!, language.countryCode));
    });

    return SafeArea(
      minimum: EdgeInsets.only(top: 20),
      child: MaterialApp(
        color: Colors.white,
        title: language.toString().contains("en_US")
            ? AppConstants.APP_NAME
            : AppConstants.APP_NAMEAR,
        debugShowCheckedModeBanner: false,
        theme: light,
        initialRoute: Routes.getSplash(),
        onGenerateRoute: RouterHelper.router.generator,
        navigatorKey: MyApp.navigatorKey,
        locale: Provider.of<LocalizationProvider>(context).locale,
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: _locals,
        // home: Scaffold(),
      ),
    );
  }
}
