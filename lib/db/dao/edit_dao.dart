import 'dart:developer' as logger show log;
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/edit.dart';
import '../../model/tables/edits_table.dart';
import '../../utils/utilities.dart';
import '../app_database.dart';

part 'edit_dao.g.dart';

@lazySingleton
abstract class EditDao {
  @factoryMethod
  factory EditDao(AppDatabase db) = _EditDao;

  Future<void> checkEdits();
  Future<List<Edit>> getAllEdits();
  Future<int> createEdit(Edit edit);
  Future<void> updateEdit(Edit edit);
  Future<void> deleteEdit(int id);
  Future<void> deleteEdits();
  Future<void> dropEditsTable();
}

@DriftAccessor(tables: [
  EditsTable,
])
class _EditDao extends DatabaseAccessor<AppDatabase>
    with _$_EditDaoMixin
    implements EditDao {
  _EditDao(AppDatabase db) : super(db);

  @override
  Future<void> checkEdits() async {
    logger.log('Checking for if edit tables exists as expected');
    try {
      String sqlQry =
          'SELECT * FROM ${db.editsTable.actualTableName} ORDER BY ${db.editsTable.id.name} ASC;';
      logger.log('Select Query: $sqlQry');
      await customSelect(sqlQry).watch().first;
      logger.log('${db.editsTable.actualTableName} table exists as expected');
    } catch (e) {
      logger.log('Query Error: $e');
      try {
        String sqlQry =
            'ALTER TABLE db_edit_table RENAME TO ${db.editsTable.actualTableName};';
        logger.log('Alter Query: $sqlQry');
        await customStatement(sqlQry);
        logger.log(
            'db_edit_table renamed to ${db.editsTable.actualTableName} successfully');
      } catch (e) {
        logger.log('Query Error: $e');
      }
    }
  }

  @override
  Future<List<Edit>> getAllEdits() async {
    List<Edit> items = [];
    String sqlQry =
        'SELECT * FROM ${db.editsTable.actualTableName} ORDER BY ${db.editsTable.id.name} ASC;';
    logger.log('Select Query: $sqlQry');

    try {
      final List<Edits> results = await select(db.editsTable).get();
      items = results
          .map(
            (result) => Edit(
              id: const IntType().mapFromDatabaseResponse(result.id)!,
              editId: const IntType().mapFromDatabaseResponse(result.editId)!,
              song: const StringType().mapFromDatabaseResponse(result.song)!,
              book: const IntType().mapFromDatabaseResponse(result.book)!,
              songNo: const IntType().mapFromDatabaseResponse(result.songNo)!,
              title: const StringType().mapFromDatabaseResponse(result.title)!,
              content:
                  const StringType().mapFromDatabaseResponse(result.content)!,
              alias: const StringType().mapFromDatabaseResponse(result.alias)!,
              key: const StringType().mapFromDatabaseResponse(result.key)!,
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
  Future<int> createEdit(Edit edit) async {
    int result = 0;
    String sqlQry = "INSERT INTO ${db.editsTable.actualTableName} "
        "(${db.editsTable.editId.name}, ${db.editsTable.song.name}, ${db.editsTable.book.name}, ${db.editsTable.title.name}, "
        "${db.editsTable.alias.name}, ${db.editsTable.content.name}, ${db.editsTable.key.name}, ${db.editsTable.created.name}}) "
        "VALUES (${edit.editId}, ${edit.song}, ${edit.book}, ${edit.alias}, ${edit.content}, ${edit.key}, ${edit.created});";
    logger.log('Insert Query: $sqlQry');
    try {
      final sqlStatement = EditsTableCompanion.insert(
        song: Value(edit.song!),
        book: Value(edit.book!),
        title: Value(edit.title!),
        alias: Value(edit.alias!),
        content: Value(edit.content!),
        key: Value(edit.key!),
        created: Value(dateNow()),
      );
      result = await into(db.editsTable).insert(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return result;
  }

  @override
  Future<int> updateEdit(Edit edit) async {
    int result = 0;
    String sqlQry = "UPDATE ${db.editsTable.actualTableName} "
        "SET (${db.editsTable.editId.name} = ${edit.editId}, ${db.editsTable.song.name} = ${edit.song}, ${db.editsTable.book.name} = ${edit.book}, "
        "${db.editsTable.title.name} = ${edit.title}, ${db.editsTable.alias.name} = ${edit.alias}, ${db.editsTable.content.name} = ${edit.content}, "
        "${db.editsTable.key.name} = ${edit.key}, ${db.editsTable.updated.name} = ${edit.updated}) "
        "WHERE ${db.editsTable.id.name} = ${edit.id};";
    logger.log('Update Query: $sqlQry');
    try {
      final sqlStatement = EditsTableCompanion(
        editId: Value(edit.editId!),
        song: Value(edit.song!),
        book: Value(edit.book!),
        title: Value(edit.title!),
        alias: Value(edit.alias!),
        content: Value(edit.content!),
        key: Value(edit.key!),
        updated: Value(edit.updated!),
      );
      await (update(db.editsTable)..where((row) => row.id.equals(edit.id)))
          .write(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }

    return result;
  }

  @override
  Future<void> deleteEdit(int id) async {
    try {
      String sqlQry =
          'DELETE FROM ${db.editsTable.actualTableName} WHERE ${db.editsTable.id.name} = $id;';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.editsTable)..where((row) => row.id.equals(id))).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> deleteEdits() async {
    try {
      String sqlQry = 'DELETE FROM ${db.editsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.editsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> dropEditsTable() async {
    try {
      String sqlQry = 'DROP TABLE ${db.editsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.editsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }
}
