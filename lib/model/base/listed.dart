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

  Listed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listedId = json['listedId'];
    user = json['user'];
    parentid = json['parentid'];
    song = json['song'];
    title = json['title'];
    description = json['description'];
    position = json['position'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['listedId'] = listedId;
    data['user'] = user;
    data['parentid'] = parentid;
    data['song'] = song;
    data['title'] = title;
    data['description'] = description;
    data['position'] = position;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }

  factory Listed.fromData(Map<String, dynamic> data) {
    return Listed(
      id: data['id'],
      listedId: data['listed_id'],
      user: data['user'],
      parentid: data['parentid'],
      song: data['songCount'],
      title: data['title'],
      description:
          data['description'],
      position: data['position'],
      created:
          data['created'],
      updated:
          data['updated'],
    );
  }
}
