import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:test_project/domain/model/chat/chat_content.dart';
import 'package:test_project/domain/model/chat/chat_room.dart';
import 'package:test_project/presentation/event/chat/chat_event.dart';
import 'package:test_project/presentation/state/chat/chat_content_state.dart';
import 'package:test_project/presentation/vm/chat_view_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChattingScreen extends StatefulWidget {
  final ChatRoom chatRoom;
  final Socket socket;
  const ChattingScreen(this.chatRoom, this.socket, {Key? key}) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late ChatViewModel _chatViewModel;
  late ChatContentState _state;

  late Future initialize;

  late String? idx;

  String _userTypeMessage = '';

  final sendTextController = TextEditingController();
  final scrollController = ScrollController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize = _initialize();
    widget.socket.emit("joinChatRoom", widget.chatRoom.idx.toString());
  }

  Future _initialize() async {
    await _getSharedIdx();
    await _getChatContents(widget.chatRoom.idx.toString());
  }

  Stream<List<ChatContent>> _stream() {
    return Stream<List<ChatContent>>.value(_state.chatContents);
  }

  Future _getSharedIdx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idx = prefs.getString('idx');
    Logger().d('>>>idx: $idx');
  }

  Future _getChatContents(String roomIdx) async {
    await _chatViewModel.onChatEvent(ChatEvent.getChatContents(roomIdx));
  }

  @override
  Widget build(BuildContext context) {
    _chatViewModel = context.watch<ChatViewModel>();
    _state = _chatViewModel.chatContentState;
    loadChatMessage();
    readChatMessage();
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, widget.socket);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CHATTING',
            style: TextStyle(color: Colors.white),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            StreamBuilder(
              stream: _stream(),
              builder: (BuildContext context, AsyncSnapshot<List<ChatContent>> sbSnapshot) {
                if (sbSnapshot.hasData) {
                  final docs = sbSnapshot.data!;
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    if (scrollController.hasClients) {
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    }
                  });
                  return Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final chatContent = docs[index];
                        if (chatContent.isRead == 0 && chatContent.userIdx.toString() != idx) {
                          _chatViewModel.onChatEvent(ChatEvent.updateChatRead(chatContent));
                          Map<String, Object> mapData = {"userIdx": idx!, "roomIdx":widget.chatRoom.idx.toString()};
                          widget.socket.emit("readChat", mapData);
                        }
                        return chatBubble(chatContent);
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),

            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: sendTextController,
                    decoration: InputDecoration(labelText: 'Send a message..'),
                    onChanged: (value) {
                      setState(() {
                        _userTypeMessage = value;
                      });
                    },
                  )),
                  IconButton(
                      onPressed: _userTypeMessage.trim().isEmpty ? null : () => sendMessage(widget.chatRoom.idx.toString(), idx!, _userTypeMessage),
                      icon: const Icon(
                        Icons.send,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String roomIdx, String myIdx, String message) {
    sendTextController.clear();
    //채팅 소켓연결
    widget.socket.emit('sendMessage', {'roomIdx': roomIdx, 'message': message, 'userIdx': myIdx});
    if(idx == widget.chatRoom.workerIdx.toString()) {
      widget.socket.emit('notificationChatRoom', widget.chatRoom.requesterIdx.toString());
    } else {
      widget.socket.emit('notificationChatRoom', widget.chatRoom.workerIdx.toString());
    }
  }

  Widget chatBubble(ChatContent chatContent) {
    Color color = Colors.grey;
    Alignment alignment = Alignment.center;
    MainAxisAlignment rowAlign = MainAxisAlignment.center;
    Widget bubble;

    if (chatContent.userIdx != 0) {
      if (chatContent.userIdx.toString() == idx) {
        color = Colors.orange;
        alignment = Alignment.centerRight;
        rowAlign = MainAxisAlignment.end;
      } else {
        color = Colors.grey;
        alignment = Alignment.centerLeft;
        rowAlign = MainAxisAlignment.start;
      }

      return Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: bubbleReadCheck(chatContent, color, rowAlign),
        ),
      );
    } else {
      return Align(
        alignment: alignment,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              chatContent.content,
            ),
          ),
        ),
      );
    }
  }

  Widget bubbleReadCheck(ChatContent chatContent, Color color, MainAxisAlignment rowAlign) {
    if (chatContent.isRead == 0) {
      if (chatContent.userIdx.toString() == idx) {
        return Row(
          mainAxisAlignment: rowAlign,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("1", style: TextStyle(color: Colors.orange),),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                chatContent.content,
              ),
            ),
          ],
        );
      } else { return Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            chatContent.content,
          ),
        );
      }
    } else {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          chatContent.content,
        ),
      );
    }
  }

  void loadChatMessage() {
    widget.socket.on("loadChatMessage", (data) {
      setState(() {
        initialize = _initialize();
      });
      var jsonData = jsonEncode(data);
      Map<String, dynamic> jsonMap = jsonDecode(jsonData);
      Logger().d("result: ${jsonMap['result']}, userIdx: ${jsonMap['userIdx']}");
      if (idx != jsonMap['userId']) {
      } else {
        Logger().d("같아 아무것도 안할거야");
      }
    });
  }

  void readChatMessage() {
    widget.socket.on("readChat", (userIdx) {
      if(userIdx != idx) {
        setState(() {
          initialize = _initialize();
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement disposere

    //방 나가기
    widget.socket.emit("leaveChatRoom", widget.chatRoom.idx.toString());
    widget.socket.clearListeners();
    sendTextController.dispose();
    scrollController.dispose();
    Navigator.pop(context);
    super.dispose();
  }
}
