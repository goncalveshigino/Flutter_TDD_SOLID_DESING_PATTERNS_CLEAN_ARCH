import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../presentation.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/pages.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/helpers/helpers.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/usecases/usecases.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;

  final _mainError = RxString();
  final _passwordError = RxString();
  final _emailError = RxString();

  final _isFormValid = false.obs;
  final _isLoading = false.obs;

  @override
  Stream<String> get emailErrorStream => _emailError.stream.distinct();
  @override
  Stream<String> get passwordErrorStream => _passwordError.stream.distinct();
  @override
  Stream<String> get mainErrorStream => _mainError.stream.distinct();
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream.distinct();

  GetxLoginPresenter(
      {@required this.validation,
      @required this.authentication,
      @required this.saveCurrentAccount});

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password);
    _validateForm();
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
      _isLoading.value = true;
      final account = await authentication.auth(AuthenticationParams(email: _email, password: _password));
      await saveCurrentAccount.save(account);
    } on DomainError catch (error) {
      _mainError.value = error.description;
        _isLoading.value = false;
    }
  }

  @override
  void dispose() {}
}
