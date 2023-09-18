// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/chat/chat_content.dart';
//
// part 'chat_event.freezed.dart';
//
// @freezed
// abstract class ChatEvent<T> with _$ChatEvent<T> {
//   const factory ChatEvent.getChatRooms(String idx) = GetChatRooms;
//   const factory ChatEvent.getChatContents(String roomIdx) = GetChatContents;
//   const factory ChatEvent.updateChatRead(ChatContent chatContent) = UpdateChatRead;
// }

sealed class ChatEvent<T> {
  factory ChatEvent.getChatRooms(String idx) = GetChatRooms;  // Option
  factory ChatEvent.getChatContents(String roomIdx) = GetChatContents;
  factory ChatEvent.updateChatRead(ChatContent chatContent) = UpdateChatRead;
}

class GetChatRooms<T> implements ChatEvent<T> {
  final String idx;

  GetChatRooms(this.idx);
}

class GetChatContents<T> implements ChatEvent<T> {
  final String roomidx;

  GetChatContents(this.roomidx);
}

class UpdateChatRead<T> implements ChatEvent<T> {
  final ChatContent chatContent;
  UpdateChatRead(this.chatContent);
}
