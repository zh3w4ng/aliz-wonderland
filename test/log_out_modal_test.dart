// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:mocktail/mocktail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/log_out_modal.dart';
import 'log_out_modal_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  MaterialApp buildMaterialApp({required FirebaseAuth auth}) {
    return MaterialApp(
        title: 'Firestore Example',
        home: ChangeNotifierProvider(
            create: (context) => AppStateProvider(auth: auth),
            builder: (context, _) => Scaffold(body: LogOutModal())));
  }

  testWidgets('Logout Modal - auth fail', (WidgetTester tester) async {
    final auth = MockFirebaseAuth();

    when(auth.signOut())
        .thenThrow(FirebaseAuthException(code: 'code', message: 'error message'));

    await tester.pumpWidget(buildMaterialApp(auth: auth));

    // Click Okay button to logout
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.text('error message'), findsOne);
  });

  testWidgets('Logout Modal - auth success', (WidgetTester tester) async {
    final user = MockUser();
    final auth = MockFirebaseAuth();
    final credential = MockUserCredential();

    when(credential.user).thenReturn(user);
    when(auth.signOut()).thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(buildMaterialApp(auth: auth));

    // Click Okay button to logout
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.text('Logged out successfully.'), findsOne);
  });
}
