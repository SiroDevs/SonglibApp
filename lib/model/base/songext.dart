class SongExt {
  int? book;
  int? songNo;
  String? objectId;
  String? title;
  String? alias;
  String? content;
  String? key;
  String? author;
  int? views;
  int? likes;
  String? created;
  String? updated;
  bool? liked;
  int? id;
  String? songbook;

  SongExt({
    this.book,
    this.songNo,
    this.objectId,
    this.title,
    this.alias,
    this.content,
    this.key,
    this.author,
    this.views,
    this.likes,
    this.created,
    this.updated,
    this.liked,
    this.id,
    this.songbook,
  });

  factory SongExt.fromData(Map<String, dynamic> data) {
    return SongExt(
      id: data['id'],
      book: data['book'],
      songNo: data['song_no'],
      objectId: data['objectid'],
      title: data['title'],
      alias: data['alias'],
      content: data['content'],
      key: data['key'],
      author: data['author'],
      views: data['views'],
      likes: data['likes'],
      created: data['created'],
      updated: data['updated'],
      liked: data['liked'] == 1 ? true : false,
      songbook: data['songbook'],
    );
  }
}
