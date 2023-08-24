import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../data.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {

  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});
  
  @override
  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token);
    } catch (e) {
      throw (DomainError.unexpected);
    }
  }
}
