

import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';



Widget makeLoginPage() {
  return LoginPage(makeLoginPresenter());
}


  // const url = 'http://fordevs.herokuapp.com/api/login';
  // final client = Client();
  // final httpAdapter = HttpAdapter(client);
  // final remoteAuthentication = RemoteAuthentication(
  //   httpClient: httpAdapter,
  //    url: url,
  // );
  // final validationComposite = ValidationComposite([
  //   RequiredFieldValidation('email'),
  //   EmailValidation('email'),
  //   RequiredFieldValidation('password')
  // ]);
  // final streamLoginPresenter = StreamLoginPresenter(
  //   authentication: remoteAuthentication, 
  //   validation: validationComposite
  // );