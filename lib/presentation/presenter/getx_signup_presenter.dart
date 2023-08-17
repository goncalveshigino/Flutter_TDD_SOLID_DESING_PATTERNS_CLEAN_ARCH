import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/signup/signup_presenter.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';
import '../presentation.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  final _emailError = Rx<UIError>();
  final _nameError = Rx<UIError>();
  final _mainError = Rx<UIError>();
  final _passwordError = Rx<UIError>();
  final _passwordConfirmationError = Rx<UIError>();
  final _navigateTo = RxString();
  final _isFormValid = false.obs;
  final _isLoading = false.obs;

  String _name;
  String _email;
  String _password;
  String _passwordConfirmation;

  @override
  Stream<UIError> get nameErrorStream => _nameError.stream.distinct();
  @override
  Stream<UIError> get emailErrorStream => _emailError.stream.distinct();
  @override
  Stream<UIError> get mainErrorStream => _mainError.stream.distinct();
  @override
  Stream<UIError> get passwordErrorStream => _passwordError.stream.distinct();
  @override
  Stream<UIError> get confirmPasswordErrorStream =>
      _passwordConfirmationError.stream.distinct();
  @override
  Stream<String> get navigateToStream => _navigateTo.stream.distinct();
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream.distinct();

  GetxSignUpPresenter({
    @required this.addAccount,
    @required this.validation,
    @required this.saveCurrentAccount,
  });

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField('name');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation,
    };
    final error = validation.validate(field: field, input: formData);

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
    try {
      _mainError.value = null;
      _isLoading.value = true;

      final account = await addAccount.add(AddAcountParams(
        name: _name,
        email: _email,
        password: _password,
        passwordConfirmation: _passwordConfirmation,
      ));

      await saveCurrentAccount.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse:
          _mainError.value = UIError.emailInUse;
          break;
        default:
          _mainError.value = UIError.unexpected;
      }
      _isLoading.value = false;
    }
  }

  @override
  void goToLogin() {
    _navigateTo.value = '/login';
  }
}
