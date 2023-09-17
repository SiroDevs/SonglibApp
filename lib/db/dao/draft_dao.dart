import 'dart:developer' as logger show log;
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/draft.dart';
import '../../model/tables/drafts_table.dart';
import '../../utils/utilities.dart';
import '../app_database.dart';

part 'draft_dao.g.dart';

@lazySingleton
abstract class DraftDao {
  @factoryMethod
  factory DraftDao(AppDatabase db) = _DraftDao;

  Future<void> checkDrafts();
  Future<List<Draft>> getAllDrafts();
  Future<int> createDraft({required Draft draft, bool isSimple = true});
  Future<void> updateDraft(Draft draft);
  Future<void> deleteDraft(int id);
  Future<void> deleteDrafts();
  Future<void> dropDraftsTable();
}

@DriftAccessor(tables: [
  DraftsTable,
])
class _DraftDao extends DatabaseAccessor<AppDatabase>
    with _$_DraftDaoMixin
    implements DraftDao {
  _DraftDao(AppDatabase db) : super(db);

  @override
  Future<void> checkDrafts() async {
    logger.log('Checking for if draft tables exists as expected');
    try {
      String sqlQry =
          'SELECT * FROM ${db.draftsTable.actualTableName} ORDER BY ${db.draftsTable.id.name} ASC;';
      logger.log('Select Query: $sqlQry');
      await customSelect(sqlQry).watch().first;
      logger.log('${db.draftsTable.actualTableName} table exists as expected');
    } catch (e) {
      logger.log('Query Error: $e');
      try {
        String sqlQry =
            'ALTER TABLE db_draft_table RENAME TO ${db.draftsTable.actualTableName};';
        logger.log('Alter Query: $sqlQry');
        await customStatement(sqlQry);
        logger.log(
            'db_draft_table renamed to ${db.draftsTable.actualTableName} successfully');
      } catch (e) {
        logger.log('Query Error: $e');
      }
    }
  }

  @override
  Future<List<Draft>> getAllDrafts() async {
    List<Draft> items = [];
    String sqlQry =
        'SELECT * FROM ${db.draftsTable.actualTableName} ORDER BY ${db.draftsTable.id.name} ASC;';
    logger.log('Select Query: $sqlQry');
    try {
      items = await customSelect(sqlQry).watch().map(
        (rows) {
          return rows.map((row) => Draft.fromData(row.data)).toList();
        },
      ).first;
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return items;
  }

  @override
  Future<int> createDraft({required Draft draft, bool isSimple = true}) async {
    int result = 0;
    String sqlQry = "INSERT INTO ${db.draftsTable.actualTableName} "
        "(${db.draftsTable.draftId.name}, ${db.draftsTable.title.name}, ${db.draftsTable.alias.name}, ${db.draftsTable.content.name}, ${db.draftsTable.key.name}) "
        "VALUES (${draft.draftId}, ${draft.title}, ${draft.alias}, ${draft.content}, ${draft.key});";
    logger.log('Insert Query: $sqlQry');
    try {
      final sqlStatement = DraftsTableCompanion.insert(
        draftId: isSimple ? const Value.absent() : Value(draft.draftId!),
        title: Value(draft.title!),
        alias: Value(draft.alias!),
        content: Value(draft.content!),
        key: Value(draft.key!),
        created: isSimple ? Value(dateNow()) : Value(draft.created!),
        updated: isSimple ? const Value.absent() : Value(draft.updated!),
      );
      result = await into(db.draftsTable).insert(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return result;
  }

  @override
  Future<int> updateDraft(Draft draft) async {
    int result = 0;
    String sqlQry = "UPDATE ${db.draftsTable.actualTableName} "
        "SET (${db.draftsTable.draftId.name} = ${draft.draftId}, ${db.draftsTable.title.name} = ${draft.title}, ${db.draftsTable.alias.name} = ${draft.alias}, "
        "${db.draftsTable.content.name} = ${draft.content}, ${db.draftsTable.key.name} = ${draft.key}, ${db.draftsTable.updated.name} = ${draft.updated}) "
        "WHERE ${db.draftsTable.id.name} = ${draft.id};";
    logger.log('Update Query: $sqlQry');
    try {
      final sqlStatement = DraftsTableCompanion(
        draftId: Value(draft.draftId!),
        title: Value(draft.title!),
        alias: Value(draft.alias!),
        content: Value(draft.content!),
        key: Value(draft.key!),
        updated: Value(draft.updated!),
      );
      await (update(db.draftsTable)..where((row) => row.id.equals(draft.id)))
          .write(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }

    return result;
  }

  @override
  Future<void> deleteDraft(int id) async {
    try {
      String sqlQry =
          'DELETE FROM ${db.draftsTable.actualTableName} WHERE ${db.draftsTable.id.name} = $id;';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.draftsTable)..where((row) => row.id.equals(id))).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> deleteDrafts() async {
    try {
      String sqlQry = 'DELETE FROM ${db.draftsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.draftsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> dropDraftsTable() async {
    try {
      String sqlQry = 'DROP TABLE ${db.draftsTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.draftsTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }
}
