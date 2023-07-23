import '../validation.dart';

class RequiredFieldValidation implements FieldValidation {

  @override
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatorio';
  }

}