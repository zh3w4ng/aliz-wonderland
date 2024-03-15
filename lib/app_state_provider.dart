import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state.dart';

class AppStateProvider extends ChangeNotifier {
  AppState appState = AppState();

  void toggleThemeMode(bool dark) {
    appState.themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void navigate({required int? index,  String? docId, bool? editable}) {
    appState.navigationIndex = index;
    appState.docId = docId;
    appState.editable = editable ?? false;
    notifyListeners();
  }

  void goToNonStory({required String tab}) {
    switch (tab) {
      case 'home':
        navigate(index: 0);
        break;
      case 'experience':
        navigate(index: 1);
        break;
      case 'stories':
        navigate(index: 2);
        break;
      default:
        navigate(index: 0);
    }
  }

  void goToStory({required String? docId, required bool editable}) {
    navigate(index: null, docId: docId, editable: editable);
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
