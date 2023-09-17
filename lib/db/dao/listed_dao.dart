import 'dart:developer' as logger show log;
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/listed.dart';
import '../../model/base/songext.dart';
import '../../model/tables/listeds_table.dart';
import '../../utils/utilities.dart';
import '../app_database.dart';

part 'listed_dao.g.dart';

@lazySingleton
abstract class ListedDao {
  @factoryMethod
  factory ListedDao(AppDatabase db) = _ListedDao;

  Future<void> checkListeds();
  Future<List<Listed>> getAllListeds();
  Future<int> createListed(Listed listed, SongExt song);
  Future<void> updateListed(Listed listed);
  Future<void> deleteListed(int id);
  Future<void> deleteListeds();
  Future<void> dropListedsTable();
}

@DriftAccessor(tables: [
  ListedsTable,
])
class _ListedDao extends DatabaseAccessor<AppDatabase>
    with _$_ListedDaoMixin
    implements ListedDao {
  _ListedDao(AppDatabase db) : super(db);

  @override
  Future<void> checkListeds() async {
    logger.log('Checking for if listed tables exists as expected');
    try {
      String sqlQry =
          'SELECT * FROM ${db.listedsTable.actualTableName} ORDER BY ${db.listedsTable.id.name} ASC;';
      logger.log('Select Query: $sqlQry');
      await customSelect(sqlQry).watch().first;
      logger.log('${db.listedsTable.actualTableName} table exists as expected');
    } catch (e) {
      logger.log('Query Error: $e');
      try {
        String sqlQry =
            'ALTER TABLE db_listed_table RENAME TO ${db.listedsTable.actualTableName};';
        logger.log('Alter Query: $sqlQry');
        await customStatement(sqlQry);
        logger.log(
            'db_listed_table renamed to ${db.listedsTable.actualTableName} successfully');
      } catch (e) {
        logger.log('Query Error: $e');
      }
    }
  }

  @override
  Future<List<Listed>> getAllListeds() async {
    List<Listed> items = [];
    String sqlQry =
        'SELECT * FROM ${db.listedsTable.actualTableName} ORDER BY ${db.listedsTable.id.name} ASC;';
    logger.log('Select Query: $sqlQry');

    try {
      final List<Listeds> results = await select(db.listedsTable).get();
      items = results
          .map(
            (result) => Listed(
              id: const IntType().mapFromDatabaseResponse(result.id)!,
              listedId:
                  const IntType().mapFromDatabaseResponse(result.listedId)!,
              song: const IntType().mapFromDatabaseResponse(result.song)!,
              parentid:
                  const IntType().mapFromDatabaseResponse(result.parentid)!,
              title: const StringType().mapFromDatabaseResponse(result.title)!,
              description: const StringType()
                  .mapFromDatabaseResponse(result.description)!,
              position:
                  const IntType().mapFromDatabaseResponse(result.position)!,
              created:
                  const StringType().mapFromDatabaseResponse(result.created)!,
              updated:
                  const StringType().mapFromDatabaseResponse(result.updated)!,
            ),
          )
          .toList();
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return items;
  }

  @override
  Future<int> createListed(Listed listed, SongExt song) async {
    int result = 0;
    String sqlQry = "INSERT INTO ${db.listedsTable.actualTableName} "
        "(${db.listedsTable.listedId.name}, ${db.listedsTable.parentid.name}, ${db.listedsTable.song.name}, ${db.listedsTable.title.name}, "
        "${db.listedsTable.description.name}, ${db.listedsTable.created.name}, ${db.listedsTable.updated.name}}) "
        "VALUES (${listed.listedId}, ${listed.parentid}, ${listed.song}, ${listed.title}, ${listed.description}, ${listed.created}, ${listed.updated});";
    logger.log('Insert Query: $sqlQry');
    try {
      final sqlStatement = ListedsTableCompanion.insert(
        listedId: const Value.absent(),
        parentid: Value(listed.id!),
        song: Value(song.id!),
        title: Value(songItemTitle(song.songNo!, song.title!)),
        description: Value(truncateString(30, song.content!)),
        created: Value(dateNow()),
        updated: Value(dateNow()),
      );
      result = await into(db.listedsTable).insert(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return result;
  }

  @override
  Future<int> updateListed(Listed listed) async {
    int result = 0;
    String sqlQry = "UPDATE ${db.listedsTable.actualTableName} "
        "SET (${db.listedsTable.listedId.name} = ${listed.listedId}, ${db.listedsTable.parentid.name} = ${listed.parentid}, "
        "${db.listedsTable.title.name} = ${listed.title}, ${db.listedsTable.description.name} = ${listed.description}, "
        "${db.listedsTable.position.name} = ${listed.position}, ${db.listedsTable.updated.name} = ${listed.updated}) "
        "WHERE ${db.listedsTable.id.name} = ${listed.id};";
    logger.log('Update Query: $sqlQry');
    try {
      final sqlStatement = ListedsTableCompanion(
        listedId: Value(listed.listedId!),
        parentid: Value(listed.parentid!),
        title: Value(listed.title!),
        description: Value(listed.description!),
        position: Value(listed.position!),
        updated: Value(dateNow()),
      );
      await (update(db.listedsTable)..where((row) => row.id.equals(listed.id)))
          .write(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }

    return result;
  }

  @override
  Future<void> deleteListed(int id) async {
    try {
      String sqlQry =
          'DELETE FROM ${db.listedsTable.actualTableName} WHERE ${db.listedsTable.id.name} = $id;';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.listedsTable)..where((row) => row.id.equals(id))).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> deleteListeds() async {
    try {
      String sqlQry = 'DELETE FROM ${db.listedsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.listedsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> dropListedsTable() async {
    try {
      String sqlQry = 'DROP TABLE ${db.listedsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.listedsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }
}
