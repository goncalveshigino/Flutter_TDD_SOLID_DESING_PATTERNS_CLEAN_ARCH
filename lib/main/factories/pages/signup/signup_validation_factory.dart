import '../../../../presentation/presentation.dart';
import '../../../../validation/validation.dart';
import '../../../builders/builders.dart';


Validation makeSignUpValidation() => ValidationComposite(makeSignUpValidations());



List<FieldValidation> makeSignUpValidations() {
  return [
    ...ValidationBuilder.field('name').required().min(3).build(),
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().min(3).build(),
    ...ValidationBuilder.field('passwordConfirmation').required().sameAs('password').build()
  ];
}