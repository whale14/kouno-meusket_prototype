import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.freezed.dart';

@freezed
abstract class ChatEvent<T> with _$ChatEvent<T> {
  const factory ChatEvent.getChatRooms(String idx) = GetChatRooms;
  const factory ChatEvent.getChatContents(String roomIdx) = GetChatContents;
}