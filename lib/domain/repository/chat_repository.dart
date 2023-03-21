import 'package:test_project/domain/model/chat/chat_content.dart';
import 'package:test_project/domain/model/chat/chat_room.dart';

abstract class ChatRepository {
  Future<List<ChatRoom>> getChatRooms(String idx);

  Future<List<ChatContent>> getChatContents(String roomIdx);
}