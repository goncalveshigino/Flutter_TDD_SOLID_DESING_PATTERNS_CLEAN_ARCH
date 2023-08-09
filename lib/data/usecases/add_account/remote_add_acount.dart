import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/data.dart';
import 'package:meta/meta.dart';


import '../../../domain/domain.dart';
import '../../http/http.dart';


class RemoteAddAcount {

  final HttpClient httpClient;
  final String url;

  RemoteAddAcount({
    @required this.httpClient,
    @required this.url
  });
  
  @override
  Future<void> add(AddAcountParams params) async {
    final body = RemoteAddAcountParams.fromDomain(params).toJson();
    try {
      await httpClient.request(url: url, method: 'post', body: body );
    } on HttpError {
      throw DomainError.unexpected;
    }
  }


}


class RemoteAddAcountParams {

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddAcountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation
  });

  factory RemoteAddAcountParams.fromDomain(AddAcountParams params) =>
      RemoteAddAcountParams(
        name: params.name,
        email: params.email,
        password: params.password,
        passwordConfirmation: params.passwordConfirmation
      );

  Map toJson() => {'name': name, 'email': email, 'password': password, 'passwordConfirmation': passwordConfirmation, };
}


