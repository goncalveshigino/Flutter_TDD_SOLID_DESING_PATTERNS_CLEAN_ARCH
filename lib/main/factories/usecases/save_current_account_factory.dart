import '../../../data/usecases/use_cases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';



SaveCurrentAccount makeLocalSaveCurrentAccount() {
  return LocalSaveCurrentAccount(
    saveSecureCacheStorage: makeLocalStorageAdapter()
  );

}