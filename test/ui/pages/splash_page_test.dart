import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({Key key, @required this.presenter}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();
    
    return Scaffold(
      appBar: AppBar(title: const Text('4Dev')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

abstract class SplashPresenter {
  Future<void> loadCurrentAccount();
}

class SplasePresenterSpy extends Mock implements SplashPresenter {}

void main() {

  SplasePresenterSpy presenter;


  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplasePresenterSpy();
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage(presenter: presenter))
      ],
    ));
  }

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',(WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadCurrentAccount()).called(1);
  });
}
