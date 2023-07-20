

abstract class LoginPresenter {
  Stream emailErrorStream;
  Stream passwordErrorStream;
  
  void validateEmail(String email);
  void validatePassword(String password);

 
}