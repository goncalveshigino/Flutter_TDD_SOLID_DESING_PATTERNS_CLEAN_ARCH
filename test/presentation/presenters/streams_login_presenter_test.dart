import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presentation.dart';

// Validar Estream

class ValidationSpy extends Mock implements Validation {}

void main() {

  StreamLoginPresenter sut;
  ValidationSpy validation;
  String email;
  String password;

  PostExpectation mockValidationCall(String field) => 
      when(validation.validate(field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  // Primeiro test com stream
  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');
    
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
     sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));


    sut.validateEmail(email);
    sut.validateEmail(email);
  });


  test('Should emit null if validation succeeds', () {  
     sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
     sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));


     sut.validateEmail(email);
     sut.validateEmail(email);
  });


  test('Should call Validation with correct password', () {
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });


}
