// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      id: json['id'] as int?,
      songId: json['songId'] as int?,
      user: json['user'] as int?,
      book: json['book'] as int?,
      songNo: json['songNo'] as int?,
      title: json['title'] as String?,
      alias: json['alias'] as String?,
      content: json['content'] as String?,
      key: json['key'] as String?,
      author: json['author'] as String?,
      views: json['views'] as int?,
      likes: json['likes'] as int?,
      liked: json['liked'] as bool?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'songId': instance.songId,
      'user': instance.user,
      'book': instance.book,
      'songNo': instance.songNo,
      'title': instance.title,
      'alias': instance.alias,
      'content': instance.content,
      'key': instance.key,
      'author': instance.author,
      'views': instance.views,
      'likes': instance.likes,
      'liked': instance.liked,
      'created': instance.created,
      'updated': instance.updated,
    };

SongExt _$SongExtFromJson(Map<String, dynamic> json) => SongExt(
      book: json['book'] as int?,
      songNo: json['songNo'] as int?,
      objectId: json['objectId'] as String?,
      title: json['title'] as String?,
      alias: json['alias'] as String?,
      content: json['content'] as String?,
      key: json['key'] as String?,
      author: json['author'] as String?,
      views: json['views'] as int?,
      likes: json['likes'] as int?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      liked: json['liked'] as bool?,
      id: json['id'] as int?,
      songbook: json['songbook'] as String?,
    );

Map<String, dynamic> _$SongExtToJson(SongExt instance) => <String, dynamic>{
      'book': instance.book,
      'songNo': instance.songNo,
      'objectId': instance.objectId,
      'title': instance.title,
      'alias': instance.alias,
      'content': instance.content,
      'key': instance.key,
      'author': instance.author,
      'views': instance.views,
      'likes': instance.likes,
      'created': instance.created,
      'updated': instance.updated,
      'liked': instance.liked,
      'id': instance.id,
      'songbook': instance.songbook,
    };

Draft _$DraftFromJson(Map<String, dynamic> json) => Draft(
      id: json['id'] as int?,
      draftId: json['draftId'] as int?,
      user: json['user'] as int?,
      title: json['title'] as String?,
      alias: json['alias'] as String?,
      content: json['content'] as String?,
      key: json['key'] as String?,
      liked: json['liked'] as bool?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );

Map<String, dynamic> _$DraftToJson(Draft instance) => <String, dynamic>{
      'id': instance.id,
      'draftId': instance.draftId,
      'user': instance.user,
      'title': instance.title,
      'alias': instance.alias,
      'content': instance.content,
      'key': instance.key,
      'liked': instance.liked,
      'created': instance.created,
      'updated': instance.updated,
    };

Edit _$EditFromJson(Map<String, dynamic> json) => Edit(
      id: json['id'] as int?,
      editId: json['editId'] as int?,
      user: json['user'] as int?,
      song: json['song'] as String?,
      book: json['book'] as int?,
      songNo: json['songNo'] as int?,
      title: json['title'] as String?,
      alias: json['alias'] as String?,
      content: json['content'] as String?,
      key: json['key'] as String?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );

Map<String, dynamic> _$EditToJson(Edit instance) => <String, dynamic>{
      'id': instance.id,
      'editId': instance.editId,
      'user': instance.user,
      'song': instance.song,
      'book': instance.book,
      'songNo': instance.songNo,
      'title': instance.title,
      'alias': instance.alias,
      'content': instance.content,
      'key': instance.key,
      'created': instance.created,
      'updated': instance.updated,
    };
