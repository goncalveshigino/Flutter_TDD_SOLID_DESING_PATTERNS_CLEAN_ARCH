import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../data/data.dart';
import '../../../../infra/http/http.dart';
import '../../../../presentation/presentation.dart';
import '../../../../ui/pages/pages.dart';
import '../../../../validation/validation.dart';
import '../../factories.dart';



Widget makeLoginPage() {
  return LoginPage(makeGetxLoginPresenter());
}


