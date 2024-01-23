import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*import '../common/data/db/app_database.dart';
import '../common/data/db/connectionx/setup_drift_none.dart'
    if (dart.library.io) 'db/setup_drift_io.dart'
    if (dart.library.js) 'db/setup_drift_web.dart';*/
import '../common/utils/logger.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: r'$initGetIt', generateForDir: ['lib'])
Future<void> configureDependencies(String environment) async {
  logger.i('Using environment: $environment');
  //await $initGetIt(getIt, environment: environment);
  await getIt.allReady();
}

@module
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  /*@singleton
  @preResolve
  Future<DatabaseConnection> provideDatabaseConnection() {
    return createDriftDatabaseConnection('songlibDatabase');
  }

  @lazySingleton
  AppDatabase provideAppDatabase(DatabaseConnection databaseConnection) =>
      AppDatabase.connect(databaseConnection);*/
}

dynamic _parseAndDecode(String response) => jsonDecode(response);

dynamic parseJson(String text) =>
    compute<String, dynamic>(_parseAndDecode, text);
