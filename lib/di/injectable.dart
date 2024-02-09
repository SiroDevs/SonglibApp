import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/data/db/app_database.dart';
import '../common/data/db/connection/connection.dart' as impl;
import '../common/utils/logger.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: r'initGetIt', generateForDir: ['lib'])
Future<void> configureDependencies(String environment) async {
  logger.i('Using environment: $environment');
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
    return impl.connect();
  }

  @lazySingleton
  AppDatabase provideAppDatabase(DatabaseConnection databaseConnection) =>
      AppDatabase.connect(databaseConnection);
}

dynamic _parseAndDecode(String response) => jsonDecode(response);

dynamic parseJson(String text) =>
    compute<String, dynamic>(_parseAndDecode, text);
