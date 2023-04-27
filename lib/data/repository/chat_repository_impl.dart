import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:test_project/data/source/remote/chat_api.dart';
import 'package:test_project/domain/model/chat/chat_content.dart';
import 'package:test_project/domain/model/chat/chat_room.dart';
import 'package:test_project/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatApi api;

  ChatRepositoryImpl(this.api);
  @override
  Future<List<ChatContent>> getChatContents(String roomIdx) async{
    // TODO: implement getChatContents
    final response = await api.getChatContents(roomIdx);

    Logger().d("getUser_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => ChatContent.fromJson(e)).toList();
  }

  @override
  Future<List<ChatRoom>> getChatRooms(String idx) async{
    // TODO: implement getChatRooms
    final response = await api.getChatRooms(idx);

    final Iterable json = jsonDecode(response.body);
    return json.map((e) => ChatRoom.fromJson(e)).toList();
  }

  @override
  Future updateChatRead(String chatIdx) async{
    // TODO: implement updateChatRead
    await api.updateChatRead(chatIdx);
  }

}