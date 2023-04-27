import 'package:flutter/foundation.dart';
import 'package:test_project/presentation/event/chat/chat_event.dart';

import '../../domain/repository/chat_repository.dart';
import '../state/chat/chat_content_state.dart';
import '../state/chat/chat_room_state.dart';

class ChatViewModel with ChangeNotifier {
  final ChatRepository _chatRepository;
  var _chatRoomState = ChatRoomState();
  var _chatContentState = ChatContentState();

  ChatRoomState get chatRoomState => _chatRoomState;
  ChatContentState get chatContentState => _chatContentState;

  ChatViewModel(this._chatRepository);

  Future onChatEvent(ChatEvent event) async{
   await event.when(getChatRooms: _getChatRooms, getChatContents: _getChatContents);
  }

  Future _getChatRooms(String idx) async{
    final result = _chatRepository.getChatRooms(idx);

    _chatRoomState = chatRoomState.copyWith(
      chatRooms: await result,
    );
    notifyListeners();
  }

  Future _getChatContents(String roomIdx) async{
    final result = _chatRepository.getChatContents(roomIdx);

    _chatContentState = chatContentState.copyWith(
      chatContents: await result,
    );
    notifyListeners();
  }
}