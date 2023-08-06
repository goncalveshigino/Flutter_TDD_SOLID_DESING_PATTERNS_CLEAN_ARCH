import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/utils/i18n/resources.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../ui/components/app_theme.dart';
import 'factories/factories.dart';

void main() {
 // R.load(Locale('en', 'US'));
  Provider.debugCheckInvalidValueType = null;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(
            name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(
            name: '/surveys',
            page: () => const Scaffold(body: Center(child: Text('Enquetes'))),
            transition: Transition.fadeIn)
      ],
    );
  }
}
