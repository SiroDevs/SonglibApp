class Song {
  int? id;
  int? songId;
  int? user;
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
  String? created;
  String? updated;

  Song({
    this.id,
    this.songId,
    this.user,
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
    this.created,
    this.updated,
  });

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    songId = json['songId'];
    user = json['user'];
    book = json['book'];
    songNo = json['songNo'];
    title = json['title'];
    alias = json['alias'];
    content = json['content'];
    key = json['key'];
    author = json['author'];
    views = json['views'];
    likes = json['likes'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['songId'] = songId;
    data['user'] = user;
    data['book'] = book;
    data['songNo'] = songNo;
    data['title'] = title;
    data['alias'] = alias;
    data['content'] = content;
    data['key'] = key;
    data['author'] = author;
    data['views'] = views;
    data['likes'] = likes;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }

  /*List<Song> fromData(List<ParseObject?> data) {
    return data
        .map(
          (song) => Song(
            songId: song!.get<String>('songId'),
            id: song.get<int>('id'),
            book: song.get<int>('book'),
            songNo: song.get<int>('songNo'),
            title: song.get<String>('title'),
            alias: song.get<String>('alias'),
            content: song.get<String>('content'),
            author: song.get<String>('author'),
            key: song.get<String>('key'),
            views: song.get<int>('views'),
            likes: song.get<int>('likes'),
            liked: song.get<bool>('liked'),
            created: dateToString(song.get<DateTime>('created')!),
            updated: dateToString(song.get<DateTime>('updated')!),
          ),
        )
        .toList();
  }*/
}
