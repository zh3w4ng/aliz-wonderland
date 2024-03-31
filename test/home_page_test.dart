// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:wonderland/app_state.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/companies_swiper.dart';
import 'package:wonderland/home_page.dart';
import 'package:wonderland/name_card.dart';
import 'package:wonderland/tools_word_cloud.dart';

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
            builder: (context, _) => Scaffold(
                body: HomePage(
                    stories: stories, appStateProvider: appStateProvider))));
  }

  testWidgets('HomePage - load', (WidgetTester tester) async {
    await tester.pumpWidget(buildMaterialApp(
        stories: FakeFirebaseFirestore().collection('stories'),
        appStateProvider:
            AppStateProvider(auth: MockFirebaseAuth(), appState: AppState())));
    await tester.pump();
    expect(find.byType(NameCard), findsOne);
    expect(find.byType(CompaniesSwiper), findsOne);
  });
}
