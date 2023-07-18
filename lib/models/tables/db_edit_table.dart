import 'package:drift/drift.dart';

import '../../db/songlib_db.dart';
import '../base/edit.dart';

@DataClassName('DbEdit')
class DbEditTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get song => text().withDefault(const Constant(''))();

  IntColumn get book => integer().withDefault(const Constant(0))();

  IntColumn get songNo => integer().withDefault(const Constant(0))();

  TextColumn get title => text().withDefault(const Constant(''))();

  TextColumn get alias => text().withDefault(const Constant(''))();

  TextColumn get content => text().withDefault(const Constant(''))();

  TextColumn get key => text().withDefault(const Constant(''))();

  TextColumn get createdAt => text().withDefault(const Constant(''))();
}

extension DbEditExtension on DbEdit {
  Edit getModel() => Edit(
        id: id,
        song: song,
        book: book,
        songNo: songNo,
        title: title,
        alias: alias,
        content: content,
        key: key,
        createdAt: createdAt,
      );
}

extension EditExtension on Edit {
  DbEditTableCompanion getDbModel() {
    final id = this.id;
    return DbEditTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
          song: Value(song!),
          book: Value(book!),
          songNo: Value(songNo!),
          title: Value(title!),
          alias: Value(alias!),
          content: Value(content!),
          key:Value(key!),
          createdAt: Value(createdAt!),
    );
  }
}
