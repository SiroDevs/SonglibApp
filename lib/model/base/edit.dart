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

  Edit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    editId = json['editId'];
    user = json['user'];
    song = json['song'];
    book = json['book'];
    songNo = json['songNo'];
    title = json['title'];
    alias = json['alias'];
    content = json['content'];
    key = json['key'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['editId'] = editId;
    data['user'] = user;
    data['song'] = song;
    data['book'] = book;
    data['songNo'] = songNo;
    data['title'] = title;
    data['alias'] = alias;
    data['content'] = content;
    data['key'] = key;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }

  /*List<Edit> fromData(List<ParseObject> data) {
    return data
        .map(
          (edit) => Edit(
            song: edit.get<String>('song'),
            id: edit.get<int>('id'),
            book: edit.get<int>('book'),
            songNo: edit.get<int>('songNo'),
            title: edit.get<String>('title'),
            alias: edit.get<String>('alias'),
            content: edit.get<String>('content'),
            key: edit.get<String>('key'),
            created: dateToString(edit.get<DateTime>('created')!),
            updated: dateToString(edit.get<DateTime>('updated')!),
          ),
        )
        .toList();
  }*/
}
