import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../presentation.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;

  final _mainError = Rx<UIError>();
  final _passwordError = Rx<UIError>();
  final _emailError = Rx<UIError>();
  final _navigateTo = RxString();

  final _isFormValid = false.obs;
  final _isLoading = false.obs;

  @override
  Stream<UIError> get emailErrorStream => _emailError.stream.distinct();
  @override
  Stream<UIError> get passwordErrorStream => _passwordError.stream.distinct();
  @override
  Stream<UIError> get mainErrorStream => _mainError.stream.distinct();
  @override
  Stream<String> get navigateToStream => _navigateTo.stream.distinct();
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream.distinct();

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount,
  });

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {'email': _email, 'password': _password};
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
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  @override
  Future<void> auth() async {
    try {
      _mainError.value = null;
      _isLoading.value = true;
      final account = await authentication
          .auth(AuthenticationParams(email: _email, password: _password));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          _mainError.value = UIError.invalidCredentials;
          break;
        default:
          _mainError.value = UIError.unexpected;
      }
      _isLoading.value = false;
    }
  }

  @override
  void goToSignUp() {
    _navigateTo.value = '/signup';
  }

  @override
  void dispose() {}
}
