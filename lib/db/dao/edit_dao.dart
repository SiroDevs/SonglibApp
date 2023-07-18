import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/edit.dart';
import '../../models/tables/db_edit_table.dart';
import '../../utils/utilities.dart';
import '../songlib_db.dart';

part 'edit_dao.g.dart';

@lazySingleton
abstract class EditDao {
  @factoryMethod
  factory EditDao(SongLibDB db) = _EditDao;

  Future<List<Edit>> getAllEdits();
  Future<void> createEdit(Edit edit);
  Future<void> deleteEdit(Edit edit);
}

@DriftAccessor(tables: [
  DbEditTable,
])
class _EditDao extends DatabaseAccessor<SongLibDB>
    with _$_EditDaoMixin
    implements EditDao {
  _EditDao(SongLibDB db) : super(db);

  @override
  Future<List<Edit>> getAllEdits() async {
    final List<DbEdit> results = await select(db.dbEditTable).get();
    return results
        .map(
          (result) => Edit(
            id: const IntType().mapFromDatabaseResponse(result.id)!,
            song:
                const StringType().mapFromDatabaseResponse(result.song)!,
            book: const IntType().mapFromDatabaseResponse(result.book)!,
            songNo: const IntType().mapFromDatabaseResponse(result.songNo)!,
            title: const StringType().mapFromDatabaseResponse(result.title)!,
            content:
                const StringType().mapFromDatabaseResponse(result.content)!,
            alias: const StringType().mapFromDatabaseResponse(result.alias)!,
            key: const StringType().mapFromDatabaseResponse(result.key)!,
            createdAt:
                const StringType().mapFromDatabaseResponse(result.createdAt)!,
          ),
        )
        .toList();
  }

  @override
  Future<void> createEdit(Edit edit) => into(db.dbEditTable).insert(
        DbEditTableCompanion.insert(
          song: Value(edit.song!),
          book: Value(edit.book!),
          title: Value(edit.title!),
          alias: Value(edit.alias!),
          content: Value(edit.content!),
          key: Value(edit.key!),
          createdAt: Value(dateNow()),
        ),
      );

  @override
  Future<void> deleteEdit(Edit edit) =>
      (delete(db.dbEditTable)..where((row) => row.id.equals(edit.id))).go();
}
