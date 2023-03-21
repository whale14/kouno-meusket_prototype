// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatRoom _$$_ChatRoomFromJson(Map<String, dynamic> json) => _$_ChatRoom(
      idx: json['idx'] as int,
      reqIdx: json['reqIdx'] as int,
      subject: json['subject'] as String,
      time: json['time'] as String,
      isRequesterRead: json['isRequesterRead'] as int,
      isWorkerRead: json['isWorkerRead'] as int,
    );

Map<String, dynamic> _$$_ChatRoomToJson(_$_ChatRoom instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'reqIdx': instance.reqIdx,
      'subject': instance.subject,
      'time': instance.time,
      'isRequesterRead': instance.isRequesterRead,
      'isWorkerRead': instance.isWorkerRead,
    };
