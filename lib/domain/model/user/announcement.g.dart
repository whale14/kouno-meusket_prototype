// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Announcement _$$_AnnouncementFromJson(Map<String, dynamic> json) =>
    _$_Announcement(
      idx: json['idx'] as int,
      type: json['type'] as String,
      author: json['author'] as String,
      announceAt: json['announceAt'] as String,
      content: json['content'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$_AnnouncementToJson(_$_Announcement instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'type': instance.type,
      'author': instance.author,
      'announceAt': instance.announceAt,
      'content': instance.content,
      'title': instance.title,
    };
