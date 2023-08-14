import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';
import '../presentation.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;
  final AddAccount addAccount;

  final _emailError = Rx<UIError>();
  final _nameError = Rx<UIError>();
  final _passwordError = Rx<UIError>();
  final _passwordConfirmationError = Rx<UIError>();
  final _isFormValid = false.obs;

  String _name;
  String _email;
  String _password;
  String _passwordConfirmation;

  Stream<UIError> get nameErrorStream => _nameError.stream.distinct();
  Stream<UIError> get emailErrorStream => _emailError.stream.distinct();
  Stream<UIError> get passwordErrorStream => _passwordError.stream.distinct();
  Stream<UIError> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();

  GetxSignUpPresenter({
    @required this.addAccount,
    @required this.validation,
  });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(
        field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  UIError _validateField({String field, String value}) {
    final error = validation.validate(field: field, value: value);

    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _nameError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _email != null &&
        _name != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  @override
  Future<void> signUp() async {
    await addAccount.add(AddAcountParams(
      name: _name,
      email: _email,
      password: _password,
      passwordConfirmation: _passwordConfirmation,
    ));
  }
}
