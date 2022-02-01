import 'package:flutter/material.dart';

ThemeData light = ThemeData(

  fontFamily: 'Rubik',
  primaryColor: Color(0xFFFC6A57),
  brightness: Brightness.light,
  cardColor: Colors.white,
  focusColor: Color(0xFFADC4C8),
  // hintColor: Color(0xFF52575C),
  // change the focus border color of the TextField

  colorScheme: ThemeData().colorScheme.copyWith(primary: const Color(0xffdbdbdb)),

  // change the focus border color when the errorText is set
  errorColor: Colors.red,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
    primary: Colors.black, textStyle: TextStyle(color: Colors.black),
  )),
);