import 'package:json_annotation/json_annotation.dart';

part 'notifycation.g.dart';

@JsonSerializable(explicitToJson: true)
class Notifycation {
  @JsonKey(name: 'objectId', includeIfNull: false)
  String? objectId;
  @JsonKey(name: 'title', includeIfNull: false)
  String? title;
  @JsonKey(name: 'message', includeIfNull: false)
  String? message;
  @JsonKey(name: 'image', includeIfNull: false)
  String? image;
  @JsonKey(name: 'views', includeIfNull: false)
  int? views;
  @JsonKey(name: 'enable', includeIfNull: false)
  bool? enable;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  String? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  String? updatedAt;

  Notifycation({
    this.objectId,
    this.title,
    this.message,
    this.image,
    this.views,
    this.enable,
    this.createdAt,
    this.updatedAt,
  });

  factory Notifycation.fromJson(Map<String, dynamic> json) => _$NotifycationFromJson(json);

  Map<String, dynamic> toJson() => _$NotifycationToJson(this);
}
