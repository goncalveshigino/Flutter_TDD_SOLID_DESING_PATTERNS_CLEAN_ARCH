import 'dart:async';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/helpers/helpers.dart';
import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/signup/signup.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {

  SignUpPresenter presenter;
  StreamController<UIError> nameErrorController;
  StreamController<UIError> emailErrorController;
  StreamController<UIError> passwordErrorController;
  StreamController<UIError> confirmPasswordErrorController;
  StreamController<UIError> mainErrorController;
  StreamController<String> navigateToController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  void mockStreams() {
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.confirmPasswordErrorStream)
        .thenAnswer((_) => confirmPasswordErrorController.stream);
    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
  }

  void initStreams() {
    presenter = SignUpPresenterSpy();
    nameErrorController = StreamController<UIError>();
    emailErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    confirmPasswordErrorController = StreamController<UIError>();
    mainErrorController = StreamController<UIError>();
    navigateToController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    confirmPasswordErrorController.close();
    mainErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    navigateToController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    initStreams();
    mockStreams();
    final signUpPAge = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage(presenter)),
        GetPage(
          name: '/any_route',
          page: () => const Scaffold(body: Text('fake page')),
        )
      ],
    );
    await tester.pumpWidget(signUpPAge);
  }

  tearDown(() {
    closeStreams();
  });

  // testWidgets('Should load with correct initial state',
  //     (WidgetTester tester) async {
  //   await loadPage(tester);

  //   final nameTextChildren = find.descendant(
  //       of: find.bySemanticsLabel('Nome'), matching: find.byType(Text));
  //   expect(nameTextChildren, findsOneWidget);

  //   final emailTextChildren = find.descendant(
  //       of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
  //   expect(emailTextChildren, findsOneWidget);

  //   final passwordTextChildren = find.descendant(
  //       of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
  //   expect(passwordTextChildren, findsOneWidget);

  //   final passwordconfirmationTextChildren = find.descendant(
  //       of: find.bySemanticsLabel('Confirmar senha'),
  //       matching: find.byType(Text));
  //   expect(passwordconfirmationTextChildren, findsOneWidget);

  //   final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
  //   expect(button.onPressed, null);
  //   expect(find.byType(CircularProgressIndicator), findsNothing);
  // });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.internet.userName();
    await tester.enterText(find.bySemanticsLabel('Nome'), name);
    verify(presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));

    await tester.enterText(find.bySemanticsLabel('Confirmar senha'), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

  testWidgets('Should present email error', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo invalido.'), findsOneWidget);

    emailErrorController.add(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatorio.'), findsOneWidget);

    emailErrorController.add(null);
    await tester.pump();

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should present name error', (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo invalido.'), findsOneWidget);

    nameErrorController.add(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatorio.'), findsOneWidget);

    nameErrorController.add(null);
    await tester.pump();

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Nome'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should present password error', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo invalido.'), findsOneWidget);

    passwordErrorController.add(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatorio.'), findsOneWidget);

    passwordErrorController.add(null);
    await tester.pump();

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should present confirmPassword error',
      (WidgetTester tester) async {
    await loadPage(tester);

    confirmPasswordErrorController.add(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo invalido.'), findsOneWidget);

    confirmPasswordErrorController.add(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatorio.'), findsOneWidget);

    confirmPasswordErrorController.add(null);
    await tester.pump();

    expect(
      find.descendant(
          of: find.bySemanticsLabel('Confirmar senha'),
          matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call signUp on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(presenter.signUp()).called(1);
  });

 
  testWidgets('should handle loading correctly', (WidgetTester tester) async {

    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(null);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    
  });

  testWidgets('Should present error message if signUp fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.emailInUse);
    await tester.pump();

    expect(find.text('O email ja esta em uso'), findsOneWidget);
  });

  testWidgets('Should present error message if signUp throws',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.unexpected);
    await tester.pump();

    expect(find.text('Algo errado aconteceu.Tente novamente em breve'),
        findsOneWidget);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/signup');

    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/signup');
  });


   testWidgets('Should call gotoLogin on link click', (WidgetTester tester) async {
    await loadPage(tester);

    final button = find.text('Login');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(presenter.goToLogin()).called(1);
  });

}
