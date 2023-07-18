import 'package:drift/drift.dart';

import '../../db/songlib_db.dart';
import '../base/book.dart';


@DataClassName('DbBook')
class DbBookTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get objectId => text().unique()();

  BoolColumn get enabled => boolean().withDefault(const Constant(false))();

  IntColumn get bookNo => integer().withDefault(const Constant(0))();

  TextColumn get title => text().withDefault(const Constant(''))();

  TextColumn get subTitle => text().withDefault(const Constant(''))();

  IntColumn get songs => integer().withDefault(const Constant(0))();

  IntColumn get position => integer().withDefault(const Constant(0))();

  TextColumn get createdAt => text().withDefault(const Constant(''))();

  TextColumn get updatedAt => text().withDefault(const Constant(''))();
}

extension DbBookExtension on DbBook {
  Book getModel() => Book(
        id: id,
        objectId: objectId,
        enabled: enabled,
        bookNo: bookNo,
        title: title,
        subTitle: subTitle,
        songs: songs,
        position: position,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension BookExtension on Book {
  DbBookTableCompanion getDbModel() {
    final id = this.id;
    return DbBookTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
      objectId: objectId!,
      enabled: Value(enabled!),
      bookNo: Value(bookNo!),
      title: Value(title!),
      subTitle: Value(subTitle!),
      songs: Value(songs!),
      position: Value(position!),
      createdAt: Value(createdAt!),
      updatedAt:Value( updatedAt!),
    );
  }
}
