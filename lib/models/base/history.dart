class History {
  int? id;
  String? objectId;
  int? song;
  String? createdAt;

  History({
    this.id,
    this.objectId,
    this.song,
    this.createdAt,
  });

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['objectId'];
    song = json['song'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['objectId'] = objectId;
    data['song'] = song;
    data['createdAt'] = createdAt;
    return data;
  }
}
