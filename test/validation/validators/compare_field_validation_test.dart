
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presentation.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';





void main() {

  CompareFieldsValidation sut;

  setUp(() {
   sut = CompareFieldsValidation(field: 'any_field', valueToCompare: 'any_value');
  });


  test('Should return error if value are not equal', () {
    expect(sut.validate('Wrong_value'), ValidationError.invalidField);
  });

  test('Should return error if value are equal', () {
    expect(sut.validate('any_value'), null);
  });

}