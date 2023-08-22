import 'package:flutter/material.dart';
import 'package:http/http.dart';


import '../../../../ui/pages/pages.dart';
import '../../factories.dart';



Widget makeLoginPage() {
  return LoginPage(makeGetxLoginPresenter());
}


