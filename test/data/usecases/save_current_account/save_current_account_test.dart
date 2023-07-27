import 'package:meta/meta.dart';



import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/data.dart';


import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/helpers/domain_error.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/entities/entities.dart';





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

  void mockError(){ 
    when(saveSecureCacheStorage.saveSecure(key: anyNamed('key'), value: anyNamed('value')))
      .thenThrow(Exception());
  }


  test('Sould call SaveSecureCacheStorage with correct values', () async {

    await sut.save(account);

    verify(saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });


   test('Sould throw UnexpectedError if SaveSecureCacheStorage throws', () async {
      mockError();
      final future = sut.save(account);

       expect(future, throwsA(DomainError.unexpected));
  });

}
