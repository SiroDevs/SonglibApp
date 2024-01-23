import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;
import 'tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    TodoEntries,
    Categories,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  int get schemaVersion => 3;

}
