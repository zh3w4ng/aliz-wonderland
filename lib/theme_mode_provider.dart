import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void toggleThemeMode(bool dark) {
    themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
