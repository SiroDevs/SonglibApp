class HistoryExt {
  int? id;
  String? created;
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

  HistoryExt({
    this.id,
    this.created,
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

  factory HistoryExt.fromData(Map<String, dynamic> data) {
    return HistoryExt(
      created: data['created'],
      id: data['id'],
      book: data['book'],
      songNo: data['song_no'],
      title: data['title'],
      alias: data['alias'],
      content: data['content'],
      key: data['key'],
      author: data['author'],
      views: data['views'],
      likes: data['likes'],
      liked: data['liked'] == 1 ? true : false,
      songId: data['songId'],
      songbook: data['songbook'],
    );
  }
}
