import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/controller/fcm_controller.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/fcm_test_page.dart';
import 'package:test_project/screen/mypage/my_page_screen.dart';

import 'home_screen.dart';

class LookAround extends StatefulWidget {
  final String userId;

  const LookAround(this.userId, {Key? key}) : super(key: key);

  @override
  State<LookAround> createState() => _LookAroundState();
}

class _LookAroundState extends State<LookAround> {
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // late final FCMController _fcmController;

  Future setupInteractedMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Logger().d("handleMessage!!! >> $message");
  }

  late Future initialize;

  late UserState _userState;
  late UserViewModel _userViewModel;
  late String _userId;

  Future<void> _initialize() async {
    try {
      await _userViewModel.onUsersEvent(UsersEvent.getUser(_userId));
    } catch (e) {
      Logger().d("error!!!!!!! $e");
    }
    // Logger().d("viewmodle : ${_userViewModel.toString()}");
    Logger().d("!!!!!!!!!!!!!!!!!!!!!!");

    // _fcmController = FCMController(_fcm);
    // if(Platform.isIOS) {
    //   _fcmController.requestPermission();
    // }
    // _fcmController.getMessage();
    //
    // Logger().d(await _fcm.getToken());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupInteractedMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize = _initialize();

    });

  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = context.watch<UserViewModel>();
    _userState = _userViewModel.userState;
    _userId = widget.userId;

    return Scaffold(
      appBar: appBarLA(),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: initialize,
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                _userState = _userViewModel.userState;
                Logger().d("user: ${_userState.user}, $_userViewModel");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    walletContainer(),
                    MaterialButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FCMTestPage(),)),
                      child: Container(
                        height: 200,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(color: Colors.orange),
                        child: const Text("광고광고"),
                      ),
                    ),
                    workContainer(),
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(color: Colors.orange),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '미어켓은 안전합니다.',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('1. 부름이와 드림이들의 철저한 신원 인증'),
                          Text('2. 전문가들의 자격증 진위여부 확인'),
                          Text('3. 신뢰할만한 신원 인증 시스템'),
                        ],
                      ),
                    ),
                    footer()
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  AppBar appBarLA() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {},
      ),
      title: const Text(
        "LOGO",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyPageScreen(),
              )),
          child: const Text(
            "마이페이지",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget walletContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (_userState.user!.profileImageUrl == null)
                  const Icon(Icons.person, size: 44)
                else
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.orange),
                    ),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                          child: Image.network(
                        "http://${_userState.user!.profileImageUrl}",
                        cacheWidth: 1080,
                      )),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userState.user!.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "내지갑 >",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "10000원",
                  style: TextStyle(fontSize: 24),
                ),
                Text("100 coin"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget workContainer() {
    final categories = ["배달/구매 대행", "청소/가사 도움", "운반/수리", "동행/돌봄", "단기 알바", "기타"];
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: Text("미어켓만의 특별한 서비스")),
              TextButton(
                onPressed: () {},
                child: const Text("전체보기"),
              )
            ],
          ),
          GridView.builder(
            primary: false,
            itemCount: categories.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          child: const Text("image"),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabPage(widget.userId, categories[index], _userState.user!),
                            ))),
                    Text(categories[index])
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget footer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "고객센터",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(child: Text("카카오톡 문의 하기")),
              Expanded(child: Text("카카오톡 채널")),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("이메일 문의 하기")),
              Expanded(child: Text("help@meusket.com")),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("상담/문의 시간")),
              Expanded(child: Text("10:00 ~ 17:00")),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
