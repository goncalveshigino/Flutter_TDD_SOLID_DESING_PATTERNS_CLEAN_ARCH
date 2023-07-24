import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../ui/components/app_theme.dart';
import 'factories/factories.dart';





void main() {
  runApp( const App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light );

    return GetMaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: makeLoginPage )
      ],
    );
  }
}

