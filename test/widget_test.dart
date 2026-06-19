import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uzhavan_360/main.dart';

void main() {
  testWidgets('shows the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Uzhavan 360'), findsWidgets);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.agriculture_rounded), findsWidgets);
  });
}