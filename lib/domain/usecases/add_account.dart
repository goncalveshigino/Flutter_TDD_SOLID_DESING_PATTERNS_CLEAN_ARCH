import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> auth(AddAcountParams params);
}

class AddAcountParams extends Equatable {
  
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  @override
  List get props => [ name, email, password, passwordConfirmation];

  const AddAcountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation
  });

  
}
