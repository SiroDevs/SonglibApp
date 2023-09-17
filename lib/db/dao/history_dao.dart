import 'dart:developer' as logger show log;
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/history.dart';
import '../../model/tables/historys_table.dart';
import '../../utils/utilities.dart';
import '../app_database.dart';

part 'history_dao.g.dart';

@lazySingleton
abstract class HistoryDao {
  @factoryMethod
  factory HistoryDao(AppDatabase db) = _HistoryDao;

  Future<void> checkHistorys();
  Future<List<History>> getAllHistorys();
  Future<int> createHistory(History history);
  Future<void> updateHistory(History history);
  Future<void> deleteHistory(int id);
  Future<void> deleteHistorys();
  Future<void> dropHistorysTable();
}

@DriftAccessor(tables: [
  HistorysTable,
])
class _HistoryDao extends DatabaseAccessor<AppDatabase>
    with _$_HistoryDaoMixin
    implements HistoryDao {
  _HistoryDao(AppDatabase db) : super(db);

  @override
  Future<void> checkHistorys() async {
    logger.log('Checking for if history tables exists as expected');
    try {
      String sqlQry =
          'SELECT * FROM ${db.historysTable.actualTableName} ORDER BY ${db.historysTable.id.name} ASC;';
      logger.log('Select Query: $sqlQry');
      await customSelect(sqlQry).watch().first;
      logger
          .log('${db.historysTable.actualTableName} table exists as expected');
    } catch (e) {
      logger.log('Query Error: $e');
      try {
        String sqlQry =
            'ALTER TABLE db_history_table RENAME TO ${db.historysTable.actualTableName};';
        logger.log('Alter Query: $sqlQry');
        await customStatement(sqlQry);
        logger.log(
            'db_history_table renamed to ${db.historysTable.actualTableName} successfully');
      } catch (e) {
        logger.log('Query Error: $e');
      }
    }
  }

  @override
  Future<List<History>> getAllHistorys() async {
    List<History> items = [];
    String sqlQry =
        'SELECT * FROM ${db.historysTable.actualTableName} ORDER BY ${db.historysTable.id.name} ASC;';
    logger.log('Select Query: $sqlQry');

    try {
      final List<Historys> results = await select(db.historysTable).get();
      items = results
          .map(
            (result) => History(
              id: const IntType().mapFromDatabaseResponse(result.id)!,
              historyId:
                  const IntType().mapFromDatabaseResponse(result.historyId)!,
              song: const IntType().mapFromDatabaseResponse(result.song)!,
              created:
                  const StringType().mapFromDatabaseResponse(result.created)!,
            ),
          )
          .toList();
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return items;
  }

  @override
  Future<int> createHistory(History history) async {
    int result = 0;
    String sqlQry = "INSERT INTO ${db.historysTable.actualTableName} "
        "(${db.historysTable.historyId.name}, ${db.historysTable.song.name}, ${db.historysTable.created.name}}) "
        "VALUES (${history.historyId}, ${history.song}, ${history.created});";
    logger.log('Insert Query: $sqlQry');
    try {
      final sqlStatement = HistorysTableCompanion.insert(
        historyId: Value(history.historyId!),
        song: Value(history.song!),
        created: Value(dateNow()),
      );
      result = await into(db.historysTable).insert(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return result;
  }

  @override
  Future<int> updateHistory(History history) async {
    int result = 0;
    String sqlQry = "UPDATE ${db.historysTable.actualTableName} "
        "SET (${db.historysTable.historyId.name} = ${history.historyId}, ${db.historysTable.song.name} = ${history.song}) "
        "WHERE ${db.historysTable.id.name} = ${history.id};";
    logger.log('Update Query: $sqlQry');
    try {
      final sqlStatement = HistorysTableCompanion(
        historyId: Value(history.historyId!),
        song: Value(history.song!),
      );
      await (update(db.historysTable)
            ..where((row) => row.id.equals(history.id)))
          .write(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }

    return result;
  }

  @override
  Future<void> deleteHistory(int id) async {
    try {
      String sqlQry =
          'DELETE FROM ${db.historysTable.actualTableName} WHERE ${db.historysTable.id.name} = $id;';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.historysTable)..where((row) => row.id.equals(id))).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> deleteHistorys() async {
    try {
      String sqlQry = 'DELETE FROM ${db.historysTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.historysTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> dropHistorysTable() async {
    try {
      String sqlQry = 'DROP TABLE ${db.historysTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.historysTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }
}
