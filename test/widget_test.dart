// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wonderland/app_state_provider.dart';

import 'package:wonderland/log_in_modal.dart';
import 'package:provider/provider.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
void main() {
  testWidgets('Login Modal test', (WidgetTester tester) async {
    await tester.pumpWidget((MaterialApp(
        title: 'Firestore Example',
        home: ChangeNotifierProvider(
            create: (context) => AppStateProvider(),
            builder: (context, _) => LogInModal()))));

    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    expect(find.bySubtype<ElevatedButton>(), findsExactly(2));

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // // Verify that our counter has incremented.
    expect(find.text('Please enter your password'), findsOneWidget);
    expect(find.text('Please enter your email address'), findsOneWidget);
  });
}
