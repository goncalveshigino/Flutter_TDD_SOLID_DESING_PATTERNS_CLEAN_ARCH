import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {

  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPresenter({@required this.loadCurrentAccount});

  final _navigateTo = RxString();

  @override
  Stream<String> get navigateToStream => _navigateTo.stream.distinct();

  @override
  Future<void> checkAccount({int durationsInSeconds = 2}) async {
    await Future.delayed( Duration(seconds: durationsInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account.token == null ? '/login' : '/surveys';
    } catch (error) {
      _navigateTo.value = '/login';
    }
  }
}
