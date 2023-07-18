import 'package:drift/drift.dart';

import '../models/tables/db_book_table.dart';
import '../models/tables/db_draft_table.dart';
import '../models/tables/db_edit_table.dart';
import '../models/tables/db_history_table.dart';
import '../models/tables/db_listed_table.dart';
import '../models/tables/db_search_table.dart';
import '../models/tables/db_song_table.dart';
import 'dao/book_dao.dart';
import 'dao/draft_dao.dart';
import 'dao/edit_dao.dart';
import 'dao/history_dao.dart';
import 'dao/listed_dao.dart';
import 'dao/search_dao.dart';
import 'dao/song_dao.dart';
import 'migrations.dart';

part 'songlib_db.g.dart';

@DriftDatabase(
  tables: [
    DbBookTable,
    DbDraftTable,
    DbEditTable,
    DbHistoryTable,
    DbListedTable,
    DbSearchTable,
    DbSongTable,
  ],
  daos: [BookDao, DraftDao, EditDao, HistoryDao, ListedDao, SearchDao, SongDao],
)
class SongLibDB extends _$SongLibDB {
  SongLibDB(QueryExecutor db) : super(db);

  SongLibDB.connect(DatabaseConnection connection) : super.connect(connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => migrations();
}
