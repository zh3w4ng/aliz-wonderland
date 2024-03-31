import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wonderland/app_state.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider({required this.auth, required this.appState}) : super();

  final FirebaseAuth auth;
  final AppState appState;

  void toggleThemeMode(bool dark) {
    appState.themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void _navigate({required int? index, String? docId, bool? editable}) {
    appState.navigationIndex = index;
    appState.docId = docId;
    appState.editable = editable ?? false;
    notifyListeners();
  }

  void goToNonStory({String? tab, int? index}) {
    final mapping = {
      0: 'home',
      1: 'experience',
      2: 'stories'
    };
    final tabName = tab ?? (mapping[index] ?? 'default');
    switch (tabName) {
      case 'home':
        _navigate(index: 0);
        break;
      case 'experience':
        _navigate(index: 1);
        break;
      case 'stories':
        _navigate(index: 2);
        break;
      default:
        _navigate(index: 0);
    }
  }

  void goToStory({required String? docId, required bool editable}) {
    _navigate(index: null, docId: docId, editable: editable);
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
