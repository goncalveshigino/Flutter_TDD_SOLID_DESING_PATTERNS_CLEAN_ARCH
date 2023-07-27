import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/helpers/domain_error.dart';
import 'package:meta/meta.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/usecases/usecases.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/entities/entities.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {

  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {

    try {
      await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }

  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {

   LocalSaveCurrentAccount sut;
   SaveSecureCacheStorageSpy saveSecureCacheStorage;
   AccountEntity account;

  setUp((){
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });


  test('Sould call SaveSecureCacheStorage with correct values', () async {

    await sut.save(account);

    verify(saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });


   test('Sould throw UnexpectedError if SaveSecureCacheStorage throws', () async {

    when(saveSecureCacheStorage.saveSecure(key: anyNamed('key'), value: anyNamed('value')))
      .thenThrow(Exception());

    final future = sut.save(account);

   expect(future, throwsA(DomainError.unexpected));
  });
}
