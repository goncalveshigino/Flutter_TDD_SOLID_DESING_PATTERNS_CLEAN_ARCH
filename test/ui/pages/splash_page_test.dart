import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/splash/splash.dart';





class SplasePresenterSpy extends Mock implements SplashPresenter {}

void main() {
  
  SplasePresenterSpy presenter;
  StreamController<String> navigateToController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplasePresenterSpy();
    navigateToController = StreamController<String>();
    when(presenter.navigateToStream).thenAnswer((_) => navigateToController.stream);

    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        GetPage(
            name: '/any_route',
            page: () => const Scaffold(body: Text('fake page')))
      ],
    ));
  }

  tearDown(() {
    navigateToController.close();
  });

  testWidgets('Should present spinner on page load', (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.checkAccount()).called(1);
  });

  testWidgets('Should load page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsWidgets);
  });


  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/');


    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/');
  });
}
