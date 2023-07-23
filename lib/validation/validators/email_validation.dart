
import '../validation.dart';

class EmailValidation implements FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

    @override
    String validate(String value) {
      final  regex = RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
      final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
      return isValid ? null : 'Campo invalido';
    }
}