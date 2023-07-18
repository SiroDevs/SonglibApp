import 'package:drift/drift.dart';

import '../../db/songlib_db.dart';
import '../base/draft.dart';

@DataClassName('DbDraft')
class DbDraftTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get objectId => text().withDefault(const Constant(''))();

  IntColumn get book => integer().withDefault(const Constant(0))();

  IntColumn get songNo => integer().withDefault(const Constant(0))();

  TextColumn get title => text().withDefault(const Constant(''))();

  TextColumn get alias => text().withDefault(const Constant(''))();

  TextColumn get content => text().withDefault(const Constant(''))();

  TextColumn get key => text().withDefault(const Constant(''))();

  TextColumn get author => text().withDefault(const Constant(''))();

  IntColumn get views => integer().withDefault(const Constant(0))();

  TextColumn get createdAt => text().withDefault(const Constant(''))();

  TextColumn get updatedAt => text().withDefault(const Constant(''))();

  BoolColumn get liked => boolean().withDefault(const Constant(false))();
}

extension DbDraftExtension on DbDraft {
  Draft getModel() => Draft(
        id: id,
        objectId: objectId,
        book: book,
        songNo: songNo,
        title: title,
        alias: alias,
        content: content,
        key: key,
        author: author,
        views: views,
        createdAt: createdAt,
        updatedAt: updatedAt,
        liked: liked,
      );
}

extension DraftExtension on Draft {
  DbDraftTableCompanion getDbModel() {
    final id = this.id;
    return DbDraftTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
          objectId: Value(objectId!),
          book: Value(book!),
          songNo: Value(songNo!),
          title: Value(title!),
          alias: Value(alias!),
          content: Value(content!),
          author: Value(author!),
          key: Value(key!),
          createdAt: Value(createdAt!),
          updatedAt: Value(updatedAt!),
          liked: Value(liked!),
    );
  }
}
