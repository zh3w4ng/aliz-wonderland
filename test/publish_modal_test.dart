// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/publish_modal.dart';
import 'publish_modal_test.mocks.dart';

@GenerateMocks([FirebaseAuth, Document, CollectionReference, DocumentReference])
void main() {
  MaterialApp buildMaterialApp(
      {required FirebaseAuth auth,
      required CollectionReference stories,
      required String username,
      required String? docId,
      required String title,
      required String summary,
      required String heroImageUrl,
      required Document document}) {
    return MaterialApp(
        title: 'Firestore Example',
        home: ChangeNotifierProvider(
            create: (context) => AppStateProvider(auth: auth, appState: AppState()),
            builder: (context, _) => Scaffold(
                    body: PublishModal(
                  username: username,
                  stories: stories,
                  docId: docId,
                  document: document,
                  title: title,
                  summary: summary,
                  heroImageUrl: heroImageUrl,
                ))));
  }

  testWidgets('Publish Modal - publish old fail', (WidgetTester tester) async {
    final auth = MockFirebaseAuth();
    final stories = MockCollectionReference();
    const docId = null;
    const username = 'Aliz';
    const title = 'title';
    const summary = 'summary';
    const heroImageUrl =
        'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZbERxv_YEj-TRyjWEQKmfQ.png';
    final document = MockDocument();

    when(document.toJson()).thenReturn({});
    when(stories.add(any)).thenThrow(FirebaseException(
        plugin: 'plugin', code: 'code', message: 'error message'));

    await tester.pumpWidget(buildMaterialApp(
        stories: stories,
        auth: auth,
        username: username,
        docId: docId,
        document: document,
        title: title,
        summary: summary,
        heroImageUrl: heroImageUrl));

    // Click Okay button to publish
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.text('error message'), findsOne);
  });

  testWidgets('Publish Modal - publish new success',
      (WidgetTester tester) async {
    final auth = MockFirebaseAuth();
    final stories = MockCollectionReference();
    final documentReference = MockDocumentReference();
    const docId = null;
    const username = 'Aliz';
    const title = 'title';
    const summary = 'summary';
    const heroImageUrl =
        'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZbERxv_YEj-TRyjWEQKmfQ.png';
    final document = MockDocument();

    when(documentReference.id).thenReturn('newDocId');
    when(document.toJson()).thenReturn({});
    when(stories.add(any)).thenAnswer((_) => Future.value(documentReference));

    await tester.pumpWidget(buildMaterialApp(
        stories: stories,
        auth: auth,
        username: username,
        docId: docId,
        document: document,
        title: title,
        summary: summary,
        heroImageUrl: heroImageUrl));

    // Click Okay button to publish
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.text('Published successfully.'), findsOne);
  });

  testWidgets('Publish Modal - publish new fail', (WidgetTester tester) async {
    final auth = MockFirebaseAuth();
    final documentReference = MockDocumentReference();

    final stories = MockCollectionReference();
    const docId = "docId";
    const username = 'Aliz';
    const title = 'title';
    const summary = 'summary';
    const heroImageUrl =
        'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZbERxv_YEj-TRyjWEQKmfQ.png';
    final document = MockDocument();

    when(document.toJson()).thenReturn({});
    when(documentReference.update(any)).thenThrow(FirebaseException(
        plugin: 'plugin', code: 'code', message: 'error message'));
    when(stories.doc(docId)).thenReturn(documentReference);

    await tester.pumpWidget(buildMaterialApp(
        stories: stories,
        auth: auth,
        username: username,
        docId: docId,
        document: document,
        title: title,
        summary: summary,
        heroImageUrl: heroImageUrl));

    // Click Okay button to publish
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.text('error message'), findsOne);
  });

  testWidgets('Publish Modal - publish old success',
      (WidgetTester tester) async {
    final auth = MockFirebaseAuth();
    final stories = MockCollectionReference();
    final documentReference = MockDocumentReference();
    const docId = 'docId';
    const username = 'Aliz';
    const title = 'title';
    const summary = 'summary';
    const heroImageUrl =
        'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZbERxv_YEj-TRyjWEQKmfQ.png';
    final document = MockDocument();

    when(document.toJson()).thenReturn({});
    when(documentReference.update(any)).thenAnswer((_) => Future.value(null));
    when(stories.doc(docId)).thenReturn(documentReference);

    await tester.pumpWidget(buildMaterialApp(
        stories: stories,
        auth: auth,
        username: username,
        docId: docId,
        document: document,
        title: title,
        summary: summary,
        heroImageUrl: heroImageUrl));

    // Click Okay button to publish
    await tester.tap(find.bySubtype<ElevatedButton>().first);
    await tester.pump();

    // Verify SnackBar which has the error message
    expect(find.text('Published successfully.'), findsOne);
  });
}
