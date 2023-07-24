import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presentation.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/validation/validation.dart';


Validation makeLoginValidation() {
  
 return ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ]);

}