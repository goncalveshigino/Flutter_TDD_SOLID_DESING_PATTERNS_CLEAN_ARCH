import 'dart:ffi';

import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  final  primaryColor = Color.fromRGBO(136, 14, 79, 1);
  final  primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
  final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

  final textTheme = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryColorDark,
    ),
  );
  final  inputDecorationTheme = InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: primaryColorLight,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
      ),
    ),
    alignLabelWithHint: true,
  );
  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    secondaryHeaderColor: primaryColor,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
  );
}
