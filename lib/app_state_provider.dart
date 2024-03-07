import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state.dart';

class AppStateProvider extends ChangeNotifier {
  AppState appState = AppState();

  void toggleThemeMode(bool dark) {
    appState.themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void navigate({required int? index}) {
    appState.navigationIndex = index;
    notifyListeners();
  }

  void goToStory({required String? docId, required bool editable}) {
    if (docId != null) {
      appState.navigationIndex = null;
      appState.docId = docId;
      appState.editable = editable;
      notifyListeners();
    }
  }

  Future<void> logIn({required String email, required String password}) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      appState.user = value.user;
      notifyListeners();
    });
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    appState.user = null;
    notifyListeners();
  }
}
