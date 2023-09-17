class Book {
  int? id;
  int? bookId;
  int? user;
  String? title;
  String? subTitle;
  int? songs;
  int? position;
  int? bookNo;
  bool? enabled;
  String? created;
  String? updated;

  Book({
    this.id,
    this.bookId,
    this.user,
    this.title,
    this.subTitle,
    this.songs,
    this.position,
    this.bookNo,
    this.enabled,
    this.created,
    this.updated,
  });

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    user = json['user'];
    title = json['title'];
    subTitle = json['subTitle'];
    songs = json['songs'];
    position = json['position'];
    bookNo = json['bookNo'];
    enabled = json['enabled'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookId'] = bookId;
    data['user'] = user;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['songs'] = songs;
    data['position'] = position;
    data['bookNo'] = bookNo;
    data['enabled'] = enabled;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }

  factory Book.fromData(Map<String, dynamic> data) {
    return Book(
      id: data['id'],
      bookId: data['object_id'],
      title: data['title'],
      subTitle: data['sub_title'],
      songs: data['songs'],
      position: data['position'],
      bookNo: data['book_no'],
      enabled: data['enabled'] == 1 ? true : false,
      created: data['created'],
      updated: data['updated'],
    );
  }
}
