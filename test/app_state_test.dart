import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wonderland/app_state.dart';

import 'app_state_test.mocks.dart';

@GenerateMocks([User])
void main() {
  test('AppState - default properties', () {
    final appState = AppState();

    expect(appState.title, 'aliZ in Wonderland');
    expect(appState.themeMode, ThemeMode.system);
    expect(appState.navigationIndex, 0);
    expect(appState.user, null);
    expect(appState.docId, null);
    expect(appState.username(), '');
    expect(appState.loggedIn(), false);
  });

  test('AppState - logged user', () {
    final appState = AppState();
    final mockUser = MockUser();
    appState.user = mockUser;
    when(mockUser.displayName).thenReturn('Aliz');
    expect(appState.username(), 'Aliz');
    expect(appState.loggedIn(), true);
  });
}