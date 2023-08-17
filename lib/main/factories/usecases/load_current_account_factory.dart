
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/data/usecases/use_cases.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/usecases/usecases.dart';

import '../factories.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(
    fetchSecureCacheStorage: makeLocalStorageAdapter()
  );
}