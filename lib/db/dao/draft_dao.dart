import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/draft.dart';
import '../../models/tables/db_draft_table.dart';
import '../../utils/utilities.dart';
import '../songlib_db.dart';

part 'draft_dao.g.dart';

@lazySingleton
abstract class DraftDao {
  @factoryMethod
  factory DraftDao(SongLibDB db) = _DraftDao;

  Future<List<Draft>> getAllDrafts();
  Future<void> createDraft({required Draft draft, bool isSimple = true});
  Future<void> updateDraft(Draft draft);
  Future<void> deleteDraft(Draft draft);
}

@DriftAccessor(tables: [
  DbDraftTable,
])
class _DraftDao extends DatabaseAccessor<SongLibDB>
    with _$_DraftDaoMixin
    implements DraftDao {
  _DraftDao(SongLibDB db) : super(db);

  @override
  Future<List<Draft>> getAllDrafts() async {
    return await customSelect(
      'SELECT * FROM ${db.dbDraftTable.actualTableName} '
      'ORDER BY ${db.dbDraftTable.id.name} DESC;',
      readsFrom: {db.dbDraftTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => Draft.fromData(row.data)).toList();
      },
    ).first;
  }

  @override
  Future<int> createDraft({required Draft draft, bool isSimple = true}) async {
    return await into(db.dbDraftTable).insert(
      DbDraftTableCompanion.insert(
        objectId: isSimple ? const Value.absent() : Value(draft.objectId!),
        book: isSimple ? const Value.absent() : Value(draft.book!),
        songNo: isSimple ? const Value.absent() : Value(draft.songNo!),
        title: Value(draft.title!),
        alias: Value(draft.alias!),
        content: Value(draft.content!),
        key: Value(draft.key!),
        author: isSimple ? const Value.absent() : Value(draft.author!),
        views: isSimple ? const Value.absent() : Value(draft.views!),
        createdAt: isSimple ? Value(dateNow()) : Value(draft.createdAt!),
        updatedAt: isSimple ? const Value.absent() : Value(draft.updatedAt!),
        liked: isSimple ? const Value.absent() : Value(draft.liked!),
      ),
    );
  }

  @override
  Future<void> updateDraft(Draft draft) =>
      (update(db.dbDraftTable)..where((row) => row.id.equals(draft.id))).write(
        DbDraftTableCompanion(
          book: Value(draft.book!),
          songNo: Value(draft.songNo!),
          title: Value(draft.title!),
          alias: Value(draft.alias!),
          content: Value(draft.content!),
          key: Value(draft.key!),
          author: Value(draft.author!),
          views: Value(draft.views!),
          updatedAt: Value(draft.updatedAt!),
          liked: Value(draft.liked!),
        ),
      );

  @override
  Future<void> deleteDraft(Draft draft) =>
      (delete(db.dbDraftTable)..where((row) => row.id.equals(draft.id))).go();
}
