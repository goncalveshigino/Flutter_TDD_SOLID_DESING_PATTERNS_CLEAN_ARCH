import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/data.dart';


class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AuthorizeHttpClientDecorator({@required this.fetchSecureCacheStorage});
  
  Future<void> request() async {
     await fetchSecureCacheStorage.fetchSecure('token');
  }
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}
void main() {

  test('Should call FetchSecureCacheStorage with correct key',() async {
     final fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
     final sut = AuthorizeHttpClientDecorator(fetchSecureCacheStorage: fetchSecureCacheStorage);

     await sut.request();

     verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });
}