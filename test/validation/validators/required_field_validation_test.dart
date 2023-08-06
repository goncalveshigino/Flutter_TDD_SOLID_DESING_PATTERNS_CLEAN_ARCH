import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presentation.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';



void main(){
  
  RequiredFieldValidation sut;

  setUp((){
     sut = RequiredFieldValidation('any_field');
  });


  test('Should return null if value is not empty',(){
     expect(sut.validate('any_value'), null);
  });


  test('Should return null if value is empty',(){
     expect( sut.validate(''), ValidationError.requiredField);
  });


  test('Should return null if value is null',(){
     expect( sut.validate(null), ValidationError.requiredField);
  });

  
}