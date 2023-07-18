import 'package:drift/drift.dart';

class Listed {
  int? id;
  String? objectId;
  int? parentid;
  int? song;
  String? title;
  String? description;
  int? position;
  String? createdAt;
  String? updatedAt;

  Listed({
    this.id,
    this.objectId,
    this.parentid,
    this.song,
    this.title,
    this.description,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  Listed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['objectId'];
    parentid = json['parentid'];
    song = json['song'];
    title = json['title'];
    description = json['description'];
    position = json['position'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['objectId'] = objectId;
    data['parentid'] = parentid;
    data['song'] = song;
    data['title'] = title;
    data['description'] = description;
    data['position'] = position;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory Listed.fromData(Map<String, dynamic> data) {
    return Listed(
      id: const IntType().mapFromDatabaseResponse(data['id'])!,
      objectId: const StringType().mapFromDatabaseResponse(data['object_id'])!,
      parentid: const IntType().mapFromDatabaseResponse(data['parentid'])!,
      song: const IntType().mapFromDatabaseResponse(data['songCount'])!,
      title: const StringType().mapFromDatabaseResponse(data['title'])!,
      description:
          const StringType().mapFromDatabaseResponse(data['description'])!,
      position: const IntType().mapFromDatabaseResponse(data['position'])!,
      createdAt:
          const StringType().mapFromDatabaseResponse(data['created_at'])!,
      updatedAt:
          const StringType().mapFromDatabaseResponse(data['updated_at'])!,
    );
  }
}
