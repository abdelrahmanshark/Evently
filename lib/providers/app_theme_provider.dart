import 'package:evently/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider() {
    getThemePreferences();
  }

  Future<void> getThemePreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String theme = pref.getString(SharedPreferencesKay.themeKey) ?? 'light';
    appTheme = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Future<void> setThemePreferences(String newTheme) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(SharedPreferencesKay.themeKey, newTheme);
  }

  Future<void> changeAppTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    await setThemePreferences(newTheme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }
}
