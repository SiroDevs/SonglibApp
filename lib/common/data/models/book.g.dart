// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as int?,
      bookId: json['bookId'] as int?,
      user: json['user'] as int?,
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      songs: json['songs'] as int?,
      position: json['position'] as int?,
      bookNo: json['bookNo'] as int?,
      enabled: json['enabled'] as bool?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'user': instance.user,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'songs': instance.songs,
      'position': instance.position,
      'bookNo': instance.bookNo,
      'enabled': instance.enabled,
      'created': instance.created,
      'updated': instance.updated,
    };
