import 'package:test_project/domain/model/chat/chat_content.dart';

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
