// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Books extends DataClass implements Insertable<Books> {
  final int id;
  final int bookId;
  final int user;
  final bool enabled;
  final int bookNo;
  final String title;
  final String subTitle;
  final int songs;
  final int position;
  final String created;
  final String updated;
  Books(
      {required this.id,
      required this.bookId,
      required this.user,
      required this.enabled,
      required this.bookNo,
      required this.title,
      required this.subTitle,
      required this.songs,
      required this.position,
      required this.created,
      required this.updated});
  factory Books.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Books(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      bookId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}book_id'])!,
      user: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user'])!,
      enabled: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}enabled'])!,
      bookNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}book_no'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      subTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_title'])!,
      songs: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}songs'])!,
      position: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}position'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
      updated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['user'] = Variable<int>(user);
    map['enabled'] = Variable<bool>(enabled);
    map['book_no'] = Variable<int>(bookNo);
    map['title'] = Variable<String>(title);
    map['sub_title'] = Variable<String>(subTitle);
    map['songs'] = Variable<int>(songs);
    map['position'] = Variable<int>(position);
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    return map;
  }

  BooksTableCompanion toCompanion(bool nullToAbsent) {
    return BooksTableCompanion(
      id: Value(id),
      bookId: Value(bookId),
      user: Value(user),
      enabled: Value(enabled),
      bookNo: Value(bookNo),
      title: Value(title),
      subTitle: Value(subTitle),
      songs: Value(songs),
      position: Value(position),
      created: Value(created),
      updated: Value(updated),
    );
  }

  factory Books.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Books(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      user: serializer.fromJson<int>(json['user']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      bookNo: serializer.fromJson<int>(json['bookNo']),
      title: serializer.fromJson<String>(json['title']),
      subTitle: serializer.fromJson<String>(json['subTitle']),
      songs: serializer.fromJson<int>(json['songs']),
      position: serializer.fromJson<int>(json['position']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'user': serializer.toJson<int>(user),
      'enabled': serializer.toJson<bool>(enabled),
      'bookNo': serializer.toJson<int>(bookNo),
      'title': serializer.toJson<String>(title),
      'subTitle': serializer.toJson<String>(subTitle),
      'songs': serializer.toJson<int>(songs),
      'position': serializer.toJson<int>(position),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
    };
  }

  Books copyWith(
          {int? id,
          int? bookId,
          int? user,
          bool? enabled,
          int? bookNo,
          String? title,
          String? subTitle,
          int? songs,
          int? position,
          String? created,
          String? updated}) =>
      Books(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        user: user ?? this.user,
        enabled: enabled ?? this.enabled,
        bookNo: bookNo ?? this.bookNo,
        title: title ?? this.title,
        subTitle: subTitle ?? this.subTitle,
        songs: songs ?? this.songs,
        position: position ?? this.position,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );
  @override
  String toString() {
    return (StringBuffer('Books(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('user: $user, ')
          ..write('enabled: $enabled, ')
          ..write('bookNo: $bookNo, ')
          ..write('title: $title, ')
          ..write('subTitle: $subTitle, ')
          ..write('songs: $songs, ')
          ..write('position: $position, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, user, enabled, bookNo, title,
      subTitle, songs, position, created, updated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Books &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.user == this.user &&
          other.enabled == this.enabled &&
          other.bookNo == this.bookNo &&
          other.title == this.title &&
          other.subTitle == this.subTitle &&
          other.songs == this.songs &&
          other.position == this.position &&
          other.created == this.created &&
          other.updated == this.updated);
}

class BooksTableCompanion extends UpdateCompanion<Books> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> user;
  final Value<bool> enabled;
  final Value<int> bookNo;
  final Value<String> title;
  final Value<String> subTitle;
  final Value<int> songs;
  final Value<int> position;
  final Value<String> created;
  final Value<String> updated;
  const BooksTableCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.user = const Value.absent(),
    this.enabled = const Value.absent(),
    this.bookNo = const Value.absent(),
    this.title = const Value.absent(),
    this.subTitle = const Value.absent(),
    this.songs = const Value.absent(),
    this.position = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  BooksTableCompanion.insert({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.user = const Value.absent(),
    this.enabled = const Value.absent(),
    this.bookNo = const Value.absent(),
    this.title = const Value.absent(),
    this.subTitle = const Value.absent(),
    this.songs = const Value.absent(),
    this.position = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  static Insertable<Books> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? user,
    Expression<bool>? enabled,
    Expression<int>? bookNo,
    Expression<String>? title,
    Expression<String>? subTitle,
    Expression<int>? songs,
    Expression<int>? position,
    Expression<String>? created,
    Expression<String>? updated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (user != null) 'user': user,
      if (enabled != null) 'enabled': enabled,
      if (bookNo != null) 'book_no': bookNo,
      if (title != null) 'title': title,
      if (subTitle != null) 'sub_title': subTitle,
      if (songs != null) 'songs': songs,
      if (position != null) 'position': position,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
    });
  }

  BooksTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? bookId,
      Value<int>? user,
      Value<bool>? enabled,
      Value<int>? bookNo,
      Value<String>? title,
      Value<String>? subTitle,
      Value<int>? songs,
      Value<int>? position,
      Value<String>? created,
      Value<String>? updated}) {
    return BooksTableCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      user: user ?? this.user,
      enabled: enabled ?? this.enabled,
      bookNo: bookNo ?? this.bookNo,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      songs: songs ?? this.songs,
      position: position ?? this.position,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (bookNo.present) {
      map['book_no'] = Variable<int>(bookNo.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subTitle.present) {
      map['sub_title'] = Variable<String>(subTitle.value);
    }
    if (songs.present) {
      map['songs'] = Variable<int>(songs.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksTableCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('user: $user, ')
          ..write('enabled: $enabled, ')
          ..write('bookNo: $bookNo, ')
          ..write('title: $title, ')
          ..write('subTitle: $subTitle, ')
          ..write('songs: $songs, ')
          ..write('position: $position, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }
}

class $BooksTableTable extends BooksTable
    with TableInfo<$BooksTableTable, Books> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int?> bookId = GeneratedColumn<int?>(
      'book_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int?> user = GeneratedColumn<int?>(
      'user', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _enabledMeta = const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool?> enabled = GeneratedColumn<bool?>(
      'enabled', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (enabled IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _bookNoMeta = const VerificationMeta('bookNo');
  @override
  late final GeneratedColumn<int?> bookNo = GeneratedColumn<int?>(
      'book_no', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _subTitleMeta = const VerificationMeta('subTitle');
  @override
  late final GeneratedColumn<String?> subTitle = GeneratedColumn<String?>(
      'sub_title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _songsMeta = const VerificationMeta('songs');
  @override
  late final GeneratedColumn<int?> songs = GeneratedColumn<int?>(
      'songs', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _positionMeta = const VerificationMeta('position');
  @override
  late final GeneratedColumn<int?> position = GeneratedColumn<int?>(
      'position', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String?> updated = GeneratedColumn<String?>(
      'updated', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bookId,
        user,
        enabled,
        bookNo,
        title,
        subTitle,
        songs,
        position,
        created,
        updated
      ];
  @override
  String get aliasedName => _alias ?? 'books_table';
  @override
  String get actualTableName => 'books_table';
  @override
  VerificationContext validateIntegrity(Insertable<Books> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('book_no')) {
      context.handle(_bookNoMeta,
          bookNo.isAcceptableOrUnknown(data['book_no']!, _bookNoMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('sub_title')) {
      context.handle(_subTitleMeta,
          subTitle.isAcceptableOrUnknown(data['sub_title']!, _subTitleMeta));
    }
    if (data.containsKey('songs')) {
      context.handle(
          _songsMeta, songs.isAcceptableOrUnknown(data['songs']!, _songsMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Books map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Books.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BooksTableTable createAlias(String alias) {
    return $BooksTableTable(attachedDatabase, alias);
  }
}

class Drafts extends DataClass implements Insertable<Drafts> {
  final int id;
  final int draftId;
  final int user;
  final String title;
  final String alias;
  final String content;
  final String key;
  final String created;
  final String updated;
  Drafts(
      {required this.id,
      required this.draftId,
      required this.user,
      required this.title,
      required this.alias,
      required this.content,
      required this.key,
      required this.created,
      required this.updated});
  factory Drafts.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Drafts(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      draftId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}draft_id'])!,
      user: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      alias: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}alias'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
      updated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['draft_id'] = Variable<int>(draftId);
    map['user'] = Variable<int>(user);
    map['title'] = Variable<String>(title);
    map['alias'] = Variable<String>(alias);
    map['content'] = Variable<String>(content);
    map['key'] = Variable<String>(key);
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    return map;
  }

  DraftsTableCompanion toCompanion(bool nullToAbsent) {
    return DraftsTableCompanion(
      id: Value(id),
      draftId: Value(draftId),
      user: Value(user),
      title: Value(title),
      alias: Value(alias),
      content: Value(content),
      key: Value(key),
      created: Value(created),
      updated: Value(updated),
    );
  }

  factory Drafts.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Drafts(
      id: serializer.fromJson<int>(json['id']),
      draftId: serializer.fromJson<int>(json['draftId']),
      user: serializer.fromJson<int>(json['user']),
      title: serializer.fromJson<String>(json['title']),
      alias: serializer.fromJson<String>(json['alias']),
      content: serializer.fromJson<String>(json['content']),
      key: serializer.fromJson<String>(json['key']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'draftId': serializer.toJson<int>(draftId),
      'user': serializer.toJson<int>(user),
      'title': serializer.toJson<String>(title),
      'alias': serializer.toJson<String>(alias),
      'content': serializer.toJson<String>(content),
      'key': serializer.toJson<String>(key),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
    };
  }

  Drafts copyWith(
          {int? id,
          int? draftId,
          int? user,
          String? title,
          String? alias,
          String? content,
          String? key,
          String? created,
          String? updated}) =>
      Drafts(
        id: id ?? this.id,
        draftId: draftId ?? this.draftId,
        user: user ?? this.user,
        title: title ?? this.title,
        alias: alias ?? this.alias,
        content: content ?? this.content,
        key: key ?? this.key,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );
  @override
  String toString() {
    return (StringBuffer('Drafts(')
          ..write('id: $id, ')
          ..write('draftId: $draftId, ')
          ..write('user: $user, ')
          ..write('title: $title, ')
          ..write('alias: $alias, ')
          ..write('content: $content, ')
          ..write('key: $key, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, draftId, user, title, alias, content, key, created, updated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Drafts &&
          other.id == this.id &&
          other.draftId == this.draftId &&
          other.user == this.user &&
          other.title == this.title &&
          other.alias == this.alias &&
          other.content == this.content &&
          other.key == this.key &&
          other.created == this.created &&
          other.updated == this.updated);
}

class DraftsTableCompanion extends UpdateCompanion<Drafts> {
  final Value<int> id;
  final Value<int> draftId;
  final Value<int> user;
  final Value<String> title;
  final Value<String> alias;
  final Value<String> content;
  final Value<String> key;
  final Value<String> created;
  final Value<String> updated;
  const DraftsTableCompanion({
    this.id = const Value.absent(),
    this.draftId = const Value.absent(),
    this.user = const Value.absent(),
    this.title = const Value.absent(),
    this.alias = const Value.absent(),
    this.content = const Value.absent(),
    this.key = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  DraftsTableCompanion.insert({
    this.id = const Value.absent(),
    this.draftId = const Value.absent(),
    this.user = const Value.absent(),
    this.title = const Value.absent(),
    this.alias = const Value.absent(),
    this.content = const Value.absent(),
    this.key = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  static Insertable<Drafts> custom({
    Expression<int>? id,
    Expression<int>? draftId,
    Expression<int>? user,
    Expression<String>? title,
    Expression<String>? alias,
    Expression<String>? content,
    Expression<String>? key,
    Expression<String>? created,
    Expression<String>? updated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (draftId != null) 'draft_id': draftId,
      if (user != null) 'user': user,
      if (title != null) 'title': title,
      if (alias != null) 'alias': alias,
      if (content != null) 'content': content,
      if (key != null) 'key': key,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
    });
  }

  DraftsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? draftId,
      Value<int>? user,
      Value<String>? title,
      Value<String>? alias,
      Value<String>? content,
      Value<String>? key,
      Value<String>? created,
      Value<String>? updated}) {
    return DraftsTableCompanion(
      id: id ?? this.id,
      draftId: draftId ?? this.draftId,
      user: user ?? this.user,
      title: title ?? this.title,
      alias: alias ?? this.alias,
      content: content ?? this.content,
      key: key ?? this.key,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (draftId.present) {
      map['draft_id'] = Variable<int>(draftId.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftsTableCompanion(')
          ..write('id: $id, ')
          ..write('draftId: $draftId, ')
          ..write('user: $user, ')
          ..write('title: $title, ')
          ..write('alias: $alias, ')
          ..write('content: $content, ')
          ..write('key: $key, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }
}

class $DraftsTableTable extends DraftsTable
    with TableInfo<$DraftsTableTable, Drafts> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _draftIdMeta = const VerificationMeta('draftId');
  @override
  late final GeneratedColumn<int?> draftId = GeneratedColumn<int?>(
      'draft_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int?> user = GeneratedColumn<int?>(
      'user', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String?> alias = GeneratedColumn<String?>(
      'alias', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String?> key = GeneratedColumn<String?>(
      'key', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String?> updated = GeneratedColumn<String?>(
      'updated', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, draftId, user, title, alias, content, key, created, updated];
  @override
  String get aliasedName => _alias ?? 'drafts_table';
  @override
  String get actualTableName => 'drafts_table';
  @override
  VerificationContext validateIntegrity(Insertable<Drafts> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('draft_id')) {
      context.handle(_draftIdMeta,
          draftId.isAcceptableOrUnknown(data['draft_id']!, _draftIdMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('alias')) {
      context.handle(
          _aliasMeta, alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Drafts map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Drafts.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DraftsTableTable createAlias(String alias) {
    return $DraftsTableTable(attachedDatabase, alias);
  }
}

class Edits extends DataClass implements Insertable<Edits> {
  final int id;
  final int editId;
  final int user;
  final String song;
  final int book;
  final int songNo;
  final String title;
  final String alias;
  final String content;
  final String key;
  final String created;
  final String updated;
  Edits(
      {required this.id,
      required this.editId,
      required this.user,
      required this.song,
      required this.book,
      required this.songNo,
      required this.title,
      required this.alias,
      required this.content,
      required this.key,
      required this.created,
      required this.updated});
  factory Edits.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Edits(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      editId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}edit_id'])!,
      user: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user'])!,
      song: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}song'])!,
      book: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}book'])!,
      songNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}song_no'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      alias: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}alias'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
      updated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['edit_id'] = Variable<int>(editId);
    map['user'] = Variable<int>(user);
    map['song'] = Variable<String>(song);
    map['book'] = Variable<int>(book);
    map['song_no'] = Variable<int>(songNo);
    map['title'] = Variable<String>(title);
    map['alias'] = Variable<String>(alias);
    map['content'] = Variable<String>(content);
    map['key'] = Variable<String>(key);
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    return map;
  }

  EditsTableCompanion toCompanion(bool nullToAbsent) {
    return EditsTableCompanion(
      id: Value(id),
      editId: Value(editId),
      user: Value(user),
      song: Value(song),
      book: Value(book),
      songNo: Value(songNo),
      title: Value(title),
      alias: Value(alias),
      content: Value(content),
      key: Value(key),
      created: Value(created),
      updated: Value(updated),
    );
  }

  factory Edits.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Edits(
      id: serializer.fromJson<int>(json['id']),
      editId: serializer.fromJson<int>(json['editId']),
      user: serializer.fromJson<int>(json['user']),
      song: serializer.fromJson<String>(json['song']),
      book: serializer.fromJson<int>(json['book']),
      songNo: serializer.fromJson<int>(json['songNo']),
      title: serializer.fromJson<String>(json['title']),
      alias: serializer.fromJson<String>(json['alias']),
      content: serializer.fromJson<String>(json['content']),
      key: serializer.fromJson<String>(json['key']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'editId': serializer.toJson<int>(editId),
      'user': serializer.toJson<int>(user),
      'song': serializer.toJson<String>(song),
      'book': serializer.toJson<int>(book),
      'songNo': serializer.toJson<int>(songNo),
      'title': serializer.toJson<String>(title),
      'alias': serializer.toJson<String>(alias),
      'content': serializer.toJson<String>(content),
      'key': serializer.toJson<String>(key),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
    };
  }

  Edits copyWith(
          {int? id,
          int? editId,
          int? user,
          String? song,
          int? book,
          int? songNo,
          String? title,
          String? alias,
          String? content,
          String? key,
          String? created,
          String? updated}) =>
      Edits(
        id: id ?? this.id,
        editId: editId ?? this.editId,
        user: user ?? this.user,
        song: song ?? this.song,
        book: book ?? this.book,
        songNo: songNo ?? this.songNo,
        title: title ?? this.title,
        alias: alias ?? this.alias,
        content: content ?? this.content,
        key: key ?? this.key,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );
  @override
  String toString() {
    return (StringBuffer('Edits(')
          ..write('id: $id, ')
          ..write('editId: $editId, ')
          ..write('user: $user, ')
          ..write('song: $song, ')
          ..write('book: $book, ')
          ..write('songNo: $songNo, ')
          ..write('title: $title, ')
          ..write('alias: $alias, ')
          ..write('content: $content, ')
          ..write('key: $key, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, editId, user, song, book, songNo, title,
      alias, content, key, created, updated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Edits &&
          other.id == this.id &&
          other.editId == this.editId &&
          other.user == this.user &&
          other.song == this.song &&
          other.book == this.book &&
          other.songNo == this.songNo &&
          other.title == this.title &&
          other.alias == this.alias &&
          other.content == this.content &&
          other.key == this.key &&
          other.created == this.created &&
          other.updated == this.updated);
}

class EditsTableCompanion extends UpdateCompanion<Edits> {
  final Value<int> id;
  final Value<int> editId;
  final Value<int> user;
  final Value<String> song;
  final Value<int> book;
  final Value<int> songNo;
  final Value<String> title;
  final Value<String> alias;
  final Value<String> content;
  final Value<String> key;
  final Value<String> created;
  final Value<String> updated;
  const EditsTableCompanion({
    this.id = const Value.absent(),
    this.editId = const Value.absent(),
    this.user = const Value.absent(),
    this.song = const Value.absent(),
    this.book = const Value.absent(),
    this.songNo = const Value.absent(),
    this.title = const Value.absent(),
    this.alias = const Value.absent(),
    this.content = const Value.absent(),
    this.key = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  EditsTableCompanion.insert({
    this.id = const Value.absent(),
    this.editId = const Value.absent(),
    this.user = const Value.absent(),
    this.song = const Value.absent(),
    this.book = const Value.absent(),
    this.songNo = const Value.absent(),
    this.title = const Value.absent(),
    this.alias = const Value.absent(),
    this.content = const Value.absent(),
    this.key = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  static Insertable<Edits> custom({
    Expression<int>? id,
    Expression<int>? editId,
    Expression<int>? user,
    Expression<String>? song,
    Expression<int>? book,
    Expression<int>? songNo,
    Expression<String>? title,
    Expression<String>? alias,
    Expression<String>? content,
    Expression<String>? key,
    Expression<String>? created,
    Expression<String>? updated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (editId != null) 'edit_id': editId,
      if (user != null) 'user': user,
      if (song != null) 'song': song,
      if (book != null) 'book': book,
      if (songNo != null) 'song_no': songNo,
      if (title != null) 'title': title,
      if (alias != null) 'alias': alias,
      if (content != null) 'content': content,
      if (key != null) 'key': key,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
    });
  }

  EditsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? editId,
      Value<int>? user,
      Value<String>? song,
      Value<int>? book,
      Value<int>? songNo,
      Value<String>? title,
      Value<String>? alias,
      Value<String>? content,
      Value<String>? key,
      Value<String>? created,
      Value<String>? updated}) {
    return EditsTableCompanion(
      id: id ?? this.id,
      editId: editId ?? this.editId,
      user: user ?? this.user,
      song: song ?? this.song,
      book: book ?? this.book,
      songNo: songNo ?? this.songNo,
      title: title ?? this.title,
      alias: alias ?? this.alias,
      content: content ?? this.content,
      key: key ?? this.key,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (editId.present) {
      map['edit_id'] = Variable<int>(editId.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (song.present) {
      map['song'] = Variable<String>(song.value);
    }
    if (book.present) {
      map['book'] = Variable<int>(book.value);
    }
    if (songNo.present) {
      map['song_no'] = Variable<int>(songNo.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EditsTableCompanion(')
          ..write('id: $id, ')
          ..write('editId: $editId, ')
          ..write('user: $user, ')
          ..write('song: $song, ')
          ..write('book: $book, ')
          ..write('songNo: $songNo, ')
          ..write('title: $title, ')
          ..write('alias: $alias, ')
          ..write('content: $content, ')
          ..write('key: $key, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }
}

class $EditsTableTable extends EditsTable
    with TableInfo<$EditsTableTable, Edits> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EditsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _editIdMeta = const VerificationMeta('editId');
  @override
  late final GeneratedColumn<int?> editId = GeneratedColumn<int?>(
      'edit_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int?> user = GeneratedColumn<int?>(
      'user', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _songMeta = const VerificationMeta('song');
  @override
  late final GeneratedColumn<String?> song = GeneratedColumn<String?>(
      'song', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _bookMeta = const VerificationMeta('book');
  @override
  late final GeneratedColumn<int?> book = GeneratedColumn<int?>(
      'book', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _songNoMeta = const VerificationMeta('songNo');
  @override
  late final GeneratedColumn<int?> songNo = GeneratedColumn<int?>(
      'song_no', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String?> alias = GeneratedColumn<String?>(
      'alias', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String?> key = GeneratedColumn<String?>(
      'key', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String?> updated = GeneratedColumn<String?>(
      'updated', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        editId,
        user,
        song,
        book,
        songNo,
        title,
        alias,
        content,
        key,
        created,
        updated
      ];
  @override
  String get aliasedName => _alias ?? 'edits_table';
  @override
  String get actualTableName => 'edits_table';
  @override
  VerificationContext validateIntegrity(Insertable<Edits> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('edit_id')) {
      context.handle(_editIdMeta,
          editId.isAcceptableOrUnknown(data['edit_id']!, _editIdMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    }
    if (data.containsKey('song')) {
      context.handle(
          _songMeta, song.isAcceptableOrUnknown(data['song']!, _songMeta));
    }
    if (data.containsKey('book')) {
      context.handle(
          _bookMeta, book.isAcceptableOrUnknown(data['book']!, _bookMeta));
    }
    if (data.containsKey('song_no')) {
      context.handle(_songNoMeta,
          songNo.isAcceptableOrUnknown(data['song_no']!, _songNoMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('alias')) {
      context.handle(
          _aliasMeta, alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Edits map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Edits.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EditsTableTable createAlias(String alias) {
    return $EditsTableTable(attachedDatabase, alias);
  }
}

class Historys extends DataClass implements Insertable<Historys> {
  final int id;
  final int historyId;
  final int song;
  final String created;
  Historys(
      {required this.id,
      required this.historyId,
      required this.song,
      required this.created});
  factory Historys.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Historys(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      historyId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}history_id'])!,
      song: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}song'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['history_id'] = Variable<int>(historyId);
    map['song'] = Variable<int>(song);
    map['created'] = Variable<String>(created);
    return map;
  }

  HistorysTableCompanion toCompanion(bool nullToAbsent) {
    return HistorysTableCompanion(
      id: Value(id),
      historyId: Value(historyId),
      song: Value(song),
      created: Value(created),
    );
  }

  factory Historys.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Historys(
      id: serializer.fromJson<int>(json['id']),
      historyId: serializer.fromJson<int>(json['historyId']),
      song: serializer.fromJson<int>(json['song']),
      created: serializer.fromJson<String>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'historyId': serializer.toJson<int>(historyId),
      'song': serializer.toJson<int>(song),
      'created': serializer.toJson<String>(created),
    };
  }

  Historys copyWith({int? id, int? historyId, int? song, String? created}) =>
      Historys(
        id: id ?? this.id,
        historyId: historyId ?? this.historyId,
        song: song ?? this.song,
        created: created ?? this.created,
      );
  @override
  String toString() {
    return (StringBuffer('Historys(')
          ..write('id: $id, ')
          ..write('historyId: $historyId, ')
          ..write('song: $song, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, historyId, song, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Historys &&
          other.id == this.id &&
          other.historyId == this.historyId &&
          other.song == this.song &&
          other.created == this.created);
}

class HistorysTableCompanion extends UpdateCompanion<Historys> {
  final Value<int> id;
  final Value<int> historyId;
  final Value<int> song;
  final Value<String> created;
  const HistorysTableCompanion({
    this.id = const Value.absent(),
    this.historyId = const Value.absent(),
    this.song = const Value.absent(),
    this.created = const Value.absent(),
  });
  HistorysTableCompanion.insert({
    this.id = const Value.absent(),
    this.historyId = const Value.absent(),
    this.song = const Value.absent(),
    this.created = const Value.absent(),
  });
  static Insertable<Historys> custom({
    Expression<int>? id,
    Expression<int>? historyId,
    Expression<int>? song,
    Expression<String>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (historyId != null) 'history_id': historyId,
      if (song != null) 'song': song,
      if (created != null) 'created': created,
    });
  }

  HistorysTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? historyId,
      Value<int>? song,
      Value<String>? created}) {
    return HistorysTableCompanion(
      id: id ?? this.id,
      historyId: historyId ?? this.historyId,
      song: song ?? this.song,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (historyId.present) {
      map['history_id'] = Variable<int>(historyId.value);
    }
    if (song.present) {
      map['song'] = Variable<int>(song.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorysTableCompanion(')
          ..write('id: $id, ')
          ..write('historyId: $historyId, ')
          ..write('song: $song, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class $HistorysTableTable extends HistorysTable
    with TableInfo<$HistorysTableTable, Historys> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorysTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _historyIdMeta = const VerificationMeta('historyId');
  @override
  late final GeneratedColumn<int?> historyId = GeneratedColumn<int?>(
      'history_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _songMeta = const VerificationMeta('song');
  @override
  late final GeneratedColumn<int?> song = GeneratedColumn<int?>(
      'song', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, historyId, song, created];
  @override
  String get aliasedName => _alias ?? 'historys_table';
  @override
  String get actualTableName => 'historys_table';
  @override
  VerificationContext validateIntegrity(Insertable<Historys> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('history_id')) {
      context.handle(_historyIdMeta,
          historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta));
    }
    if (data.containsKey('song')) {
      context.handle(
          _songMeta, song.isAcceptableOrUnknown(data['song']!, _songMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Historys map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Historys.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HistorysTableTable createAlias(String alias) {
    return $HistorysTableTable(attachedDatabase, alias);
  }
}

class Listeds extends DataClass implements Insertable<Listeds> {
  final int id;
  final int listedId;
  final int user;
  final int parentid;
  final int song;
  final String title;
  final String description;
  final int position;
  final String created;
  final String updated;
  Listeds(
      {required this.id,
      required this.listedId,
      required this.user,
      required this.parentid,
      required this.song,
      required this.title,
      required this.description,
      required this.position,
      required this.created,
      required this.updated});
  factory Listeds.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Listeds(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      listedId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}listed_id'])!,
      user: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user'])!,
      parentid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}parentid'])!,
      song: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}song'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      position: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}position'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
      updated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['listed_id'] = Variable<int>(listedId);
    map['user'] = Variable<int>(user);
    map['parentid'] = Variable<int>(parentid);
    map['song'] = Variable<int>(song);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['position'] = Variable<int>(position);
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    return map;
  }

  ListedsTableCompanion toCompanion(bool nullToAbsent) {
    return ListedsTableCompanion(
      id: Value(id),
      listedId: Value(listedId),
      user: Value(user),
      parentid: Value(parentid),
      song: Value(song),
      title: Value(title),
      description: Value(description),
      position: Value(position),
      created: Value(created),
      updated: Value(updated),
    );
  }

  factory Listeds.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Listeds(
      id: serializer.fromJson<int>(json['id']),
      listedId: serializer.fromJson<int>(json['listedId']),
      user: serializer.fromJson<int>(json['user']),
      parentid: serializer.fromJson<int>(json['parentid']),
      song: serializer.fromJson<int>(json['song']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      position: serializer.fromJson<int>(json['position']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'listedId': serializer.toJson<int>(listedId),
      'user': serializer.toJson<int>(user),
      'parentid': serializer.toJson<int>(parentid),
      'song': serializer.toJson<int>(song),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'position': serializer.toJson<int>(position),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
    };
  }

  Listeds copyWith(
          {int? id,
          int? listedId,
          int? user,
          int? parentid,
          int? song,
          String? title,
          String? description,
          int? position,
          String? created,
          String? updated}) =>
      Listeds(
        id: id ?? this.id,
        listedId: listedId ?? this.listedId,
        user: user ?? this.user,
        parentid: parentid ?? this.parentid,
        song: song ?? this.song,
        title: title ?? this.title,
        description: description ?? this.description,
        position: position ?? this.position,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );
  @override
  String toString() {
    return (StringBuffer('Listeds(')
          ..write('id: $id, ')
          ..write('listedId: $listedId, ')
          ..write('user: $user, ')
          ..write('parentid: $parentid, ')
          ..write('song: $song, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('position: $position, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, listedId, user, parentid, song, title,
      description, position, created, updated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Listeds &&
          other.id == this.id &&
          other.listedId == this.listedId &&
          other.user == this.user &&
          other.parentid == this.parentid &&
          other.song == this.song &&
          other.title == this.title &&
          other.description == this.description &&
          other.position == this.position &&
          other.created == this.created &&
          other.updated == this.updated);
}

class ListedsTableCompanion extends UpdateCompanion<Listeds> {
  final Value<int> id;
  final Value<int> listedId;
  final Value<int> user;
  final Value<int> parentid;
  final Value<int> song;
  final Value<String> title;
  final Value<String> description;
  final Value<int> position;
  final Value<String> created;
  final Value<String> updated;
  const ListedsTableCompanion({
    this.id = const Value.absent(),
    this.listedId = const Value.absent(),
    this.user = const Value.absent(),
    this.parentid = const Value.absent(),
    this.song = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.position = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  ListedsTableCompanion.insert({
    this.id = const Value.absent(),
    this.listedId = const Value.absent(),
    this.user = const Value.absent(),
    this.parentid = const Value.absent(),
    this.song = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.position = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  static Insertable<Listeds> custom({
    Expression<int>? id,
    Expression<int>? listedId,
    Expression<int>? user,
    Expression<int>? parentid,
    Expression<int>? song,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? position,
    Expression<String>? created,
    Expression<String>? updated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listedId != null) 'listed_id': listedId,
      if (user != null) 'user': user,
      if (parentid != null) 'parentid': parentid,
      if (song != null) 'song': song,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (position != null) 'position': position,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
    });
  }

  ListedsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? listedId,
      Value<int>? user,
      Value<int>? parentid,
      Value<int>? song,
      Value<String>? title,
      Value<String>? description,
      Value<int>? position,
      Value<String>? created,
      Value<String>? updated}) {
    return ListedsTableCompanion(
      id: id ?? this.id,
      listedId: listedId ?? this.listedId,
      user: user ?? this.user,
      parentid: parentid ?? this.parentid,
      song: song ?? this.song,
      title: title ?? this.title,
      description: description ?? this.description,
      position: position ?? this.position,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (listedId.present) {
      map['listed_id'] = Variable<int>(listedId.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (parentid.present) {
      map['parentid'] = Variable<int>(parentid.value);
    }
    if (song.present) {
      map['song'] = Variable<int>(song.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListedsTableCompanion(')
          ..write('id: $id, ')
          ..write('listedId: $listedId, ')
          ..write('user: $user, ')
          ..write('parentid: $parentid, ')
          ..write('song: $song, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('position: $position, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }
}

class $ListedsTableTable extends ListedsTable
    with TableInfo<$ListedsTableTable, Listeds> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListedsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _listedIdMeta = const VerificationMeta('listedId');
  @override
  late final GeneratedColumn<int?> listedId = GeneratedColumn<int?>(
      'listed_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int?> user = GeneratedColumn<int?>(
      'user', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _parentidMeta = const VerificationMeta('parentid');
  @override
  late final GeneratedColumn<int?> parentid = GeneratedColumn<int?>(
      'parentid', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _songMeta = const VerificationMeta('song');
  @override
  late final GeneratedColumn<int?> song = GeneratedColumn<int?>(
      'song', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _positionMeta = const VerificationMeta('position');
  @override
  late final GeneratedColumn<int?> position = GeneratedColumn<int?>(
      'position', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String?> updated = GeneratedColumn<String?>(
      'updated', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        listedId,
        user,
        parentid,
        song,
        title,
        description,
        position,
        created,
        updated
      ];
  @override
  String get aliasedName => _alias ?? 'listeds_table';
  @override
  String get actualTableName => 'listeds_table';
  @override
  VerificationContext validateIntegrity(Insertable<Listeds> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('listed_id')) {
      context.handle(_listedIdMeta,
          listedId.isAcceptableOrUnknown(data['listed_id']!, _listedIdMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    }
    if (data.containsKey('parentid')) {
      context.handle(_parentidMeta,
          parentid.isAcceptableOrUnknown(data['parentid']!, _parentidMeta));
    }
    if (data.containsKey('song')) {
      context.handle(
          _songMeta, song.isAcceptableOrUnknown(data['song']!, _songMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Listeds map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Listeds.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ListedsTableTable createAlias(String alias) {
    return $ListedsTableTable(attachedDatabase, alias);
  }
}

class Searchs extends DataClass implements Insertable<Searchs> {
  final int id;
  final int searchId;
  final String title;
  final String created;
  Searchs(
      {required this.id,
      required this.searchId,
      required this.title,
      required this.created});
  factory Searchs.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Searchs(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      searchId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}search_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['search_id'] = Variable<int>(searchId);
    map['title'] = Variable<String>(title);
    map['created'] = Variable<String>(created);
    return map;
  }

  SearchsTableCompanion toCompanion(bool nullToAbsent) {
    return SearchsTableCompanion(
      id: Value(id),
      searchId: Value(searchId),
      title: Value(title),
      created: Value(created),
    );
  }

  factory Searchs.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Searchs(
      id: serializer.fromJson<int>(json['id']),
      searchId: serializer.fromJson<int>(json['searchId']),
      title: serializer.fromJson<String>(json['title']),
      created: serializer.fromJson<String>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'searchId': serializer.toJson<int>(searchId),
      'title': serializer.toJson<String>(title),
      'created': serializer.toJson<String>(created),
    };
  }

  Searchs copyWith({int? id, int? searchId, String? title, String? created}) =>
      Searchs(
        id: id ?? this.id,
        searchId: searchId ?? this.searchId,
        title: title ?? this.title,
        created: created ?? this.created,
      );
  @override
  String toString() {
    return (StringBuffer('Searchs(')
          ..write('id: $id, ')
          ..write('searchId: $searchId, ')
          ..write('title: $title, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, searchId, title, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Searchs &&
          other.id == this.id &&
          other.searchId == this.searchId &&
          other.title == this.title &&
          other.created == this.created);
}

class SearchsTableCompanion extends UpdateCompanion<Searchs> {
  final Value<int> id;
  final Value<int> searchId;
  final Value<String> title;
  final Value<String> created;
  const SearchsTableCompanion({
    this.id = const Value.absent(),
    this.searchId = const Value.absent(),
    this.title = const Value.absent(),
    this.created = const Value.absent(),
  });
  SearchsTableCompanion.insert({
    this.id = const Value.absent(),
    this.searchId = const Value.absent(),
    this.title = const Value.absent(),
    this.created = const Value.absent(),
  });
  static Insertable<Searchs> custom({
    Expression<int>? id,
    Expression<int>? searchId,
    Expression<String>? title,
    Expression<String>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (searchId != null) 'search_id': searchId,
      if (title != null) 'title': title,
      if (created != null) 'created': created,
    });
  }

  SearchsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? searchId,
      Value<String>? title,
      Value<String>? created}) {
    return SearchsTableCompanion(
      id: id ?? this.id,
      searchId: searchId ?? this.searchId,
      title: title ?? this.title,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (searchId.present) {
      map['search_id'] = Variable<int>(searchId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchsTableCompanion(')
          ..write('id: $id, ')
          ..write('searchId: $searchId, ')
          ..write('title: $title, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class $SearchsTableTable extends SearchsTable
    with TableInfo<$SearchsTableTable, Searchs> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _searchIdMeta = const VerificationMeta('searchId');
  @override
  late final GeneratedColumn<int?> searchId = GeneratedColumn<int?>(
      'search_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, searchId, title, created];
  @override
  String get aliasedName => _alias ?? 'searchs_table';
  @override
  String get actualTableName => 'searchs_table';
  @override
  VerificationContext validateIntegrity(Insertable<Searchs> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('search_id')) {
      context.handle(_searchIdMeta,
          searchId.isAcceptableOrUnknown(data['search_id']!, _searchIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Searchs map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Searchs.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchsTableTable createAlias(String alias) {
    return $SearchsTableTable(attachedDatabase, alias);
  }
}

class Songs extends DataClass implements Insertable<Songs> {
  final int id;
  final int songId;
  final int user;
  final int book;
  final int songNo;
  final String title;
  final String alias;
  final String content;
  final String key;
  final String author;
  final int views;
  final int likes;
  final String created;
  final String updated;
  final bool liked;
  Songs(
      {required this.id,
      required this.songId,
      required this.user,
      required this.book,
      required this.songNo,
      required this.title,
      required this.alias,
      required this.content,
      required this.key,
      required this.author,
      required this.views,
      required this.likes,
      required this.created,
      required this.updated,
      required this.liked});
  factory Songs.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Songs(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      songId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}song_id'])!,
      user: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user'])!,
      book: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}book'])!,
      songNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}song_no'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      alias: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}alias'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      author: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author'])!,
      views: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}views'])!,
      likes: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}likes'])!,
      created: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
      updated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated'])!,
      liked: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}liked'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['song_id'] = Variable<int>(songId);
    map['user'] = Variable<int>(user);
    map['book'] = Variable<int>(book);
    map['song_no'] = Variable<int>(songNo);
    map['title'] = Variable<String>(title);
    map['alias'] = Variable<String>(alias);
    map['content'] = Variable<String>(content);
    map['key'] = Variable<String>(key);
    map['author'] = Variable<String>(author);
    map['views'] = Variable<int>(views);
    map['likes'] = Variable<int>(likes);
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    map['liked'] = Variable<bool>(liked);
    return map;
  }

  SongsTableCompanion toCompanion(bool nullToAbsent) {
    return SongsTableCompanion(
      id: Value(id),
      songId: Value(songId),
      user: Value(user),
      book: Value(book),
      songNo: Value(songNo),
      title: Value(title),
      alias: Value(alias),
      content: Value(content),
      key: Value(key),
      author: Value(author),
      views: Value(views),
      likes: Value(likes),
      created: Value(created),
      updated: Value(updated),
      liked: Value(liked),
    );
  }

  factory Songs.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Songs(
      id: serializer.fromJson<int>(json['id']),
      songId: serializer.fromJson<int>(json['songId']),
      user: serializer.fromJson<int>(json['user']),
      book: serializer.fromJson<int>(json['book']),
      songNo: serializer.fromJson<int>(json['songNo']),
      title: serializer.fromJson<String>(json['title']),
      alias: serializer.fromJson<String>(json['alias']),
      content: serializer.fromJson<String>(json['content']),
      key: serializer.fromJson<String>(json['key']),
      author: serializer.fromJson<String>(json['author']),
      views: serializer.fromJson<int>(json['views']),
      likes: serializer.fromJson<int>(json['likes']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
      liked: serializer.fromJson<bool>(json['liked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'songId': serializer.toJson<int>(songId),
      'user': serializer.toJson<int>(user),
      'book': serializer.toJson<int>(book),
      'songNo': serializer.toJson<int>(songNo),
      'title': serializer.toJson<String>(title),
      'alias': serializer.toJson<String>(alias),
      'content': serializer.toJson<String>(content),
      'key': serializer.toJson<String>(key),
      'author': serializer.toJson<String>(author),
      'views': serializer.toJson<int>(views),
      'likes': serializer.toJson<int>(likes),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
      'liked': serializer.toJson<bool>(liked),
    };
  }

  Songs copyWith(
          {int? id,
          int? songId,
          int? user,
          int? book,
          int? songNo,
          String? title,
          String? alias,
          String? content,
          String? key,
          String? author,
          int? views,
          int? likes,
          String? created,
          String? updated,
          bool? liked}) =>
      Songs(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        user: user ?? this.user,
        book: book ?? this.book,
        songNo: songNo ?? this.songNo,
        title: title ?? this.title,
        alias: alias ?? this.alias,
        content: content ?? this.content,
        key: key ?? this.key,
        author: author ?? this.author,
        views: views ?? this.views,
        likes: likes ?? this.likes,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        liked: liked ?? this.liked,
      );
  @override
  String toString() {
    return (StringBuffer('Songs(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('user: $user, ')
          ..write('book: $book, ')
          ..write('songNo: $songNo, ')
          ..write('title: $title, ')
          ..write('alias: $alias, ')
          ..write('content: $content, ')
          ..write('key: $key, ')
          ..write('author: $author, ')
          ..write('views: $views, ')
          ..write('likes: $likes, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('liked: $liked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, songId, user, book, songNo, title, alias,
      content, key, author, views, likes, created, updated, liked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Songs &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.user == this.user &&
          other.book == this.book &&
          other.songNo == this.songNo &&
          other.title == this.title &&
          other.alias == this.alias &&
          other.content == this.content &&
          other.key == this.key &&
          other.author == this.author &&
          other.views == this.views &&
          other.likes == this.likes &&
          other.created == this.created &&
          other.updated == this.updated &&
          other.liked == this.liked);
}

class SongsTableCompanion extends UpdateCompanion<Songs> {
  final Value<int> id;
  final Value<int> songId;
  final Value<int> user;
  final Value<int> book;
  final Value<int> songNo;
  final Value<String> title;
  final Value<String> alias;
  final Value<String> content;
  final Value<String> key;
  final Value<String> author;
  final Value<int> views;
  final Value<int> likes;
  final Value<String> created;
  final Value<String> updated;
  final Value<bool> liked;
  const SongsTableCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.user = const Value.absent(),
    this.book = const Value.absent(),
    this.songNo = const Value.absent(),
    this.title = const Value.absent(),
    this.alias = const Value.absent(),
    this.content = const Value.absent(),
    this.key = const Value.absent(),
    this.author = const Value.absent(),
    this.views = const Value.absent(),
    this.likes = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.liked = const Value.absent(),
  });
  SongsTableCompanion.insert({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.user = const Value.absent(),
    this.book = const Value.absent(),
    this.songNo = const Value.absent(),
    this.title = const Value.absent(),
    this.alias = const Value.absent(),
    this.content = const Value.absent(),
    this.key = const Value.absent(),
    this.author = const Value.absent(),
    this.views = const Value.absent(),
    this.likes = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.liked = const Value.absent(),
  });
  static Insertable<Songs> custom({
    Expression<int>? id,
    Expression<int>? songId,
    Expression<int>? user,
    Expression<int>? book,
    Expression<int>? songNo,
    Expression<String>? title,
    Expression<String>? alias,
    Expression<String>? content,
    Expression<String>? key,
    Expression<String>? author,
    Expression<int>? views,
    Expression<int>? likes,
    Expression<String>? created,
    Expression<String>? updated,
    Expression<bool>? liked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (user != null) 'user': user,
      if (book != null) 'book': book,
      if (songNo != null) 'song_no': songNo,
      if (title != null) 'title': title,
      if (alias != null) 'alias': alias,
      if (content != null) 'content': content,
      if (key != null) 'key': key,
      if (author != null) 'author': author,
      if (views != null) 'views': views,
      if (likes != null) 'likes': likes,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
      if (liked != null) 'liked': liked,
    });
  }

  SongsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? songId,
      Value<int>? user,
      Value<int>? book,
      Value<int>? songNo,
      Value<String>? title,
      Value<String>? alias,
      Value<String>? content,
      Value<String>? key,
      Value<String>? author,
      Value<int>? views,
      Value<int>? likes,
      Value<String>? created,
      Value<String>? updated,
      Value<bool>? liked}) {
    return SongsTableCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      user: user ?? this.user,
      book: book ?? this.book,
      songNo: songNo ?? this.songNo,
      title: title ?? this.title,
      alias: alias ?? this.alias,
      content: content ?? this.content,
      key: key ?? this.key,
      author: author ?? this.author,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      liked: liked ?? this.liked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<int>(songId.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    if (book.present) {
      map['book'] = Variable<int>(book.value);
    }
    if (songNo.present) {
      map['song_no'] = Variable<int>(songNo.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (views.present) {
      map['views'] = Variable<int>(views.value);
    }
    if (likes.present) {
      map['likes'] = Variable<int>(likes.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    if (liked.present) {
      map['liked'] = Variable<bool>(liked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongsTableCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('user: $user, ')
          ..write('book: $book, ')
          ..write('songNo: $songNo, ')
          ..write('title: $title, ')
          ..write('alias: $alias, ')
          ..write('content: $content, ')
          ..write('key: $key, ')
          ..write('author: $author, ')
          ..write('views: $views, ')
          ..write('likes: $likes, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('liked: $liked')
          ..write(')'))
        .toString();
  }
}

class $SongsTableTable extends SongsTable
    with TableInfo<$SongsTableTable, Songs> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<int?> songId = GeneratedColumn<int?>(
      'song_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int?> user = GeneratedColumn<int?>(
      'user', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _bookMeta = const VerificationMeta('book');
  @override
  late final GeneratedColumn<int?> book = GeneratedColumn<int?>(
      'book', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _songNoMeta = const VerificationMeta('songNo');
  @override
  late final GeneratedColumn<int?> songNo = GeneratedColumn<int?>(
      'song_no', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String?> alias = GeneratedColumn<String?>(
      'alias', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String?> key = GeneratedColumn<String?>(
      'key', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String?> author = GeneratedColumn<String?>(
      'author', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _viewsMeta = const VerificationMeta('views');
  @override
  late final GeneratedColumn<int?> views = GeneratedColumn<int?>(
      'views', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _likesMeta = const VerificationMeta('likes');
  @override
  late final GeneratedColumn<int?> likes = GeneratedColumn<int?>(
      'likes', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<String?> created = GeneratedColumn<String?>(
      'created', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String?> updated = GeneratedColumn<String?>(
      'updated', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  final VerificationMeta _likedMeta = const VerificationMeta('liked');
  @override
  late final GeneratedColumn<bool?> liked = GeneratedColumn<bool?>(
      'liked', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (liked IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        songId,
        user,
        book,
        songNo,
        title,
        alias,
        content,
        key,
        author,
        views,
        likes,
        created,
        updated,
        liked
      ];
  @override
  String get aliasedName => _alias ?? 'songs_table';
  @override
  String get actualTableName => 'songs_table';
  @override
  VerificationContext validateIntegrity(Insertable<Songs> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    }
    if (data.containsKey('book')) {
      context.handle(
          _bookMeta, book.isAcceptableOrUnknown(data['book']!, _bookMeta));
    }
    if (data.containsKey('song_no')) {
      context.handle(_songNoMeta,
          songNo.isAcceptableOrUnknown(data['song_no']!, _songNoMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('alias')) {
      context.handle(
          _aliasMeta, alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('views')) {
      context.handle(
          _viewsMeta, views.isAcceptableOrUnknown(data['views']!, _viewsMeta));
    }
    if (data.containsKey('likes')) {
      context.handle(
          _likesMeta, likes.isAcceptableOrUnknown(data['likes']!, _likesMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    }
    if (data.containsKey('liked')) {
      context.handle(
          _likedMeta, liked.isAcceptableOrUnknown(data['liked']!, _likedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Songs map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Songs.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SongsTableTable createAlias(String alias) {
    return $SongsTableTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$AppDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $BooksTableTable booksTable = $BooksTableTable(this);
  late final $DraftsTableTable draftsTable = $DraftsTableTable(this);
  late final $EditsTableTable editsTable = $EditsTableTable(this);
  late final $HistorysTableTable historysTable = $HistorysTableTable(this);
  late final $ListedsTableTable listedsTable = $ListedsTableTable(this);
  late final $SearchsTableTable searchsTable = $SearchsTableTable(this);
  late final $SongsTableTable songsTable = $SongsTableTable(this);
  late final BookDao bookDao = BookDao(this as AppDatabase);
  late final DraftDao draftDao = DraftDao(this as AppDatabase);
  late final EditDao editDao = EditDao(this as AppDatabase);
  late final HistoryDao historyDao = HistoryDao(this as AppDatabase);
  late final ListedDao listedDao = ListedDao(this as AppDatabase);
  late final SearchDao searchDao = SearchDao(this as AppDatabase);
  late final SongDao songDao = SongDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        booksTable,
        draftsTable,
        editsTable,
        historysTable,
        listedsTable,
        searchsTable,
        songsTable
      ];
}
