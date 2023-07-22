import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/listed.dart';
import '../../models/base/listedext.dart';
import '../../models/base/songext.dart';
import '../../models/tables/db_listed_table.dart';
import '../../utils/utilities.dart';
import '../songlib_db.dart';

part 'listed_dao.g.dart';

@lazySingleton
abstract class ListedDao {
  @factoryMethod
  factory ListedDao(SongLibDB db) = _ListedDao;

  Future<List<Listed>> getAllListeds();
  Future<List<Listed>> getAllListedSongs();
  Future<List<ListedExt>> getListedSongs(int parentid);
  Future<int> createListed(Listed listed);
  Future<void> createListedSong(Listed listed, SongExt song);
  Future<void> updateListed(Listed listed);
  Future<void> deleteListed(Listed listed);
  Future<void> deleteListedSongs(Listed listed);
}

@DriftAccessor(tables: [
  DbListedTable,
])
class _ListedDao extends DatabaseAccessor<SongLibDB>
    with _$_ListedDaoMixin
    implements ListedDao {
  _ListedDao(SongLibDB db) : super(db);

  @override
  Future<List<Listed>> getAllListeds() async {
    return await customSelect(
      'SELECT *, '
      ' (SELECT COUNT(*) FROM ${db.dbListedTable.actualTableName} tbl2 '
      ' WHERE tbl1.${db.dbListedTable.id.name} = tbl2.${db.dbListedTable.parentid.name}) as songCount '
      'FROM ${db.dbListedTable.actualTableName} tbl1 '
      'WHERE tbl1.${db.dbListedTable.parentid.name}=0 '
      'ORDER BY tbl1.${db.dbListedTable.id.name} DESC;',
      readsFrom: {db.dbListedTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => Listed.fromData(row.data)).toList();
      },
    ).first;
  }

  @override
  Future<List<ListedExt>> getListedSongs(int? parentid) async {
    return await customSelect(
      'SELECT lists.${db.dbListedTable.parentid.name}, lists.${db.dbListedTable.id.name}, lists.${db.dbListedTable.position.name}, '
      'lists.${db.dbListedTable.id.name}, lists.${db.dbListedTable.createdAt.name}, lists.${db.dbListedTable.updatedAt.name}, '
      'lists.${db.dbListedTable.song.name}, songs.${db.dbSongTable.book.name}, songs.${db.dbSongTable.songNo.name}, '
      'songs.${db.dbSongTable.title.name}, songs.${db.dbSongTable.alias.name}, songs.${db.dbSongTable.content.name}, '
      'songs.${db.dbSongTable.key.name}, songs.${db.dbSongTable.author.name}, songs.${db.dbSongTable.views.name}, '
      'songs.${db.dbSongTable.likes.name}, songs.${db.dbSongTable.liked.name}, songs.${db.dbSongTable.id.name} AS songId, '
      'books.${db.dbBookTable.title.name} AS songbook '
      'FROM ${db.dbListedTable.actualTableName} AS lists '
      'LEFT JOIN ${db.dbSongTable.actualTableName} AS songs '
      'ON lists.${db.dbListedTable.song.name}=songs.${db.dbSongTable.id.name} '
      'LEFT JOIN ${db.dbBookTable.actualTableName} AS books '
      'ON songs.${db.dbSongTable.book.name}=books.${db.dbBookTable.bookNo.name} '
      'WHERE lists.${db.dbListedTable.parentid.name}=$parentid '
      'ORDER BY lists.${db.dbListedTable.updatedAt.name} DESC;',
      readsFrom: {db.dbListedTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => ListedExt.fromData(row.data)).toList();
      },
    ).first;
  }

  @override
  Future<List<Listed>> getAllListedSongs() async {
    final List<DbListed> results = await select(db.dbListedTable).get();
    return results
        .map(
          (result) => Listed(
            id: result.id,
            objectId: result.objectId,
            song: result.song,
            parentid: result.parentid,
            title: result.title,
            description: result.description,
            position: result.position,
            createdAt: result.createdAt,
            updatedAt: result.updatedAt,
          ),
        )
        .toList();
  }

  @override
  Future<int> createListed(Listed listed) async {
    return await into(db.dbListedTable).insert(
      DbListedTableCompanion.insert(
        objectId: Value(listed.objectId!),
        title: Value(listed.title!),
        description: Value(listed.description!),
        createdAt: Value(dateNow()),
        updatedAt: Value(dateNow()),
      ),
    );
  }

  @override
  Future<void> createListedSong(Listed listed, SongExt song) async =>
      into(db.dbListedTable).insert(
        DbListedTableCompanion.insert(
          objectId: const Value.absent(),
          parentid: Value(listed.id!),
          song: Value(song.id!),
          title: Value(songItemTitle(song.songNo!, song.title!)),
          description: Value(truncateString(30, song.content!)),
          createdAt: Value(dateNow()),
          updatedAt: Value(dateNow()),
        ),
      );

  @override
  Future<void> updateListed(Listed listed) =>
      (update(db.dbListedTable)..where((row) => row.id.equals(listed.id!)))
          .write(
        DbListedTableCompanion(
          parentid: Value(listed.parentid!),
          title: Value(listed.title!),
          description: Value(listed.description!),
          position: Value(listed.position!),
          updatedAt: Value(dateNow()),
        ),
      );

  @override
  Future<void> deleteListed(Listed listed) =>
      (delete(db.dbListedTable)..where((row) => row.id.equals(listed.id!))).go();

  @override
  Future<void> deleteListedSongs(Listed listed) =>
      (delete(db.dbListedTable)..where((row) => row.parentid.equals(listed.id!)))
          .go();
}
