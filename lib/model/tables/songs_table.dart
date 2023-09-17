import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../base/song.dart';

@DataClassName('Songs')
class SongsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get songId => integer().withDefault(const Constant(0))();
  IntColumn get user => integer().withDefault(const Constant(0))();
  IntColumn get book => integer().withDefault(const Constant(0))();
  IntColumn get songNo => integer().withDefault(const Constant(0))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get alias => text().withDefault(const Constant(''))();
  TextColumn get content => text().withDefault(const Constant(''))();
  TextColumn get key => text().withDefault(const Constant(''))();
  TextColumn get author => text().withDefault(const Constant(''))();
  IntColumn get views => integer().withDefault(const Constant(0))();
  IntColumn get likes => integer().withDefault(const Constant(0))();
  TextColumn get created => text().withDefault(const Constant(''))();
  TextColumn get updated => text().withDefault(const Constant(''))();
  BoolColumn get liked => boolean().withDefault(const Constant(false))();
}

extension SongsExtension on Songs {
  Song getModel() => Song(
        id: id,
        songId: songId,
        user: user,
        book: book,
        songNo: songNo,
        title: title,
        alias: alias,
        content: content,
        key: key,
        author: author,
        views: views,
        likes: likes,
        created: created,
        updated: updated,
        liked: liked,
      );
}

extension SongExtension on Song {
  SongsTableCompanion getDbModel() {
    final id = this.id;
    return SongsTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
          songId: Value(songId!),
          user: Value(user!),
          book: Value(book!),
          songNo: Value(songNo!),
          title: Value(title!),
          alias: Value(alias!),
          content: Value(content!),
          author: Value(author!),
          views:Value(views!),
          likes:Value(likes!),
          key:Value(key!),
          created: Value(created!),
          updated: Value(updated!),
          liked: Value(liked!),
    );
  }
}
