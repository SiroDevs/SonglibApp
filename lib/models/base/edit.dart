import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../utils/utilities.dart';

class Edit {
  int? id;
  String? song;
  int? book;
  int? songNo;
  String? title;
  String? alias;
  String? content;
  String? key;
  String? createdAt;

  Edit({
    this.id,
    this.song,
    this.book,
    this.songNo,
    this.title,
    this.alias,
    this.content,
    this.key,
    this.createdAt,
  });

  Edit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    song = json['song'];
    book = json['book'];
    songNo = json['songNo'];
    title = json['title'];
    alias = json['alias'];
    content = json['content'];
    key = json['key'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['song'] = song;
    data['book'] = book;
    data['songNo'] = songNo;
    data['title'] = title;
    data['alias'] = alias;
    data['content'] = content;
    data['key'] = key;
    data['createdAt'] = createdAt;
    return data;
  }

  List<Edit> fromData(List<ParseObject> data) {
    return data
        .map(
          (object) => Edit(
            song: object.get<String>('song'),
            id: object.get<int>('id'),
            book: object.get<int>('book'),
            songNo: object.get<int>('songNo'),
            title: object.get<String>('title'),
            alias: object.get<String>('alias'),
            content: object.get<String>('content'),
            key: object.get<String>('key'),
            createdAt: dateToString(object.get<DateTime>('createdAt')!),
          ),
        )
        .toList();
  }
}
