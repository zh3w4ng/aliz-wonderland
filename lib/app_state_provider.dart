import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppStateProvider extends ChangeNotifier {
  String title = 'aliZ in Wonderland';
  ThemeMode themeMode = ThemeMode.system;
  User? user;

  void toggleThemeMode(bool dark) {
    themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> logIn({required String email,required String password}) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      user = value.user;
      notifyListeners();
    });
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
  }

  bool loggedIn() {
    return user != null;
  }

  String username() {
    if (user != null && user!.displayName != null) {
      return user!.displayName!;
    } else {
      return '';
    }
  }
}
