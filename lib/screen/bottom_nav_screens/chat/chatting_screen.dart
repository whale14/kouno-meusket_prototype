import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/domain/model/chat/chat_room.dart';
import 'package:test_project/presentation/event/chat/chat_event.dart';
import 'package:test_project/presentation/state/chat/chat_content_state.dart';
import 'package:test_project/presentation/vm/chat_view_model.dart';

class ChattingScreen extends StatefulWidget {
  final ChatRoom chatRoom;

  const ChattingScreen(this.chatRoom, {Key? key}) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late ChatViewModel _viewModel;
  late ChatContentState _state;

  late Future initialize;

  late String? idx;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize = _initialize();
  }

  Future _initialize() async {
    await _getSharedIdx();
    await _getChatContents(widget.chatRoom.idx.toString());
  }

  Future _getSharedIdx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idx = prefs.getString('idx');
    Logger().d('>>>idx: $idx');
  }

  Future _getChatContents(String roomIdx) async {
    await _viewModel.onChatEvent(ChatEvent.getChatContents(roomIdx));
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<ChatViewModel>();
    _state = _viewModel.chatContentState;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CHATTING',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: _state.chatContents.length,
        itemBuilder: (context, index) {
          final chatContent = _state.chatContents[index];
          if (chatContent.userIdx == 0) {
            //가운데 정렬
            return Center(
              child: ListTile(
                title: Text(chatContent.content),
              ),
            );
          } else {
            if (chatContent.userIdx == idx) {
              //오른쪽 정렬
              return ListTile(
                title: Text(chatContent.content),
              );
            } else {
              //왼쪽 정렬
              return ListTile(
                title: Text(chatContent.content),
              );
            }
          }
        },
      ),
    );
  }
}
