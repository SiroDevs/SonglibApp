import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {
  int? id;
  int? songId;
  int? user;
  int? book;
  int? songNo;
  String? title;
  String? alias;
  String? content;
  String? key;
  String? author;
  int? views;
  int? likes;
  bool? liked;
  String? created;
  String? updated;

  Song({
    this.id,
    this.songId,
    this.user,
    this.book,
    this.songNo,
    this.title,
    this.alias,
    this.content,
    this.key,
    this.author,
    this.views,
    this.likes,
    this.liked,
    this.created,
    this.updated,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}

@JsonSerializable()
class SongExt {
  int? book;
  int? songNo;
  String? objectId;
  String? title;
  String? alias;
  String? content;
  String? key;
  String? author;
  int? views;
  int? likes;
  String? created;
  String? updated;
  bool? liked;
  int? id;
  String? songbook;

  SongExt({
    this.book,
    this.songNo,
    this.objectId,
    this.title,
    this.alias,
    this.content,
    this.key,
    this.author,
    this.views,
    this.likes,
    this.created,
    this.updated,
    this.liked,
    this.id,
    this.songbook,
  });

  factory SongExt.fromJson(Map<String, dynamic> json) => _$SongExtFromJson(json);
}

@JsonSerializable()
class Draft {
  int? id;
  int? draftId;
  int? user;
  String? title;
  String? alias;
  String? content;
  String? key;
  bool? liked;
  String? created;
  String? updated;

  Draft({
    this.id,
    this.draftId,
    this.user,
    this.title,
    this.alias,
    this.content,
    this.key,
    this.liked,
    this.created,
    this.updated,
  });

  factory Draft.fromJson(Map<String, dynamic> json) => _$DraftFromJson(json);
}

@JsonSerializable()
class Edit {
  int? id;
  int? editId;
  int? user;
  String? song;
  int? book;
  int? songNo;
  String? title;
  String? alias;
  String? content;
  String? key;
  String? created;
  String? updated;

  Edit({
    this.id,
    this.editId,
    this.user,
    this.song,
    this.book,
    this.songNo,
    this.title,
    this.alias,
    this.content,
    this.key,
    this.created,
    this.updated,
  });
  factory Edit.fromJson(Map<String, dynamic> json) => _$EditFromJson(json);
}
