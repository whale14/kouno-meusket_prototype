// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatRoomState _$$_ChatRoomStateFromJson(Map<String, dynamic> json) =>
    _$_ChatRoomState(
      chatRooms: (json['chatRooms'] as List<dynamic>?)
              ?.map((e) => ChatRoom.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ChatRoomStateToJson(_$_ChatRoomState instance) =>
    <String, dynamic>{
      'chatRooms': instance.chatRooms,
    };
