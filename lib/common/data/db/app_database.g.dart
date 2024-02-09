// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTableTable extends BooksTable
    with TableInfo<$BooksTableTable, Books> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int> user = GeneratedColumn<int>(
      'user', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _bookNoMeta = const VerificationMeta('bookNo');
  @override
  late final GeneratedColumn<int> bookNo = GeneratedColumn<int>(
      'book_no', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _subTitleMeta =
      const VerificationMeta('subTitle');
  @override
  late final GeneratedColumn<String> subTitle = GeneratedColumn<String>(
      'sub_title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _songsMeta = const VerificationMeta('songs');
  @override
  late final GeneratedColumn<int> songs = GeneratedColumn<int>(
      'songs', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
      'created', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _updatedMeta =
      const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String> updated = GeneratedColumn<String>(
      'updated', aliasedName, false,
      type: DriftSqlType.string,
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books_table';
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Books(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
      bookNo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_no'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_title'])!,
      songs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}songs'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created'])!,
      updated: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated'])!,
    );
  }

  @override
  $BooksTableTable createAlias(String alias) {
    return $BooksTableTable(attachedDatabase, alias);
  }
}

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
  const Books(
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $BooksTableTable booksTable = $BooksTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [booksTable];
}
