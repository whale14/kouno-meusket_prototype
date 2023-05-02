import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';

part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  factory ChatRoom({
    required int idx,
    required int reqIdx,
    required String subject,
    required String time,
    required int stackedMessages,
    required int workerIdx,
    required int requesterIdx
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
}