
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/signup/signup.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';



void main() {
 
  Future<void> loadPage(WidgetTester tester) async {
    final signUpPAge = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(
          name: '/signup',
          page: () => const SignUpPage(),
        ),
        GetPage(
          name: '/any_route',
          page: () => const Scaffold(body: Text('fake page')),
        )
      ],
    );
    await tester.pumpWidget(signUpPAge);
  }



  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChildren = find.descendant(
        of: find.bySemanticsLabel('Nome'), matching: find.byType(Text));
    expect(nameTextChildren, findsOneWidget);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final passwordconfirmationTextChildren = find.descendant(
        of: find.bySemanticsLabel('Confirmar senha'), matching: find.byType(Text));
    expect(passwordconfirmationTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });


  // testWidgets('Should close streams on dispose', (WidgetTester tester) async {
  //   await loadPage(tester);

  //   addTearDown(() {
  //     verify(presenter.dispose()).called(1);
  //   });
  // });
}
