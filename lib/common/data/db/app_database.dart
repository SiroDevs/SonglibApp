import 'package:drift/drift.dart';

import 'dao/book_dao.dart';
import 'tables/books_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    BooksTable,
  ],
  daos: [BookDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor db) : super(db);

  AppDatabase.connect(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 3;
}
