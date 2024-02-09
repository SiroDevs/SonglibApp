import 'package:json_annotation/json_annotation.dart';

part 'lists.g.dart';

@JsonSerializable()
class Listed {
  int? id;
  int? listedId;
  int? user;
  int? parentid;
  int? song;
  String? title;
  String? description;
  int? position;
  String? created;
  String? updated;

  Listed({
    this.id,
    this.listedId,
    this.user,
    this.parentid,
    this.song,
    this.title,
    this.description,
    this.position,
    this.created,
    this.updated,
  });

  factory Listed.fromJson(Map<String, dynamic> json) => _$ListedFromJson(json);
}

@JsonSerializable()
class ListedExt {
  int? parentid;
  int? position;
  String? created;
  String? updated;
  int? id;
  int? song;
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
  int? songId;
  String? songbook;

  ListedExt({
    this.parentid,
    this.position,
    this.created,
    this.updated,
    this.id,
    this.song,
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
    this.songId,
    this.songbook,
  });

  factory ListedExt.fromJson(Map<String, dynamic> json) =>
      _$ListedExtFromJson(json);
}

@JsonSerializable()
class Search {
  int? id;
  int? searchId;
  String? title;
  String? created;

  Search({
    this.id,
    this.searchId,
    this.title,
    this.created,
  });
  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
}

@JsonSerializable()
class History {
  int? id;
  int? historyId;
  int? song;
  String? created;

  History({
    this.id,
    this.historyId,
    this.song,
    this.created,
  });

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
}

@JsonSerializable()
class HistoryExt {
  int? id;
  String? created;
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
  int? songId;
  String? songbook;

  HistoryExt({
    this.id,
    this.created,
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
    this.songId,
    this.songbook,
  });

  factory HistoryExt.fromJson(Map<String, dynamic> json) => _$HistoryExtFromJson(json);
}