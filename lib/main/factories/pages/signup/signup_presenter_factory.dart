
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/signup/signup_presenter.dart';

import '../../../../presentation/presentation.dart';

import '../../factories.dart';


SignUpPresenter makeGetxSignUpPresenter() {
  return GetxSignUpPresenter(
    addAccount: makeRemoteAddAccount(), 
    validation: makeSignUpValidation(), 
    saveCurrentAccount: makeLocalSaveCurrentAccount()
  );
 
}