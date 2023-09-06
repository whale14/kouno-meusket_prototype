import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MatchPage extends StatefulWidget {
  final String userId;
  final int helperId;

  const MatchPage({Key? key, required this.userId, required this.helperId})
      : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late String _userId;
  late String _helperIdx;
  final TextEditingController _controller = TextEditingController();
  late IO.Socket socket;

  String socketTest = '';

  //socket Test sever(echo Text)
  @override
  Widget build(BuildContext context) {
    _userId = widget.userId;
    _helperIdx = widget.helperId.toString();
    Logger().d("log : MatchPage()- me=$_userId, helper=$_helperIdx");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(socketTest),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                color: Colors.orange,
                onPressed: _connect,
                child: const Text("connect")),
                const SizedBox(width: 10,),
                MaterialButton(
                    color: Colors.orange,
                    onPressed: _disConnect,
                    child: const Text("disConnect")),
              ],
            ),

            Text('myId:$_userId, workerIdx:$_helperIdx'),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _sendMessage,
      //   tooltip: 'send message',
      //   child: const Icon(Icons.send),
      // ),
    );
  }

  //
  // void _sendMessage() {
  //   if (_controller.text.isNotEmpty) {
  //     Logger().d("message: ${_controller.text}");
  //     _channel.sink.add(_controller.text);
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _channel.sink.close();
  //   super.dispose();
  // }

  void _disConnect() {
    Logger().d("socket disConnect");
    socket.clearListeners();
    socket.close();
  }
  void _connect() {
    socket = IO.io(
      // 'http://192.168.100.42:3000', //5층 ip
      'http://192.168.101.2:3000', // 3층 ip
      <String, dynamic>{
        'transports': ['websocket']
      },
    );

    socket.connect();
    socket.on('workerLocation', (data) {
        String jsonLocation = jsonEncode(data[0]);
        Map<String, dynamic> jsonMap = jsonDecode(jsonLocation);
        double? latitude = jsonMap['latitude'];
        double? longitude = jsonMap['longitude'];
        Logger().d('workerLocation : ($latitude, $longitude)}');
    });

    //헬퍼 idx 보내기
    socket.on('event', (data) {
      Logger().d('$data');
      socketTest = data.toString();
      socket.emit('getWorkerLocation', _helperIdx);
    });
  }


}
