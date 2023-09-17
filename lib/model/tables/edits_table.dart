import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../base/edit.dart';

@DataClassName('Edits')
class EditsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get editId => integer().withDefault(const Constant(0))();
  IntColumn get user => integer().withDefault(const Constant(0))();
  TextColumn get song => text().withDefault(const Constant(''))();
  IntColumn get book => integer().withDefault(const Constant(0))();
  IntColumn get songNo => integer().withDefault(const Constant(0))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get alias => text().withDefault(const Constant(''))();
  TextColumn get content => text().withDefault(const Constant(''))();
  TextColumn get key => text().withDefault(const Constant(''))();
  TextColumn get created => text().withDefault(const Constant(''))();
  TextColumn get updated => text().withDefault(const Constant(''))();
}

extension EditsExtension on Edits {
  Edit getModel() => Edit(
        id: id,
        editId: editId,
        user: user,
        song: song,
        book: book,
        songNo: songNo,
        title: title,
        alias: alias,
        content: content,
        key: key,
        created: created,
        updated: updated,
      );
}

extension EditExtension on Edit {
  EditsTableCompanion getDbModel() {
    final id = this.id;
    return EditsTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
          editId: Value(editId!),
          user: Value(user!),
          song: Value(song!),
          book: Value(book!),
          songNo: Value(songNo!),
          title: Value(title!),
          alias: Value(alias!),
          content: Value(content!),
          key:Value(key!),
          created: Value(created!),
          updated: Value(updated!),
    );
  }
}
