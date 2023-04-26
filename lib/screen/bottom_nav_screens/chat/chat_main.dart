import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/presentation/event/chat/chat_event.dart';
import 'package:test_project/presentation/state/chat/chat_room_state.dart';
import 'package:test_project/presentation/vm/chat_view_model.dart';

import '../../../domain/model/chat/chat_room.dart';
import 'chatting_screen.dart';

class BodyChat extends StatefulWidget {
  const BodyChat({Key? key}) : super(key: key);

  @override
  State<BodyChat> createState() => _BodyChatState();
}

class _BodyChatState extends State<BodyChat> {
  late String? idx;
  late Future initialize;

  late ChatViewModel _viewModel;
  late ChatRoomState _chatRoomState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize = _initialize();
  }

  Future _initialize() async {
    await _getSharedIdx();
    await _getMyChatRooms();
  }

  Future _getSharedIdx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idx = prefs.getString('idx');
    Logger().d('>>>idx: $idx');
  }

  Future _getMyChatRooms() async {
    await _viewModel.onChatEvent(ChatEvent.getChatRooms(idx!));
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<ChatViewModel>();
    _chatRoomState = _viewModel.chatRoomState;
    // chat room list view
    return ListView.builder(
      itemCount: _chatRoomState.chatRooms.length,
      itemBuilder: (context, index) {
        final chatRoom = _chatRoomState.chatRooms[index];
        return ListTile(
          title: Text(chatRoom.subject),
          subtitle: Text('last time: ${chatRoom.time}'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingScreen(chatRoom),)).then((value) {
            setState(() {
              initialize = _initialize();
            });
          }),
        ); // 스윗 깃 공유 테스트
      },
    );
  }

}
