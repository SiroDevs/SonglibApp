import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../base/book.dart';


@DataClassName('Books')
class BooksTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().withDefault(const Constant(0))();
  IntColumn get user => integer().withDefault(const Constant(0))();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  IntColumn get bookNo => integer().withDefault(const Constant(0))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get subTitle => text().withDefault(const Constant(''))();
  IntColumn get songs => integer().withDefault(const Constant(0))();
  IntColumn get position => integer().withDefault(const Constant(0))();
  TextColumn get created => text().withDefault(const Constant(''))();
  TextColumn get updated => text().withDefault(const Constant(''))();
}

extension BooksExtension on Books {
  Book getModel() => Book(
        id: id,
        bookId: bookId,
        user: user,
        enabled: enabled,
        bookNo: bookNo,
        title: title,
        subTitle: subTitle,
        songs: songs,
        position: position,
        created: created,
        updated: updated,
      );
}

extension BookExtension on Book {
  BooksTableCompanion getDbModel() {
    final id = this.id;
    return BooksTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
      bookId: Value(bookId!),
      user: Value(user!),
      enabled: Value(enabled!),
      bookNo: Value(bookNo!),
      title: Value(title!),
      subTitle: Value(subTitle!),
      songs: Value(songs!),
      position: Value(position!),
      created: Value(created!),
      updated:Value( updated!),
    );
  }
}
