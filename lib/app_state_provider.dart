import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider({required this.auth}) : super();

  final FirebaseAuth auth;
  AppState appState = AppState();

  void toggleThemeMode(bool dark) {
    appState.themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void navigate({required int? index, String? docId, bool? editable}) {
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

  Future<String> logIn({required String email, required String password}) {
    try {
      return auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        appState.user = value.user;
        notifyListeners();
        return "";
      });
    } on FirebaseAuthException catch (error) {
      return Future.value(error.message);
    }
  }

  Future<void> logOut() async {
    auth
        .signOut()
        .then((_) => appState.user = null)
        .then((_) => notifyListeners());
  }
}
