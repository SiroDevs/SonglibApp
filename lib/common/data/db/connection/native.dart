import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../../../utils/app_utils.dart';

Future<File> get databaseFile async {
  Directory dbFolder = await getApplicationDocumentsDirectory();
  if (isDesktop) {
    dbFolder = await getApplicationSupportDirectory();
  }
  print('Db Path: ${dbFolder.path}');
  return File(join(dbFolder.path, 'songlibDatabase.sqlite'));
}

/// Obtains a database connection for running drift in a Dart VM.
Future<DatabaseConnection> connect() async {
  return DatabaseConnection.delayed(Future(() async {
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;
    }

    return NativeDatabase.createBackgroundConnection(
      await databaseFile,
    );
  }));
}

Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  if (kDebugMode) {
    await VerifySelf(database).validateDatabaseSchema();
  }
}
