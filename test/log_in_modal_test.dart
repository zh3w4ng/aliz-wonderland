// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/log_in_modal.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  MaterialApp buildMaterialApp({required FirebaseAuth auth}) {
    return MaterialApp(
        title: 'Firestore Example',
        home: ChangeNotifierProvider(
            create: (context) => AppStateProvider(auth: auth),
            builder: (context, _) => Scaffold(body: LogInModal())));
  }

  testWidgets('Login Modal - form validation', (WidgetTester tester) async {
    const email = 'bob@somedomain.com';

    await tester.pumpWidget(buildMaterialApp(auth: MockFirebaseAuth()));

    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Find Username and Password textbox
    expect(find.bySubtype<TextFormField>(), findsExactly(2));

    // Find Okay button and Cancel button
    expect(find.bySubtype<ElevatedButton>(), findsExactly(2));

    // Click Okay button without filling any textbox
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify in-place error messages
    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    await tester.enterText(find.bySubtype<TextFormField>().first, email);

    // Click Okay button without filling Password textbox
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify in-place error messages
    expect(find.text('Please enter your email address'), findsNothing);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Login Modal - auth fail', (WidgetTester tester) async {
    const email = 'bob@somedomain.com';
    const wrongPassword = 'wrongPassword';
    final auth = MockFirebaseAuth();

    when(() => auth.signInWithEmailAndPassword(
            email: email, password: wrongPassword))
        .thenThrow(FirebaseAuthException(code: 'code', message: 'message'));
 
    await tester.pumpWidget(buildMaterialApp(auth: auth));

    // Key in the wrong password
    await tester.enterText(find.byType(TextFormField).first, email);
    await tester.enterText(find.byType(TextFormField).last, wrongPassword);

    // Click Okay button to login
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.byType(SnackBar), findsOne);
  });

  testWidgets('Login Modal - auth success', (WidgetTester tester) async {
    const email = 'bob@somedomain.com';
    const correctPassword = 'correctPassword';
    final user = MockUser();
    final auth = MockFirebaseAuth();
    final credential = MockUserCredential();

    when(() => credential.user).thenReturn(user);
    when(() => auth.signInWithEmailAndPassword(
        email: email,
        password: correctPassword)).thenAnswer((_) => Future.value(credential));

    await tester.pumpWidget(buildMaterialApp(auth: auth));
    // Key in the correct password
    await tester.enterText(find.byType(TextFormField).first, email);
    await tester.enterText(find.byType(TextFormField).last, correctPassword);

    // Click Okay button to login
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.byType(SnackBar), findsNothing);
  });
}
