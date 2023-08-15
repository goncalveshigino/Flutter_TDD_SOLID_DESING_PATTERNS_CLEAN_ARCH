import 'package:meta/meta.dart';

import '../../presentation/presentation.dart';
import '../validation.dart';

class CompareFieldsValidation implements FieldValidation {

  @override
  final String field;
  final String valueToCompare;

  CompareFieldsValidation({ @required this.field, @required this.valueToCompare});

  @override
  ValidationError validate(String value) {
   return ValidationError.invalidField;
  }
}