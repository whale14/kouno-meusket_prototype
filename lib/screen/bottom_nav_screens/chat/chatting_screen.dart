import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/domain/model/chat/chat_content.dart';
import 'package:test_project/domain/model/chat/chat_room.dart';
import 'package:test_project/presentation/event/chat/chat_event.dart';
import 'package:test_project/presentation/state/chat/chat_content_state.dart';
import 'package:test_project/presentation/vm/chat_view_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  String _userTypeMessage = '';

  final sendTextController = TextEditingController();
  final scrollController = ScrollController();

  IO.Socket socket = IO.io(
    'http://192.168.100.42:3000', //5층 ip
    // 'http://192.168.101.2:3000', // 3층 ip
    <String, dynamic>{
      'transports': ['websocket']
    },
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize = _initialize();
    socket.connect();
    socket.emit("joinChatRoom", widget.chatRoom.idx);
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
                      if (chatContent.userIdx == 0) {
                        //가운데 정렬
                        return Align(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Container(
                              width: 200,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                chatContent.content,
                              ),
                            ),
                          ),
                        );
                      } else {
                        if (chatContent.userIdx.toString() == idx) {
                          //오른쪽 정렬
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  chatContent.content,
                                ),
                              ),
                            ),
                          );
                        } else {
                          //왼쪽 정렬
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
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
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),

          // FutureBuilder(
          //     future: initialize,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return Expanded(
          //           child: ListView.builder(
          //             itemCount: _state.chatContents.length,
          //             itemBuilder: (context, index) {
          //               final chatContent = _state.chatContents[index];
          //               if (chatContent.userIdx == 0) {
          //                 //가운데 정렬
          //                 return Align(
          //                   child: Padding(
          //                     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          //                     child: Container(
          //                       width: 200,
          //                       alignment: Alignment.center,
          //                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          //                       decoration: BoxDecoration(
          //                         color: Colors.grey,
          //                         borderRadius: BorderRadius.circular(20),
          //                       ),
          //                       child: Text(
          //                         chatContent.content,
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               } else {
          //                 if (chatContent.userIdx.toString() == idx) {
          //                   //오른쪽 정렬
          //                   return Align(
          //                     alignment: Alignment.centerRight,
          //                     child: Padding(
          //                       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          //                       child: Container(
          //                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          //                         decoration: BoxDecoration(
          //                           color: Colors.orange,
          //                           borderRadius: BorderRadius.circular(20),
          //                         ),
          //                         child: Text(
          //                           chatContent.content,
          //                         ),
          //                       ),
          //                     ),
          //                   );
          //                 } else {
          //                   //왼쪽 정렬
          //                   return Align(
          //                     alignment: Alignment.centerLeft,
          //                     child: Padding(
          //                       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          //                       child: Container(
          //                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          //                         decoration: BoxDecoration(
          //                           color: Colors.grey,
          //                           borderRadius: BorderRadius.circular(20),
          //                         ),
          //                         child: Text(
          //                           chatContent.content,
          //                         ),
          //                       ),
          //                     ),
          //                   );
          //                 }
          //               }
          //             },
          //           ),
          //         );
          //       } else {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     }),
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
                    icon: Icon(
                      Icons.send,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  sendMessage(String roomIdx, String myIdx, String message) {
    sendTextController.clear();

    //채팅 소켓연결
    socket.emit('sendMessage', {'roomIdx': roomIdx, 'message': message, 'userIdx': myIdx});
    socket.on("loadChatMessage", (data) {
      setState(() {
        initialize = _initialize();
      });
      Logger().d(data);
    });
  }

  @override
  void dispose() {
    // TODO: implement disposere

    socket.close();
    socket.clearListeners();
    sendTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
