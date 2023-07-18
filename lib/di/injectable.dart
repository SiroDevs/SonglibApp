import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/songlib_db.dart';
import '../repository/secure_storage/secure_storage.dart';
import '../utils/env/flavor_config.dart';
import 'db/setup_drift_none.dart'
    if (dart.library.io) 'db/setup_drift_io.dart'
    if (dart.library.js) 'db/setup_drift_web.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  generateForDir: ['lib'],
)
Future<void> configureDependencies(String environment) async {
  // ignore: avoid_print
  print('Using environment: $environment');
  await $initGetIt(getIt, environment: environment);
  await getIt.allReady();
}

@module
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<SharedPreferences> prefs() {
    if (FlavorConfig.isInTest()) {
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues(<String, Object>{});
    }
    return SharedPreferences.getInstance();
  }

  @lazySingleton
  SharedPreferenceStorage sharedPreferences(SharedPreferences preferences) =>
      SharedPreferenceStorage(preferences);

  @singleton
  ConnectivityHelper connectivityHelper() => ConnectivityHelper();

  @singleton
  @preResolve
  Future<DatabaseConnection> provideDatabaseConnection() {
    return createDriftDatabaseConnection('songlibDatabase');
  }

  @lazySingleton
  FlutterSecureStorage storage() => const FlutterSecureStorage();

  @lazySingleton
  SimpleKeyValueStorage keyValueStorage(
      SharedPreferenceStorage preferences, SecureStorage secure) {
    if (kIsWeb) return preferences;
    return secure;
  }

  @lazySingleton
  SongLibDB provideSongLibDB(DatabaseConnection databaseConnection) =>
      SongLibDB.connect(databaseConnection);
}

dynamic _parseAndDecode(String response) => jsonDecode(response);

dynamic parseJson(String text) =>
    compute<String, dynamic>(_parseAndDecode, text);
