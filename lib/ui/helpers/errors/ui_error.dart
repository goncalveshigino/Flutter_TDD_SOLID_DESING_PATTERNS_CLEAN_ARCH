enum UIError {
  requiredField, 
  invalidField,
  unexpected, 
  invalidCredentials
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField: return 'Campo obrigatorio.';
      case UIError.invalidField: return 'Campo invalido.';
      case UIError.invalidCredentials: return 'Credencias invalidas.';
      default: return 'Algo errado aconteceu.Tente novamente em breve';
    }
  }
}