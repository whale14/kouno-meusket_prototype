// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatContent _$$_ChatContentFromJson(Map<String, dynamic> json) =>
    _$_ChatContent(
      idx: json['idx'] as int,
      roomIdx: json['roomIdx'] as int,
      userIdx: json['userIdx'] as int,
      content: json['content'] as String,
      time: json['time'] as String,
      isRead: json['isRead'] as int,
    );

Map<String, dynamic> _$$_ChatContentToJson(_$_ChatContent instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'roomIdx': instance.roomIdx,
      'userIdx': instance.userIdx,
      'content': instance.content,
      'time': instance.time,
      'isRead': instance.isRead,
    };
