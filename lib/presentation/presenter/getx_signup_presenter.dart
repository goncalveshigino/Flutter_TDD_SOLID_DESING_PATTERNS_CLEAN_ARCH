import 'package:get/get.dart';
import 'package:meta/meta.dart';


import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../presentation.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;



  final _emailError = Rx<UIError>();
  final _isFormValid = false.obs;

  @override
  Stream<UIError> get emailErrorStream => _emailError.stream.distinct();
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();

  GetxSignUpPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount,
  });

  @override
  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
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
