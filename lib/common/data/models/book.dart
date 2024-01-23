import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
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

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
