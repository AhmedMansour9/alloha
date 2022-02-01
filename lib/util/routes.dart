import 'dart:convert';


class Routes {

  static const String SPLASH_SCREEN = '/splash';
  static const String LOGIN_SCREEN = '/login';
  static const String REGISTER_SCREEN = '/register';
  static const String LANGUAGE_SCREEN = '/select-language';
  static const String ONBOARDING_SCREEN = '/onboarding';

 static String getSplash() => SPLASH_SCREEN;
 static String getLogin() => LOGIN_SCREEN;
 static String getSignUpRoute() => REGISTER_SCREEN;

}