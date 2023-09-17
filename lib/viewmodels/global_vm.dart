import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../repository/local_storage.dart';
import '../utils/constants/pref_constants.dart';

@singleton
class AppVm with ChangeNotifier {
  final LocalStorage localStorage;

  TargetPlatform? targetPlat;

  AppVm(this.localStorage);

  //ThemeMode get themeMode => FlavorConfig.instance.themeMode;
  TargetPlatform? get targetPlatform => targetPlat;

  bool wakeLockStatus = false;
  bool slideHorizontal = false;
  bool get isDarkMode => localStorage.getPrefBool(PrefConstants.darkModeKey);
  String get timeInstalled =>
      localStorage.getPrefString(PrefConstants.dateInstalledKey);

  Future<void> init(BuildContext context) async {
    //FlavorConfig.instance.themeMode = localStorage.getThemeMode();
    wakeLockStatus = localStorage.getPrefBool(PrefConstants.wakeLockCheckKey);
    notifyListeners();
  }

  Future<void> setDarkMode(bool val) async {
    localStorage.setPrefBool(PrefConstants.darkModeKey, val);
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    //FlavorConfig.instance.themeMode = themeMode;
    notifyListeners();
    await localStorage.updateThemeMode(themeMode);
  }

  Future<void> updateWakeLockStatus(bool wakeLock) async {
    wakeLockStatus = wakeLock;
    notifyListeners();
    localStorage.setPrefBool(PrefConstants.wakeLockCheckKey, wakeLock);
  }

  Future<void> updateSlideHorizontal(bool slideDirection) async {
    slideHorizontal = slideDirection;
    notifyListeners();
    localStorage.setPrefBool(PrefConstants.slideHorizontalKey, slideDirection);
  }

  String getCurrentPlatform() {
    if (targetPlatform == TargetPlatform.android) {
      return 'Android';
    } else if (targetPlatform == TargetPlatform.iOS) {
      return 'Ios';
    }
    return 'System Default';
  }

  /*String getAppearanceValue() {
    switch (FlavorConfig.instance.themeMode) {
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.light:
        return 'Light';
      default:
        return 'System';
    }
  }*/
}
