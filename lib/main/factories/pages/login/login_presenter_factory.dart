


import '../../../../presentation/presentation.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeLoginPresenter() {
  
  
  return StreamLoginPresenter(
    authentication: makeRemoteAuthentication(), 
    validation: makeLoginValidation()
  );
 
}