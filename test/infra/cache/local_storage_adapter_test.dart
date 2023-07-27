import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({@required this.secureStorage});
  @override
  Future<void> saveSecure({@required String key, @required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}

class FlutterSecuteStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  test('Should call save secure with correct values', () async {
    final secureStorage = FlutterSecuteStorageSpy();
    final sut = LocalStorageAdapter(secureStorage: secureStorage);
    final key = faker.lorem.word();
    final value = faker.guid.guid();
    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });
}
