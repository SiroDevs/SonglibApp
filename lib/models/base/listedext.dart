class ListedExt {
  int? parentid;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? id;
  int? song;
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
  int? songId;
  String? songbook;

  ListedExt({
    this.parentid,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.song,
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
    this.songId,
    this.songbook,
  });

  factory ListedExt.fromData(Map<String, dynamic> data) {
    return ListedExt(
      parentid: data['parentid'],
      position: data['position'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      id: data['id'],
      book: data['book'],
      song: data['song'],
      songNo: data['song_no'],
      title: data['title'],
      alias: data['alias'],
      content: data['content'],
      key: data['key'],
      author: data['author'],
      views: data['views'],
      likes: data['likes'],
      liked: data['liked'],
      songId: data['songId'],
      songbook: data['songbook'],
    );
  }
}
