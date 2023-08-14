import 'package:get/get.dart';
import 'package:meta/meta.dart';


import '../../ui/helpers/helpers.dart';
import '../presentation.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;




  final _emailError   = Rx<UIError>();
  final _nameError    = Rx<UIError>();
  final _passwordError= Rx<UIError>();
  final _isFormValid  = false.obs;

  Stream<UIError> get nameErrorStream => _nameError.stream.distinct();
  Stream<UIError> get emailErrorStream => _emailError.stream.distinct();
  Stream<UIError> get passwordErrorStream => _passwordError.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();

  GetxSignUpPresenter({
    @required this.validation,
  });

  void validatePassword(String password) {
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }
  
  void validateName(String name) {
    _nameError.value = _validateField(field: 'name', value: name);
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
    _isFormValid.value = false;
  }

  @override
  Future<void> signUp() async {
    
  }
}
