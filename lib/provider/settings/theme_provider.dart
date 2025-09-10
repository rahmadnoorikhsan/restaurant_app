import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/settings_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SettingsPreference themePreference;

  ThemeProvider({required this.themePreference}) {
    _getTheme();
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void _getTheme() async {
    final savedTheme = await themePreference.getTheme();
    switch (savedTheme) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) async {
    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      default:
        themeString = 'system';
        break;
    }

    await themePreference.setTheme(themeString);
    _getTheme();
  }
}