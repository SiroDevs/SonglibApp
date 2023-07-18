import 'package:flutter/material.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/book.dart';
import '../../models/base/draft.dart';
import '../../models/base/listed.dart';
import '../../models/base/songext.dart';
import '../../utils/constants/pref_constants.dart';
import '../secure_storage/auth_storage.dart';

@lazySingleton
abstract class LocalStorage {
  @factoryMethod
  factory LocalStorage(
    AuthStorage storage,
    SharedPreferenceStorage preferences,
  ) = AppLocalStorage;

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
  final AuthStorage authStorage;
  final SharedPreferenceStorage sharedPreferences;

  AppLocalStorage(this.authStorage, this.sharedPreferences);

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await sharedPreferences.saveString(
        key: PrefConstants.appearanceThemeKey, value: themeMode.toString());
  }

  @override
  ThemeMode getThemeMode() {
    final themeString =
        sharedPreferences.getString(PrefConstants.appearanceThemeKey);
    final theme =
        ThemeMode.values.find((element) => element.toString() == themeString);
    return theme ?? ThemeMode.system;
  }

  @override
  void clearData() {
    sharedPreferences.removeValue(key: PrefConstants.selectedBooksKey);
    sharedPreferences.removeValue(key: PrefConstants.predistinatedBooksKey);
  }

  @override
  bool getPrefBool(String settingsKey) {
    return sharedPreferences.getBoolean(settingsKey) ?? false;
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
      sharedPreferences.deleteKey(settingsKey);
      return;
    }
    sharedPreferences.saveBoolean(key: settingsKey, value: settingsValue);
  }

  @override
  void setPrefInt(String settingsKey, int settingsValue) {
    if (settingsValue.isNegative) {
      sharedPreferences.deleteKey(settingsKey);
      return;
    }
    sharedPreferences.saveInt(key: settingsKey, value: settingsValue);
  }

  @override
  void setPrefString(String settingsKey, String settingsValue) {
    if (settingsValue.isEmpty) {
      sharedPreferences.deleteKey(settingsKey);
      return;
    }
    sharedPreferences.saveString(key: settingsKey, value: settingsValue);
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
