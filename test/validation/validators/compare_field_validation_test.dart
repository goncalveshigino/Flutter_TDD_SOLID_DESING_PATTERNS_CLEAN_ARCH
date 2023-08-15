
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presentation.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';





void main() {

  CompareFieldsValidation sut;

  setUp(() {
   sut = CompareFieldsValidation(field: 'any_field', fieldToCompare: 'other_field');
  });


  test('Should return error if value are not equal', () {
    final formData = {'any_field':'any_value', 'other_field': 'other_value'};
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return error if value are equal', () {
    final formData = {'any_field':'any_value', 'other_field': 'any_value'};
    expect(sut.validate(formData), null);
  });

}
