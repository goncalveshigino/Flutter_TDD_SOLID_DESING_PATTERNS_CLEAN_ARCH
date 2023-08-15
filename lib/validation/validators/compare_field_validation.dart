import 'package:meta/meta.dart';

import '../../presentation/presentation.dart';
import '../validation.dart';

class CompareFieldsValidation implements FieldValidation {

  @override
  final String field;
  final String fieldToCompare;

  CompareFieldsValidation({ @required this.field, @required this.fieldToCompare});

  @override
  ValidationError validate(Map input) {
   return input[field] == input[fieldToCompare] ? null :  ValidationError.invalidField;
  }
}