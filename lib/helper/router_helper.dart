import 'dart:convert';

import 'package:alloha/util/routes.dart';
import 'package:alloha/view/screens/auth/login_screen.dart';
import 'package:alloha/view/screens/auth/register_screen.dart';
import 'package:alloha/view/screens/not_found.dart';
import 'package:alloha/view/screens/splash/splash_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

//*******Handlers*********
  static  Handler _splashHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) => SplashScreen());
  static Handler _notFoundHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => NotFound());
  static Handler _loginHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static Handler _registerHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => RegisterScreen());



//*******Route Define*********
  static void setupRouter() {
    router.notFoundHandler=_notFoundHandler;
    router.define(Routes.SPLASH_SCREEN, handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LOGIN_SCREEN, handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.REGISTER_SCREEN, handler: _registerHandler, transitionType: TransitionType.fadeIn);

  }
}