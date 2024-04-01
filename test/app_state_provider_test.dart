import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wonderland/app_state.dart';
import 'package:wonderland/app_state_provider.dart';

import 'app_state_provider_test.mocks.dart';

@GenerateMocks([FirebaseAuth])
void main() {
  test('AppStateProvider - toggleThemeMode', () {
    final auth = MockFirebaseAuth();
    final appStateProvider = AppStateProvider(auth: auth, appState: AppState());

    appStateProvider.toggleThemeMode(true);
    expect(appStateProvider.appState.themeMode, ThemeMode.dark);

    appStateProvider.toggleThemeMode(false);
    expect(appStateProvider.appState.themeMode, ThemeMode.light);
  });

  test('AppStateProvider - goToStory', () {
    final auth = MockFirebaseAuth();
    final appStateProvider = AppStateProvider(auth: auth, appState: AppState());

    appStateProvider.goToStory(docId: 'someId', editable: true);

    expect(appStateProvider.appState.docId, 'someId');
    expect(appStateProvider.appState.editable, true);

    appStateProvider.goToStory(docId: 'someOtherId', editable: false);

    expect(appStateProvider.appState.docId, 'someOtherId');
    expect(appStateProvider.appState.editable, false);
  });

  test('AppStateProvider - goToNonStory', () {
    final auth = MockFirebaseAuth();
    final appStateProvider = AppStateProvider(auth: auth, appState: AppState());

    appStateProvider.goToNonStory(index: 0);
    expect(appStateProvider.appState.navigationIndex, 0);
    appStateProvider.goToNonStory(index: 1);
    expect(appStateProvider.appState.navigationIndex, 1);
    appStateProvider.goToNonStory(index: 2);
    expect(appStateProvider.appState.navigationIndex, 2);
    appStateProvider.goToNonStory(index: 3);
    expect(appStateProvider.appState.navigationIndex, 0);

    appStateProvider.goToNonStory(tab: 'home');
    expect(appStateProvider.appState.navigationIndex, 0);
    appStateProvider.goToNonStory(tab: 'experience');
    expect(appStateProvider.appState.navigationIndex, 1);
    appStateProvider.goToNonStory(tab: 'stories');
    expect(appStateProvider.appState.navigationIndex, 2);
    appStateProvider.goToNonStory(tab: 'others');
    expect(appStateProvider.appState.navigationIndex, 0);
  });
}
