import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../presentation/presentation.dart';
import '../validation.dart';

class MinLengthValidation extends Equatable implements FieldValidation {

  @override
  final String field;
  final int size;

  List get props => [field, size];

  MinLengthValidation({ @required this.field, @required this.size});

  @override
  ValidationError validate(String value) {
    return value != null && value.length >= size ? null : ValidationError.invalidField;
  }
}