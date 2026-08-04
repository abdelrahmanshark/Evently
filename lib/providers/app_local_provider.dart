import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_preferences.dart';

class AppLocalProvider extends ChangeNotifier {
  String appLocal = 'en';

  AppLocalProvider() {
    getLocalPreferences();
  }

  Future<void> getLocalPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    appLocal = pref.getString(SharedPreferencesKay.localKey) ?? 'en';
    notifyListeners();
  }

  Future<void> setLocalPreferences(String newLanguage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(SharedPreferencesKay.localKey, newLanguage);
  }

  void changeLanguage(String newLanguage) async {
    if (appLocal == newLanguage) {
      return;
    }
    appLocal = newLanguage;
    setLocalPreferences(newLanguage);
    notifyListeners();
  }
}
