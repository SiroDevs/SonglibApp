import 'dart:developer' as logger show log;
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/search.dart';
import '../../model/tables/searchs_table.dart';
import '../../utils/utilities.dart';
import '../app_database.dart';

part 'search_dao.g.dart';

@lazySingleton
abstract class SearchDao {
  @factoryMethod
  factory SearchDao(AppDatabase db) = _SearchDao;

  Future<void> checkSearchs();
  Future<List<Search>> getAllSearchs();
  Future<int> createSearch(Search search);
  Future<void> updateSearch(Search search);
  Future<void> deleteSearch(int id);
  Future<void> deleteSearchs();
  Future<void> dropSearchsTable();
}

@DriftAccessor(tables: [
  SearchsTable,
])
class _SearchDao extends DatabaseAccessor<AppDatabase>
    with _$_SearchDaoMixin
    implements SearchDao {
  _SearchDao(AppDatabase db) : super(db);

  @override
  Future<void> checkSearchs() async {
    logger.log('Checking for if search tables exists as expected');
    try {
      String sqlQry =
          'SELECT * FROM ${db.searchsTable.actualTableName} ORDER BY ${db.searchsTable.id.name} ASC;';
      logger.log('Select Query: $sqlQry');
      await customSelect(sqlQry).watch().first;
      logger.log('${db.searchsTable.actualTableName} table exists as expected');
    } catch (e) {
      logger.log('Query Error: $e');
      try {
        String sqlQry =
            'ALTER TABLE db_search_table RENAME TO ${db.searchsTable.actualTableName};';
        logger.log('Alter Query: $sqlQry');
        await customStatement(sqlQry);
        logger.log(
            'db_search_table renamed to ${db.searchsTable.actualTableName} successfully');
      } catch (e) {
        logger.log('Query Error: $e');
      }
    }
  }

  @override
  Future<List<Search>> getAllSearchs() async {
    List<Search> items = [];
    String sqlQry =
        'SELECT * FROM ${db.searchsTable.actualTableName} ORDER BY ${db.searchsTable.id.name} ASC;';
    logger.log('Select Query: $sqlQry');

    try {
      final List<Searchs> results = await select(db.searchsTable).get();
      items = results
          .map(
            (result) => Search(
              id: const IntType().mapFromDatabaseResponse(result.id)!,
              searchId:
                  const IntType().mapFromDatabaseResponse(result.searchId)!,
              title: const StringType().mapFromDatabaseResponse(result.title)!,
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
  Future<int> createSearch(Search search) async {
    int result = 0;
    String sqlQry = "INSERT INTO ${db.searchsTable.actualTableName} "
        "(${db.searchsTable.searchId.name}, ${db.searchsTable.title.name}, ${db.searchsTable.created.name}}) "
        "VALUES (${search.searchId}, ${search.title}, ${search.created});";
    logger.log('Insert Query: $sqlQry');
    try {
      final sqlStatement = SearchsTableCompanion.insert(
        searchId: Value(search.searchId!),
        title: Value(search.title!),
        created: Value(dateNow()),
      );
      result = await into(db.searchsTable).insert(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return result;
  }

  @override
  Future<int> updateSearch(Search search) async {
    int result = 0;
    String sqlQry = "UPDATE ${db.searchsTable.actualTableName} "
        "SET (${db.searchsTable.searchId.name} = ${search.searchId}, ${db.searchsTable.title.name} = ${search.title}) "
        "WHERE ${db.searchsTable.id.name} = ${search.id};";
    logger.log('Update Query: $sqlQry');
    try {
      final sqlStatement = SearchsTableCompanion(
        searchId: Value(search.searchId!),
        title: Value(search.title!),
      );
      await (update(db.searchsTable)..where((row) => row.id.equals(search.id)))
          .write(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }

    return result;
  }

  @override
  Future<void> deleteSearch(int id) async {
    try {
      String sqlQry =
          'DELETE FROM ${db.searchsTable.actualTableName} WHERE ${db.searchsTable.id.name} = $id;';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.searchsTable)..where((row) => row.id.equals(id))).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> deleteSearchs() async {
    try {
      String sqlQry = 'DELETE FROM ${db.searchsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.searchsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> dropSearchsTable() async {
    try {
      String sqlQry = 'DROP TABLE ${db.searchsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.searchsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }
}
