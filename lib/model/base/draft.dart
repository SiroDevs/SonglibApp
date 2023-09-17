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

  Draft.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    draftId = json['draftId'];
    title = json['title'];
    alias = json['alias'];
    content = json['content'];
    key = json['key'];
    liked = json['liked'] == 1 ? true : false;
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['draftId'] = draftId;
    data['user'] = user;
    data['title'] = title;
    data['alias'] = alias;
    data['content'] = content;
    data['key'] = key;
    data['liked'] = liked;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }

  factory Draft.fromData(Map<String, dynamic> data) {
    return Draft(
      id: data['id'],
      draftId: data['draft_id'],
      user: data['user'],
      title: data['title'],
      alias: data['alias'],
      content: data['content'],
      key: data['key'],
      liked: data['liked'],
      created: data['created'],
      updated: data['updated'],
    );
  }
}
