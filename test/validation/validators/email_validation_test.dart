import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';




class EmailValidation implements FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

    @override
    String validate(String value) {
      return null;
    }
}


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

}

  //  final  regex = RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");