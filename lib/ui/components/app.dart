import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light );

    final primaryColor = const Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = const Color.fromRGBO(96, 0, 39, 1);
    final primaryColorLight = const Color.fromRGBO(188, 71, 123, 1);


    return   MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor, 
        primaryColorDark: primaryColorDark, 
        primaryColorLight: primaryColorLight,
        secondaryHeaderColor: primaryColor, 
        useMaterial3: true,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 30, 
            fontWeight: FontWeight.bold, 
            color: primaryColorDark
          ), 
        ), 
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide( color: primaryColorLight )
          ), 
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide( color: primaryColor )
          ), 
          alignLabelWithHint: true
        ),
        
      ),
      home: LoginPage(null),
    );
  }
}
