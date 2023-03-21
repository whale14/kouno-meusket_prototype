import 'package:flutter/material.dart';

class BodyChat extends StatefulWidget {
  const BodyChat({Key? key}) : super(key: key);

  @override
  State<BodyChat> createState() => _BodyChatState();
}

class _BodyChatState extends State<BodyChat> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // chat room list view
    return ListView.builder(itemBuilder: (context, index) {
      return ListTile(); // 스윗 깃 공유 테스트
    },);
  }
}
