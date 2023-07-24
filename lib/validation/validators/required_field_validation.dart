import 'package:equatable/equatable.dart';

import '../validation.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidation(this.field);

  @override
  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatorio';
  }
}
