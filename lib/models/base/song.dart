import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../utils/utilities.dart';

class Song {
  int? id;
  String? objectId;
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
  String? createdAt;
  String? updatedAt;

  Song({
    this.id,
    this.objectId,
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
    this.createdAt,
    this.updatedAt,
  });

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['objectId'];
    book = json['book'];
    songNo = json['songNo'];
    title = json['title'];
    alias = json['alias'];
    content = json['content'];
    key = json['key'];
    author = json['author'];
    views = json['views'];
    likes = json['likes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['objectId'] = objectId;
    data['book'] = book;
    data['songNo'] = songNo;
    data['title'] = title;
    data['alias'] = alias;
    data['content'] = content;
    data['key'] = key;
    data['author'] = author;
    data['views'] = views;
    data['likes'] = likes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  List<Song> fromData(List<ParseObject?> data) {
    return data
        .map(
          (object) => Song(
            objectId: object!.get<String>('objectId'),
            id: object.get<int>('id'),
            book: object.get<int>('book'),
            songNo: object.get<int>('songNo'),
            title: object.get<String>('title'),
            alias: object.get<String>('alias'),
            content: object.get<String>('content'),
            author: object.get<String>('author'),
            key: object.get<String>('key'),
            views: object.get<int>('views'),
            likes: object.get<int>('likes'),
            liked: object.get<bool>('liked'),
            createdAt: dateToString(object.get<DateTime>('createdAt')!),
            updatedAt: dateToString(object.get<DateTime>('updatedAt')!),
          ),
        )
        .toList();
  }
}
