// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchandise _$MerchandiseFromJson(Map<String, dynamic> json) => Merchandise(
      objectId: json['objectId'] as String?,
      type: json['type'] as String?,
      size: json['size'] as String?,
      colour: json['colour'] as String?,
      quantity: json['quantity'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MerchandiseToJson(Merchandise instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('objectId', instance.objectId);
  writeNotNull('type', instance.type);
  writeNotNull('size', instance.size);
  writeNotNull('colour', instance.colour);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('location', instance.location);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('updatedAt', instance.updatedAt);
  return val;
}
