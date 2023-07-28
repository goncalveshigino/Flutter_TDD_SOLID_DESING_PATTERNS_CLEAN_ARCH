

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/usecases/usecases.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/domain/entities/entities.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/presentation/presenter/presenter.dart';



class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  GetxSplashPresenter sut;
  LoadCurrentAccountSpy loadCurrentAccount;

  PostExpectation mockLoadCurrentAccountCall() =>
      when(loadCurrentAccount.load());

  void mockLoadCurrentAccount({AccountEntity account}) {
    mockLoadCurrentAccountCall().thenAnswer((_) async => account);
  }

  void mockLoadCurrentAccountError() {
    mockLoadCurrentAccountCall().thenThrow((Exception()));
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });
  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to Surveys page on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });

  test('Should go to Login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

  test('Should go to Login page on error ', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
}
