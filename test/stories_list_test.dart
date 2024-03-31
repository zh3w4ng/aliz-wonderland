// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/stories_list.dart';

import 'stories_list_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  User
])
void main() {
  MaterialApp buildMaterialApp(
      {required CollectionReference stories,
      required AppStateProvider appStateProvider}) {
    return MaterialApp(
        title: 'Firestore Example',
        home: ChangeNotifierProvider(
            create: (context) => appStateProvider,
            builder: (context, _) =>
                Scaffold(body: StoriesList(stories: stories))));
  }

  testWidgets('Stories List - logged out', (WidgetTester tester) async {
    // Set up a callback to intercept the platform channel call to update clipboard data.
    tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (message) {
      if (message.method == 'Clipboard.setData') {
        final copiedSnippet = message.arguments['text'] as String;
        return Future.value(copiedSnippet);
      }
      return null;
    });

    final appStateProvider =
        AppStateProvider(auth: MockFirebaseAuth(), appState: AppState());
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
    await stories.add({
      'doc': {
        'document': {'children': [], 'type': 'page'}
      },
      'title': 'title2',
      'summary': 'summary2',
      'heroImageUrl': '',
      'updatedAt': Timestamp.now(),
      'published': false
    });
    await tester.pumpWidget(
        buildMaterialApp(stories: stories, appStateProvider: appStateProvider));
    await tester.pump();
    expect(find.byType(ListTile), findsExactly(2));
    expect(find.byKey(const Key('iconbutton-share')), findsExactly(2));
    await tester.tap(find.byKey(const Key('iconbutton-share')).first);
    await tester.pump();
    expect(
        find.text('Story URL is copied to clipboard successfully.'), findsOne);
  });

  testWidgets('Stories List - logged in', (WidgetTester tester) async {
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
    await stories.add({
      'doc': {
        'document': {'children': [], 'type': 'page'}
      },
      'title': 'title2',
      'summary': 'summary2',
      'heroImageUrl': '',
      'updatedAt': Timestamp.now(),
      'published': false
    });
    await tester.pumpWidget(
        buildMaterialApp(stories: stories, appStateProvider: appStateProvider));
    await tester.pump();

    expect(find.text('title1'), findsOne);
    expect(find.text('summary1'), findsOne);
    expect(find.text('title2 [Draft]'), findsOne);
    expect(find.text('summary2'), findsOne);
    expect(find.byType(ListTile), findsExactly(2));
    expect(find.byKey(const Key('popup-menu-button')), findsExactly(2));

    await tester.tap(find.byKey(const Key('popup-menu-button')).first);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('popup-edit')), findsOne);
    expect(find.byKey(const Key('popup-export')), findsOne);
    expect(find.byKey(const Key('popup-delete')), findsOne);

    await tester.tap(find.byKey(const Key('popup-edit')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('popup-export')), findsNothing);
    expect(find.byKey(const Key('popup-delete')), findsNothing);
    expect(appStateProvider.appState.docId, isNotNull);
    expect(appStateProvider.appState.navigationIndex, null);

  });
}
