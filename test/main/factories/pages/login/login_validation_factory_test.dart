
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';
import 'package:test/test.dart';


import 'package:flutter_tdd_clean_arch_solid_desin_patterns/main/factories/pages/pages.dart';

void main(){


  test('Should return the correct validations',(){
    final validations =  makeLoginValidations();

    expect(validations, [
        RequiredFieldValidation('email'),
        EmailValidation('email'),
        RequiredFieldValidation('password')
    ]);
  });
  
}