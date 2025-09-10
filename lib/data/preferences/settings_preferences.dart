import 'package:shared_preferences/shared_preferences.dart';

class SettingsPreference {
  static const String _themeKey = 'theme_mode';
  static const String _reminderKey = 'daily_reminder';

  Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'system';
  }

  Future<void> setTheme(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, value);
  }

  Future<bool> get isDailyReminderActive async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_reminderKey) ?? false;
  }

  Future<void> setDailyReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_reminderKey, value);
  }
}