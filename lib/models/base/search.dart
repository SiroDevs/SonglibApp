import 'package:drift/drift.dart';

class Search {
  int? id;
  String? objectId;
  String? title;
  String? createdAt;

  Search({
    this.id,
    this.objectId,
    this.title,
    this.createdAt,
  });

  Search.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['objectId'];
    title = json['title'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['objectId'] = objectId;
    data['title'] = title;
    data['createdAt'] = createdAt;
    return data;
  }

  factory Search.fromData(Map<String, dynamic> data) {
    return Search(
      id: const IntType().mapFromDatabaseResponse(data['id'])!,
      objectId: const StringType().mapFromDatabaseResponse(data['object_id'])!,
      title: const StringType().mapFromDatabaseResponse(data['title'])!,
      createdAt:
          const StringType().mapFromDatabaseResponse(data['created_at'])!,
    );
  }
}
