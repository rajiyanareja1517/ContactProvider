import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeThemeProvider extends ChangeNotifier {
  ThemeMode modeTheme = ThemeMode.light;

  void changeThemeMode(int no) {
    if (no == 1) {
      modeTheme = ThemeMode.light;
    } else if (no == 2) {
      modeTheme = ThemeMode.dark;
    } else if (no == 3) {
      modeTheme = ThemeMode.system;
    }
    notifyListeners();
  }
}
