import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';






void main(){
 EmailValidation sut;

 setUp((){
    sut = EmailValidation('any_field');
 });

  test('Should return null if email is empty',() {
     expect(sut.validate(''), null);
  });


  test('Should return null if email is null',() {
     expect(sut.validate(null), null);
  });

  test('Should return null if email is valid',() {
     expect(sut.validate('gonza@gmail.com'), null);
  });

  test('Should return null if email is invalid',() {
     expect(sut.validate('gonza@gmail'), 'Campo invalido');
  });

}
