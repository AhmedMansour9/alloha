import 'dart:async';

import 'package:alloha/util/images.dart';
import 'package:alloha/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 45.0,vertical: 45.0),
        child: Center(
          child: Image.asset(Imagess.logo),
        ),
      ),
      
    );
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white
    ));
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () async {
      Navigator.pushNamedAndRemoveUntil(context, Routes.getLogin(), (route) => false);

    });
  }
}
