import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
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
  final User user;
  const TabPage(this.userId, this.category, this.user, {Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int _bottomNavIndex = 0;
  int _preIndex = 0;

  late UserViewModel _viewModel;
  late UserState _state;

  late User _user;

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
    socket.on('event', (data) async {
      if (workState) {
        Logger().d('$data');
        await _getCurrentLocation();
        _viewModel.onUsersEvent(UsersEvent.updateLocation(_user.idx.toString(), latitude, longitude));
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
    _user = widget.user;
    initialize = _initialize();
    _connect();
  }

  Future _initialize() async {
    await _getCurrentLocation();
    await _viewModel.onUsersEvent(UsersEvent.getUser(_user.id));
    socket.emit('joinUser', ('user${_user.idx}'));
  }

  @override
  Widget build(BuildContext context) {
    String title = '제목';
    _viewModel = context.watch<UserViewModel>();
    _state = _viewModel.userState;
    // _getSharedPreferences();
    // _viewModel.onUserEvent(UserEvent.getUser(widget.userId));
    // _getUser;

    return FutureBuilder(
        future: initialize,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestHistory(),
                            ));
                      },
                      child: const Text(
                        '요청내역',
                        style: TextStyle(color: Colors.white),
                      )),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageScreen(_user)));
                    },
                    icon: Icon(Icons.account_circle),
                    color: Colors.white,
                  ),
                ],
              ),
              body: [
                BodyReq(_user.id, socket, widget.category, _state.user!),
                workerTab(_state.user!),
                const BodyShopping(),
                BodyChat(socket)
              ][_bottomNavIndex], //_pages[_bottomNavIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: _onItemTapped,
                currentIndex: _bottomNavIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.live_help), label: '부름이'),
                  BottomNavigationBarItem(icon: Icon(Icons.check_box_rounded), label: '드림이'),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded), label: '쇼핑'),
                  BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: '채팅'),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _preIndex = _bottomNavIndex;
      _bottomNavIndex = index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _disConnect();
    super.dispose();
  }

  Widget workerTab(User user) {
    if (user.isWorkerRegist == 0) {
      return AlertDialog(
        title: Text("부름이 등록"),
        content: Wrap(
          children: [
            Text("심부름을 수행하기 위해선 계정을 부름이로 등록해야합니다."),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("등록하시겠습니까?"),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () {
            _viewModel.onUsersEvent(UsersEvent.workerRegistration(user.idx.toString())).then((value) {
              _onItemTapped(_preIndex);
            });
          }, child: Text("등록")),
          TextButton(
              onPressed: () {
                _onItemTapped(_preIndex);
              },
              child: Text("취소", style: TextStyle(color: Colors.grey))),
        ],
      );
    } else {
      return BodyHelper(user);
    }
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
