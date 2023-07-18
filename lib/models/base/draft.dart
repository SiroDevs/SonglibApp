import 'package:drift/drift.dart';

class Draft {
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

  Draft({
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

  Draft.fromJson(Map<String, dynamic> json) {
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

  factory Draft.fromData(Map<String, dynamic> data) {
    return Draft(
      id: const IntType().mapFromDatabaseResponse(data['id'])!,
      objectId: const StringType().mapFromDatabaseResponse(data['object_id'])!,
      book: const IntType().mapFromDatabaseResponse(data['book'])!,
      songNo: const IntType().mapFromDatabaseResponse(data['song_no'])!,
      title: const StringType().mapFromDatabaseResponse(data['title'])!,
      alias: const StringType().mapFromDatabaseResponse(data['alias'])!,
      content: const StringType().mapFromDatabaseResponse(data['content'])!,
      key: const StringType().mapFromDatabaseResponse(data['key'])!,
      author: const StringType().mapFromDatabaseResponse(data['author'])!,
      views: const IntType().mapFromDatabaseResponse(data['views'])!,
      createdAt:
          const StringType().mapFromDatabaseResponse(data['created_at'])!,
      updatedAt:
          const StringType().mapFromDatabaseResponse(data['updated_at'])!,
      liked: const BoolType().mapFromDatabaseResponse(data['liked'])!,
    );
  }
}
