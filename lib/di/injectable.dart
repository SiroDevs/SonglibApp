import 'dart:convert';
import 'dart:developer' as logger show log;

import 'package:drift/drift.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../db/app_database.dart';
import '../di/db/setup_drift_none.dart'
    if (dart.library.io) '../di/db/setup_drift_io.dart'
    if (dart.library.js) '../di/db/setup_drift_web.dart';
import '../di/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'initGetIt',
  generateForDir: ['lib'],
)
Future<void> configureDependencies(String environment) async {
  logger.log('Using environment: $environment');
  await getIt.initGetIt(environment: environment);
  await getIt.allReady();
}

@module
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @singleton
  @preResolve
  Future<DatabaseConnection> provideDatabaseConnection() {
    return createDriftDatabaseConnection('kioleziDb');
  }

  @lazySingleton
  FlutterSecureStorage storage() => const FlutterSecureStorage();

  @lazySingleton
  FirebaseAnalytics provideFirebaseAnalytics() => FirebaseAnalytics.instance;

}

dynamic _parseAndDecode(String response) => jsonDecode(response);

dynamic parseJson(String text) =>
    compute<String, dynamic>(_parseAndDecode, text);
