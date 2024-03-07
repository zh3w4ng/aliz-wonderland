import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  final title = 'aliZ in Wonderland';
  var themeMode = ThemeMode.system;
  int? navigationIndex = 0;
  User? user;
  String? docId;
  bool editable = false;
  
  String username() {
    if (user != null && user!.displayName != null) {
      return user!.displayName!;
    } else {
      return '';
    }
  }

  bool loggedIn() {
    return user != null;
  }
}
