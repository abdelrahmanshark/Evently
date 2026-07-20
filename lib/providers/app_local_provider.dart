import 'package:flutter/material.dart';

class AppLocalProvider extends ChangeNotifier {
  String appLocal = 'en';

  void changeLanguage(String newLanguage) {
    if (appLocal == newLanguage) {
      return;
    }
    appLocal = newLanguage;
    notifyListeners();
  }
}
