import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';


import 'package:flutter_tdd_clean_arch_solid_desin_patterns/infra/cache/cache.dart';



class FlutterSecuteStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  LocalStorageAdapter sut;
  FlutterSecuteStorageSpy secureStorage;
  String key;
  String value;

  setUp(() {
    secureStorage = FlutterSecuteStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  void mockSaveSecureError() {
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());
  }

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });

  test('Should throws if save secure throws', () async {
    mockSaveSecureError();

    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
