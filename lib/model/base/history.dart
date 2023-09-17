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

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    historyId = json['historyId'];
    song = json['song'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['historyId'] = historyId;
    data['song'] = song;
    data['created'] = created;
    return data;
  }
}
