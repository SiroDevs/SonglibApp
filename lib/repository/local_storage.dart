import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/pref_constants.dart';
import '../model/base/book.dart';
import '../model/base/draft.dart';
import '../model/base/listed.dart';
import '../model/base/songext.dart';

@lazySingleton
abstract class LocalStorage {
  @factoryMethod
  factory LocalStorage(SharedPreferences preferences) = AppLocalStorage;

  ThemeMode getThemeMode();
  
  Listed? listed;
  SongExt? song;
  Draft? draft;
  Book? book;

  Future<void> updateThemeMode(ThemeMode themeMode);

  bool getPrefBool(String settingsKey);
  int getPrefInt(String settingsKey);
  String getPrefString(String settingsKey);

  void setPrefBool(String settingsKey, bool settingsValue);
  void setPrefInt(String settingsKey, int settingsValue);
  void setPrefString(String settingsKey, String settingsValue);

  void clearData();
}

class AppLocalStorage implements LocalStorage {
  final SharedPreferences sharedPreferences;

  AppLocalStorage(this.sharedPreferences);

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await sharedPreferences.setString(
        PrefConstants.appearanceThemeKey, themeMode.toString());
  }

  @override
  ThemeMode getThemeMode() {
    final themeString =
        sharedPreferences.getString(PrefConstants.appearanceThemeKey);
    final theme = ThemeMode.values
        .firstWhere((element) => element.toString() == themeString);
    return theme;
  }

  @override
  void clearData() {
    //sharedPreferences.remove(PrefConstants.isLoggedInKey);
    //sharedPreferences.remove(PrefConstants.emailKey);
  }

  @override
  bool getPrefBool(String settingsKey) {
    return sharedPreferences.getBool(settingsKey) ?? false;
  }

  @override
  int getPrefInt(String settingsKey) {
    return sharedPreferences.getInt(settingsKey) ?? 0;
  }

  @override
  String getPrefString(String settingsKey) {
    return sharedPreferences.getString(settingsKey) ?? '';
  }

  @override
  void setPrefBool(String settingsKey, bool settingsValue) {
    if (!settingsValue) {
      sharedPreferences.remove(settingsKey);
      return;
    }
    sharedPreferences.setBool(settingsKey, settingsValue);
  }

  @override
  void setPrefInt(String settingsKey, int settingsValue) {
    if (settingsValue.isNegative) {
      sharedPreferences.remove(settingsKey);
      return;
    }
    sharedPreferences.setInt(settingsKey, settingsValue);
  }

  @override
  void setPrefString(String settingsKey, String settingsValue) {
    if (settingsValue.isEmpty) {
      sharedPreferences.remove(settingsKey);
      return;
    }
    sharedPreferences.setString(settingsKey, settingsValue);
  }

  @override
  Listed? listed;
  
  @override
  Book? book;
  
  @override
  Draft? draft;
  
  @override
  SongExt? song;
}
