// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listed _$ListedFromJson(Map<String, dynamic> json) => Listed(
      id: json['id'] as int?,
      listedId: json['listedId'] as int?,
      user: json['user'] as int?,
      parentid: json['parentid'] as int?,
      song: json['song'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      position: json['position'] as int?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );

Map<String, dynamic> _$ListedToJson(Listed instance) => <String, dynamic>{
      'id': instance.id,
      'listedId': instance.listedId,
      'user': instance.user,
      'parentid': instance.parentid,
      'song': instance.song,
      'title': instance.title,
      'description': instance.description,
      'position': instance.position,
      'created': instance.created,
      'updated': instance.updated,
    };

ListedExt _$ListedExtFromJson(Map<String, dynamic> json) => ListedExt(
      parentid: json['parentid'] as int?,
      position: json['position'] as int?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      id: json['id'] as int?,
      song: json['song'] as int?,
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
      songId: json['songId'] as int?,
      songbook: json['songbook'] as String?,
    );

Map<String, dynamic> _$ListedExtToJson(ListedExt instance) => <String, dynamic>{
      'parentid': instance.parentid,
      'position': instance.position,
      'created': instance.created,
      'updated': instance.updated,
      'id': instance.id,
      'song': instance.song,
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
      'songId': instance.songId,
      'songbook': instance.songbook,
    };

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      id: json['id'] as int?,
      searchId: json['searchId'] as int?,
      title: json['title'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'id': instance.id,
      'searchId': instance.searchId,
      'title': instance.title,
      'created': instance.created,
    };

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      id: json['id'] as int?,
      historyId: json['historyId'] as int?,
      song: json['song'] as int?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'id': instance.id,
      'historyId': instance.historyId,
      'song': instance.song,
      'created': instance.created,
    };

HistoryExt _$HistoryExtFromJson(Map<String, dynamic> json) => HistoryExt(
      id: json['id'] as int?,
      created: json['created'] as String?,
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
      songId: json['songId'] as int?,
      songbook: json['songbook'] as String?,
    );

Map<String, dynamic> _$HistoryExtToJson(HistoryExt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
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
      'songId': instance.songId,
      'songbook': instance.songbook,
    };
