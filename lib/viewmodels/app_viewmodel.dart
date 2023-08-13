import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/pref_constants.dart';

@singleton
class AppViewModel extends ChangeNotifier {
  final SharedPreferences sharedPref;

  AppViewModel(this.sharedPref);

  bool get isDarkMode => sharedPref.getBool(PrefConstants.darkModeKey) ?? false;
  bool get isScreenAwake =>
      sharedPref.getBool(PrefConstants.wakeLockCheckKey) ?? false;

  Future<void> init(BuildContext context) async {
    //targetPlat = settingsRepository.getTargetPlatform();
    //FlavorConfig.instance.themeMode = localStorage.getThemeMode();
    notifyListeners();
  }

  void setDarkMode(bool value) {
    sharedPref.setBool(PrefConstants.darkModeKey, value);
    notifyListeners();
  }

  void switchDarkMode() {
    bool val = isDarkMode;
    sharedPref.setBool(PrefConstants.darkModeKey, val);
    notifyListeners();
  }

  void setScreenAwake(bool value) {
    sharedPref.setBool(PrefConstants.wakeLockCheckKey, value);
    notifyListeners();
  }

  void switchScreenAwake() {
    sharedPref.setBool(PrefConstants.wakeLockCheckKey, isScreenAwake);
    notifyListeners();
  }
}
