import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/screen/bottom_nav_screens/work/worker_registration_page.dart';
import 'bottom_nav_screens/chat/chat_main.dart';
import 'bottom_nav_screens/work/work_main.dart';
import 'bottom_nav_screens/request/req_main.dart';
import 'bottom_nav_screens//body_shopping.dart';
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

  late UserViewModel _userViewModel;
  late UserState _userState;

  late RequestViewModel _requestViewModel;

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
        _userViewModel.onUsersEvent(UsersEvent.updateLocation(_user.idx.toString(), latitude, longitude));
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
    await _userViewModel.onUsersEvent(UsersEvent.getUser(_user.id));
    socket.emit('joinUser', ('user${_user.idx}'));
  }

  @override
  Widget build(BuildContext context) {
    String title = '제목';
    _userViewModel = context.watch<UserViewModel>();
    _userState = _userViewModel.userState;
    // _getSharedPreferences();
    // _viewModel.onUserEvent(UserEvent.getUser(widget.userId));
    // _getUser;

    return FutureBuilder(
        future: initialize,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: [ //탭바 뷰 구현을 위한 페이지 리스트
                BodyReq(socket, widget.category), //bottom_nav_screens/request/request_main.dart
                workerTab(_userState.user!), //L.175
                const BodyShopping(), //bottom_nav_screens/body_shopping.dart
                BodyChat(socket) //bottom_nav_screens/chat/chat_main.dart
              ][_bottomNavIndex], //_pages[_bottomNavIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: _onItemTapped,
                currentIndex: _bottomNavIndex,
                items: const <BottomNavigationBarItem>[ //바텀 내비게이션 탭 아이콘 리스트
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

  void _onItemTapped(int index) async{
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
    if (user.isWorkerRegist == 0) { // 최초 클릭시 드림이 등록 유도
      return AlertDialog(
        title: const Text("드림이 등록"),
        content:  Wrap(
          children: const [
            Text("심부름을 수행하기 위해선 계정을 드림이로 등록해야합니다."),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("등록하시겠습니까?"),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerRegistrationPage(),));
            /*** 심부름 드림이(헬퍼) 등록 _viewModel.onUsersEvent(UsersEvent.workerRegistration(user.idx.toString())).then((value) {
              _onItemTapped(_preIndex);
            }); ***/
          }, child: const Text("등록")),
          TextButton(
              onPressed: () {
                _onItemTapped(_preIndex);
              },
              child: const Text("취소", style: TextStyle(color: Colors.grey))),
        ],
      );
    } else {
      return BodyHelper(user); //bottom_nam_screens/work/work_main.dart
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
