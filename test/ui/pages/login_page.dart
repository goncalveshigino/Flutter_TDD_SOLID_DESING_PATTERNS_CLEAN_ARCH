import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_arch_solid_desin_patterns/ui/pages/pages.dart';

void main() {

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
     final loginPage = MaterialApp( home: LoginPage(),);
     await tester.pumpWidget(loginPage);

     final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));

     expect(emailTextChildren, findsOneWidget);
  });
}