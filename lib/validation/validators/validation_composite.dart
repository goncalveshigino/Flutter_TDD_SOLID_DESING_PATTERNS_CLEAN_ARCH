import 'package:meta/meta.dart';

import '../../presentation/presentation.dart';
import '../validation.dart';

class ValidationComposite implements Validation {
  
  final List<FieldValidation> validations;
  ValidationComposite(this.validations);

  @override
  ValidationError validate({@required String field, @required Map input}) {
    ValidationError error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(input);

      if (error != null ) {
        return error;
      }
    }
    return error;
  }
}
