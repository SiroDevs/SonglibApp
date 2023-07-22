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
            id: result.id,
            song: result.song,
            book: result.book,
            songNo: result.songNo,
            title: result.title,
            content: result.content,
            alias: result.alias,
            key: result.key,
            createdAt: result.createdAt,
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
      (delete(db.dbEditTable)..where((row) => row.id.equals(edit.id!))).go();
}
