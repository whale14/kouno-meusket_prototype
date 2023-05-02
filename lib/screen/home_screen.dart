import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:kakao_flutter_sdk_user/src/model/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/presentation/event/users/user_event.dart';

import 'package:test_project/presentation/vm/test_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../presentation/state/users/user_state.dart';
import 'bottom_nav_screens/chat/chat_main.dart';
import 'bottom_nav_screens/work/work_main.dart';
import 'bottom_nav_screens/request/req_main.dart';
import 'bottom_nav_screens//body_shopping.dart';
import 'mypage/my_page_screen.dart';
import 'mypage/request_history.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TabPage extends StatefulWidget {
  final String userId;
  final String category;

  const TabPage(this.userId, this.category, {Key? key}) : super(key: key);
  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late String? idx;
  int _bottomNavIndex = 0;
  late String _userId;

  late TestViewModel _viewModel;
  late UserState _state;

  bool workState = false;

  late double latitude, longitude;

  IO.Socket socket = IO.io(
    'http://192.168.100.42:3000', //5층 ip
    // 'http://192.168.101.2:3000', // 3층 ip
    <String, dynamic>{
      'transports': ['websocket']
    },
  );

  void _disConnect() {
    Logger().d("socket disConnect");
    socket.clearListeners();
    socket.close();
  }
  void _connect() {
    socket.connect();
    socket.on('workerLocation', (data) {
      String jsonLocation = jsonEncode(data[0]);
      Map<String, dynamic> jsonMap = jsonDecode(jsonLocation);
      double? latitude = jsonMap['latitude'];
      double? longitude = jsonMap['longitude'];
      Logger().d('workerLocation : ($latitude, $longitude)}');
    });

    //헬퍼 idx 보내기
    socket.on('event', (data) async{
      if(workState) {
        Logger().d('$data');
        await _getCurrentLocation();
        _viewModel.onUserEvent(UserEvent.updateLocation(idx!, latitude, longitude));
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    WidgetsFlutterBinding.ensureInitialized();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  late Future initialize;
  // final List _pages = [
  //   const BodyReq(),
  //   const BodyHelper(),
  //   const BodyShopping(),
  //   const BodyChat(),
  // ];
  final List _barTitles = [
    '부름이',
    '드림이',
    '쇼핑',
    '채팅',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize = _initialize();
    _connect();

  }

  Future _initialize() async{
    await _getCurrentLocation();
    await _getSharedPreferences();
    await _getUser();
    socket.emit('joinUser', ('user${idx!}'));
  }

  Future _getSharedPreferences() async{
    final SharedPreferences prefs = await _prefs;
    idx = prefs.getString('idx');
    Logger().d("!!!!!!!!!!!!!!!myIdx: $idx}");
  }

  Future _getUser() async{
    await _viewModel.onUserEvent(UserEvent.getUser(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    String title = '제목';
    _userId = widget.userId;
    Logger().d("user : $_userId");
    _viewModel = context.watch<TestViewModel>();
    // _getSharedPreferences();
    // _viewModel.onUserEvent(UserEvent.getUser(widget.userId));
    // _getUser;
    _state = _viewModel.userState;
    Logger().d('!!!!!!!!HomeSreen - userState : $_state');

    return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.home, color: Colors.white,),),
            title: Text(_barTitles[_bottomNavIndex]),
            actions: <Widget>[
              Switch(
                value: workState,
                onChanged: (value) {
                  setState(() {
                    workState = value;
                  });
                  Logger().d(workState);
              },
              ),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RequestHistory(),));
              }, child: const Text('요청내역', style: TextStyle(color: Colors.white),)),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const MyPageScreen()));
                },
                icon: Icon(Icons.account_circle),
                color: Colors.white,
              ),
            ],
          ),
          body: [
            BodyReq(_userId, socket, widget.category),
            const BodyHelper(),
            const BodyShopping(),
            BodyChat(socket)
          ][_bottomNavIndex],//_pages[_bottomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            currentIndex: _bottomNavIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.live_help), label: '부름이'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_box_rounded), label: '드림이'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_rounded), label: '쇼핑'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble), label: '채팅'),
            ],
          ),
        );
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _disConnect();
    super.dispose();
  }
}
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<TestViewModel>();
//     final state = viewModel.testState;
//     return Scaffold(
//       body: ListView.builder(itemBuilder: (context, index) {
//         final test = state.tests[index];
//         return ListTile(
//           title: Text(
//               'id:${test.idx}, createAt:${test.createAt}, name:${test.name}'),
//         );
//       }),
//     );
//   }
// }
