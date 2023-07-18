import 'package:json_annotation/json_annotation.dart';

part 'merchandise.g.dart';

@JsonSerializable(explicitToJson: true)
class Merchandise {
  @JsonKey(name: 'objectId', includeIfNull: false)
  String? objectId;
  @JsonKey(name: 'type', includeIfNull: false)
  String? type;
  @JsonKey(name: 'size', includeIfNull: false)
  String? size;
  @JsonKey(name: 'colour', includeIfNull: false)
  String? colour;
  @JsonKey(name: 'quantity', includeIfNull: false)
  int? quantity;
  @JsonKey(name: 'name', includeIfNull: false)
  String? name;
  @JsonKey(name: 'phone', includeIfNull: false)
  String? phone;
  @JsonKey(name: 'location', includeIfNull: false)
  String? location;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  String? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  String? updatedAt;

  Merchandise({
    this.objectId,
    this.type,
    this.size,
    this.colour,
    this.quantity,
    this.name,
    this.phone,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory Merchandise.fromJson(Map<String, dynamic> json) => _$MerchandiseFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseToJson(this);
}
