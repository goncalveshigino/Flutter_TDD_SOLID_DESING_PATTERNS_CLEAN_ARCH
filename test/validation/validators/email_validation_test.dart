import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presentation.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';






void main(){
 EmailValidation sut;

 setUp((){
    sut = EmailValidation('any_field');
 });

  test('Should return null on invalid case',() {
     expect(sut.validate({}), null);
  });

  test('Should return null if email is empty',() {
     expect(sut.validate({'any_field':''}), null);
  });


  test('Should return null if email is null',() {
     expect(sut.validate({'any_field':null}), null);
  });

  test('Should return null if email is valid',() {
     expect(sut.validate({'any_field':'gonza@gmail.com'}), null);
  });

  test('Should return null if email is invalid',() {
     expect(sut.validate({'any_field':'gonza@gmail'}), ValidationError.invalidField);
  });

}
