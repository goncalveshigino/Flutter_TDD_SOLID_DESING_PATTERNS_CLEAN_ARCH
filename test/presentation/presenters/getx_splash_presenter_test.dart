import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/splash/splash.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/usecases/usecases.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPresenter({@required this.loadCurrentAccount});

  final _navigateTo = RxString();

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {

  GetxSplashPresenter sut;
  LoadCurrentAccountSpy loadCurrentAccount;

  setUp((){
     loadCurrentAccount = LoadCurrentAccountSpy();
     sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });
  test('Should call LoadCurrentAccount', () async {
 

    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}
