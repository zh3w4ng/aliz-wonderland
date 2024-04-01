// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/story_new_view.dart';

import 'story_new_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User])
void main() {
  MaterialApp buildMaterialApp(
      {required CollectionReference stories,
      required AppStateProvider appStateProvider}) {
    return MaterialApp(
        title: 'Firestore Example',
        home: ChangeNotifierProvider(
            create: (context) => appStateProvider,
            builder: (context, _) =>
                Scaffold(body: StoryNewView(stories: stories))));
  }

  testWidgets('Story New - logged out', (WidgetTester tester) async {
    final appStateProvider =
        AppStateProvider(auth: MockFirebaseAuth(), appState: AppState());
    final stories = FakeFirebaseFirestore().collection('stories');
    await tester.pumpWidget(
        buildMaterialApp(stories: stories, appStateProvider: appStateProvider));
    await tester.pump();
    expect(find.byType(AppFlowyEditor), findsOne);
    expect(find.byKey(const Key('iconbutton-publish')), findsNothing);
  });

  testWidgets('Story New - logged in', (WidgetTester tester) async {
    final appState = AppState();
    appState.user = MockUser();
    final appStateProvider =
        AppStateProvider(auth: MockFirebaseAuth(), appState: appState);
    final stories = FakeFirebaseFirestore().collection('stories');
    await stories.add({
      'doc': {
        'document': {'children': [], 'type': 'page'}
      },
      'title': 'title1',
      'summary': 'summary1',
      'heroImageUrl': '',
      'updatedAt': Timestamp.now(),
      'published': true
    });

    await stories.get().then((snapshot) => snapshot.docs.first.id);
    await tester.pumpWidget(
        buildMaterialApp(stories: stories, appStateProvider: appStateProvider));
    await tester.pump();
    expect(find.byType(AppFlowyEditor), findsOne);
    expect(find.byKey(const Key('iconbutton-publish')), findsOne);
  });
}
