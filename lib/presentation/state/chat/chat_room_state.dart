import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/chat/chat_room.dart';

part 'chat_room_state.freezed.dart';

part 'chat_room_state.g.dart';

@freezed
class ChatRoomState with _$ChatRoomState {
  factory ChatRoomState({
    @Default([]) List<ChatRoom> chatRooms,
  }) = _ChatRoomState;

  factory ChatRoomState.fromJson(Map<String, dynamic> json) => _$ChatRoomStateFromJson(json);
}