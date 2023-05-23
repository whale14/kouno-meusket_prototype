import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/src/socket.dart';
import 'package:test_project/presentation/event/chat/chat_event.dart';
import 'package:test_project/presentation/state/chat/chat_room_state.dart';
import 'package:test_project/presentation/vm/chat_view_model.dart';

import 'chatting_screen.dart';

class BodyChat extends StatefulWidget {
  final Socket socket;

  const BodyChat(this.socket, {Key? key}) : super(key: key);

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
    roomNotification();
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

  void roomNotification() {
    widget.socket.on('notificationChatRoom', (data) {
      _getMyChatRooms();
      Logger().d(data);
    });
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
        if (chatRoom.stackedMessages != 0) {
          return Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
            child: ListTile(
              title: Text(chatRoom.subject),
              subtitle: Text('last time: ${chatRoom.time}'),
              trailing: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    chatRoom.stackedMessages.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChattingScreen(chatRoom, widget.socket),
                  )).then((value) => _viewModel.onChatEvent(ChatEvent.getChatRooms(idx!)))
            ),
          );
        } else {
          return Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
            child: ListTile(
                title: Text(chatRoom.subject),
                subtitle: Text('last time: ${chatRoom.time}'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChattingScreen(chatRoom, widget.socket),
                    )).then((value) => _viewModel.onChatEvent(ChatEvent.getChatRooms(idx!)))
                //     .then((value) {
                //   setState(() {
                //     initialize = _initialize();
                //   });
                // }),
                ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Logger().d('chatMain dispose');
    widget.socket.clearListeners();
    super.dispose();
  }
}
