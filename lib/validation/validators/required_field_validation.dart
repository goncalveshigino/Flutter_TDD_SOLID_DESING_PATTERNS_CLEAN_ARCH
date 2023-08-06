import 'package:equatable/equatable.dart';

import '../../presentation/presentation.dart';
import '../validation.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidation(this.field);

  @override
  ValidationError validate(String value) {
    return value?.isNotEmpty == true ? null : ValidationError.requiredField;
  }
}
