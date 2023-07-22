import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/history.dart';
import '../../models/base/historyext.dart';
import '../../models/tables/db_history_table.dart';
import '../../utils/utilities.dart';
import '../songlib_db.dart';

part 'history_dao.g.dart';

@lazySingleton
abstract class HistoryDao {
  @factoryMethod
  factory HistoryDao(SongLibDB db) = _HistoryDao;

  Future<List<History>> getHistories();
  Future<List<HistoryExt>> getAllHistories();
  Future<void> createHistory(History history);
  Future<void> deleteHistory(History history);
}

@DriftAccessor(tables: [
  DbHistoryTable,
])
class _HistoryDao extends DatabaseAccessor<SongLibDB>
    with _$_HistoryDaoMixin
    implements HistoryDao {
  _HistoryDao(SongLibDB db) : super(db);

  @override
  Future<List<History>> getHistories() async {
    final List<DbHistory> results = await select(db.dbHistoryTable).get();
    return results
        .map(
          (result) => History(
            id: result.id,
            song: result.song,
            objectId: result.objectId,
            createdAt: result.createdAt,
          ),
        )
        .toList();
  }

  @override
  Future<List<HistoryExt>> getAllHistories() async {
    return await customSelect(
      'SELECT histories.${db.dbHistoryTable.id.name}, histories.${db.dbHistoryTable.createdAt.name}, '
      'songs.${db.dbSongTable.book.name}, songs.${db.dbSongTable.songNo.name}, songs.${db.dbSongTable.title.name}, '
      'songs.${db.dbSongTable.alias.name}, songs.${db.dbSongTable.content.name}, songs.${db.dbSongTable.key.name}, '
      'songs.${db.dbSongTable.author.name}, songs.${db.dbSongTable.views.name}, songs.${db.dbSongTable.likes.name}, '
      'songs.${db.dbSongTable.liked.name}, songs.${db.dbSongTable.id.name} AS songId, '
      'books.${db.dbBookTable.title.name} AS songbook '
      'FROM ${db.dbHistoryTable.actualTableName} AS histories '
      'LEFT JOIN ${db.dbSongTable.actualTableName} AS songs '
      'ON histories.${db.dbHistoryTable.song.name}=songs.${db.dbSongTable.id.name} '
      'LEFT JOIN ${db.dbBookTable.actualTableName} AS books '
      'ON songs.${db.dbSongTable.book.name}=books.${db.dbBookTable.bookNo.name} '
      'ORDER BY ${db.dbSongTable.id.name} DESC;',
      readsFrom: {db.dbSongTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => HistoryExt.fromData(row.data)).toList();
      },
    ).first;
  }

  @override
  Future<void> createHistory(History history) => into(db.dbHistoryTable).insert(
        DbHistoryTableCompanion.insert(
          song: Value(history.song!),
          createdAt: Value(dateNow()),
        ),
      );

  @override
  Future<void> deleteHistory(History history) =>
      (delete(db.dbHistoryTable)..where((row) => row.id.equals(history.id!)))
          .go();
}
