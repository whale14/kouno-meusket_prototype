import 'dart:async';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/src/socket.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/other_user_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_project/screen/mypage/my_page_screen.dart';
import 'package:test_project/screen/errand_history/request_history.dart';
import '../../../domain/model/user/user.dart';
import '../../post_webview.dart';

class BodyReq extends StatefulWidget {
  final Socket socket;
  final String category;

  const BodyReq(this.socket, this.category, {Key? key}) : super(key: key);

  @override
  State<BodyReq> createState() => _BodyReqState();
}

class _BodyReqState extends State<BodyReq> with TickerProviderStateMixin {
  int _tabIndex = 0;

  //비동기 선언
  late Future initialize;

  //내 idx
  late String _myIdx;

  //요청서 데이터
  final TextEditingController _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _rtController = TextEditingController();
  final _rewardController = TextEditingController();
  late String dropdownValue;
  late String reqLat;
  late String reqLng;
  String address = '심부름지역';

  String _fstWpAddr = '경유지';
  String _sndWpAddr = '경유지';
  String _trdWpAddr = '경유지';

  late String _fstWpLat;
  late String _fstWpLng;
  late String _sndWpLat;
  late String _sndWpLng;
  late String _trdWpLat;
  late String _trdWpLng;

  //tabBar controller
  late TabController _tabController;

  //naverMap
  // late NaverMapController _mapController;
  late List<NMarker> markerList;
  late int tappedWorkerIdx;

  late List<User> _usersList;
  late UserViewModel _viewModel;
  late UsersState _usersState;
  late UserState _userState;
  late NLatLng _latLng;
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  final List<String> items = ["동행", "안심귀가", "교통약자", "돌봄", "우편/민원", "펫시팅", "가사", "배달/운송", "조립/설치", "시간알바", "기타/대행"];
  int _selectedCategory = 0;
  String? _categoryString;

  final List<String> _gender = ['전체', '남자', '여자'];
  String _selectedGender = '전체';

  DateTime _pickedDate = DateTime.now();

  bool _isAppBarBottomClicked = false;

  bool _showCalendar = false;

  bool _addWaypointButtonVisible = true;
  int _waypointCount = 0;

  List<Widget> waypoints = [];

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    initialize = _initialize();
  }

  Future _getHelpers() async {
    await _viewModel.onUsersEvent(UsersEvent.getAroundHelpers(_userState.user!.id));
  }

  Future<void> _initialize() async {
    // WidgetsFlutterBinding.ensureInitialized();
    await NaverMapSdk.instance.initialize(
      clientId: 'w1vo0mp1hb',
      onAuthFailed: (ex) => print("!!!!!!naver map auth error : $ex !!!!!!"),
    );
    await _getCurrentLocation();
    await _getHelpers();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<UserViewModel>();
    _usersState = _viewModel.usersState;
    _userState = _viewModel.userState;

    double height;
    if (_isAppBarBottomClicked) {
      height = 200;
    } else {
      height = 0;
    }
    return  Scaffold(
            appBar: AppBar(
              title: Text("부름이"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RequestHistory(),
                          ));
                    },
                    child: const Text(
                      '요청내역',
                    )),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageScreen()));
                  },
                  icon: const Icon(Icons.account_circle),
                ),
              ],
            ),
            body: FutureBuilder(
                future: initialize,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _usersList = _usersState.users;
                    _myIdx = _usersState.myIdx;
                    Logger().d(_myIdx);
                    return Column(
                      children: [
                        if (_isAppBarBottomClicked)
                          Container(
                            height: height,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => Container(
                                      height: 35,
                                      padding: EdgeInsets.only(left: 0, right: 8),
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.orange)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: _gender[index],
                                            groupValue: _selectedGender,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedGender = value!;
                                              });
                                            },
                                          ),
                                          Text("${_gender[index]}"),
                                          SizedBox(
                                            width: 8,
                                          )
                                        ],
                                      ),
                                    ),
                                    itemCount: _gender.length,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(),
                        Expanded(
                          child: NaverMap(
                            options: NaverMapViewOptions(
                                indoorEnable: true,
                                locationButtonEnable: true,
                                consumeSymbolTapEvents: false,
                                initialCameraPosition: NCameraPosition(target: _latLng, zoom: 15)),
                            onMapReady: (controller) async {
                              // _mapController = controller;
                              // controller.setLocationTrackingMode(NLocationTrackingMode.follow); // 내위치 줌
                              controller.latLngToScreenLocation(_latLng);
                              markerList = [];
                              Logger().d("state : ${_usersState.users}");
                              for (int i = 0; i < _usersList.length; i++) {
                                if (_usersList[i].id != _userState.user!.id) {
                                  markerList.add(NMarker(id: _usersList[i].idx.toString(), position: NLatLng(_usersList[i].latitude, _usersList[i].longitude)));
                                }
                              }
                              controller.setLocationTrackingMode(NLocationTrackingMode.follow);

                              // final markerList = latLngList
                              //     .map((point) => NMarker(id: point.toString() , position: point));
                              //네이버 맵 불러올때 실행
                              for (NMarker marker in markerList) {
                                marker.setOnTapListener(
                                    (marker) => _viewModel.onUsersEvent(UsersEvent.getOtherUser(marker.info.id)).then((value) => onMarkerTap(marker)));
                              }
                              controller.addOverlayAll(markerList.toSet());
                              // final response = await http.get(Uri.parse(API.getAroundUsers));
                              // var body = response.body;
                              // Logger().d('$body');
                              //DB에서 주변데이터 받아와서 마커 표시
                              // mapControllerCompleter.complete(controller);
                            },
                            onMapTapped: (point, latLng) async {
                              //맵 클릭시 실행
                              Logger().d("on map tapped $point, $latLng");
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            //플로팅 버튼(검색필터, 요청서작성)
            floatingActionButton: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 96 + height,
                  right: 16,
                  child: FloatingActionButton(
                    heroTag: "search filter",
                    onPressed: () {
                      /*showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (context, setState) {
                              return Dialog(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: Container(
                                  height: 400,
                                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("업무"),
                                          DropdownButton2(
                                            hint: Text(widget.category),
                                            items: items.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(value: value, child: Text(value));
                                            }).toList(),
                                            value: _categoryString,
                                            onChanged: (value) {
                                              setState(() {
                                                _categoryString = value as String;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("성별 : "),
                                          Radio(
                                            value: '무관',
                                            groupValue: _gender,
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value!;
                                              });
                                            },
                                          ),
                                          const Text("무관"),
                                          Radio(
                                            value: '남자',
                                            groupValue: _gender,
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value!;
                                              });
                                            },
                                          ),
                                          const Text("남자"),
                                          Radio(
                                            value: '여자',
                                            groupValue: _gender,
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value!;
                                              });
                                            },
                                          ),
                                          const Text("여자"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        ).then((value) => null);*/
                      setState(() {
                        _isAppBarBottomClicked = !_isAppBarBottomClicked;
                      });
                    },
                    child: const Icon(
                      Icons.manage_search,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(Alignment.bottomRight.x - 0.1, Alignment.bottomRight.y - 0.05),
                  child: FloatingActionButton.extended(
                    heroTag: "write request",
                    onPressed: () {
                      if (_userState.user!.isRequesterRegist == 0) {
                        //요청신원 등록
                        alertRequestRegist();
                      } else {
                        _showBottomModalSheet().then((value) {
                          Logger().d(value);
                          if (value == 'ok') {
                            var title = _titleController.value.text.trim();
                            var content = _contentController.value.text.trim();
                            var runningTime = _rtController.value.text.trim();
                            var reward = _rewardController.value.text.trim();
                            // var workDate = _pickedDate + _pickedTime;
                            Logger().d('category: $_selectedCategory, '
                                'title: ${_titleController.value.text}, '
                                'content: ${_contentController.value.text}, '
                                'address: $address, '
                                'latitude: $reqLat'
                                'longitude: $reqLng,'
                                'runningTime: $runningTime,'
                                'reward = $reward,');

                            _viewModel.onUsersEvent(UsersEvent.insertRequest(
                                _myIdx, _selectedCategory.toString(), title, content, address, reqLat, reqLng, DateTime.now(), runningTime, reward));
                            _titleController.clear();
                            _contentController.clear();
                            address = "";
                            reqLng = "";
                            reqLat = "";
                          }
                        });
                      }
                    },
                    label: const Text('요청서 작성', style: TextStyle(color: Colors.white, fontSize: 24)),
                    icon: const Icon(
                      Icons.request_page,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }

  void onMarkerTap(NMarker marker) {
    OtherUserState otherUserState = _viewModel.otherUserState;
    tappedWorkerIdx = int.parse(marker.info.id);
    Logger().d("tappedHelperIdx: $tappedWorkerIdx");
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  if (otherUserState.user!.profileImageUrl == null)
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.orange, width: 2.5))),
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                      ),
                    )
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
                          "http://${otherUserState.user!.profileImageUrl}",
                          cacheWidth: 1080,
                        )),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            otherUserState.user!.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (otherUserState.user!.transportation != null)
                            for (String tp in otherUserState.user!.transportation!.split(',')) ...[
                              Text(
                                tp,
                                style: const TextStyle(color: Colors.black26, fontSize: 12),
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                        ],
                      ),
                      RatingBar.builder(
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) => false,
                        initialRating: 3,
                        ignoreGestures: true,
                        itemSize: 20,
                      ),
                      Row(
                        children: [
                          if (otherUserState.user!.workCategory != null)
                            for (String wc in otherUserState.user!.workCategory!.split(",")) ...[
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                child: Text(wc),
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  if (_userState.user!.isRequesterRegist == 0) {
                    alertRequestRegist();
                  } else {
                    _showBottomModalSheet().then((value) {
                      Logger().d(value);
                      if (value == 'ok') {
                        Logger().d('category: $_selectedCategory, '
                            'title: ${_titleController.value.text}, '
                            'content: ${_contentController.value.text}, '
                            'address: $address, '
                            'latitude: $reqLat'
                            'longitude: $reqLng');
                        var title = _titleController.value.text;
                        var content = _contentController.value.text;

                        _viewModel.onUsersEvent(UsersEvent.sendRequestToWorker(_myIdx, otherUserState.user!.idx.toString(), _selectedCategory.toString(), title,
                            content, address, reqLat, reqLng, otherUserState.user!.fcmToken));
                        _titleController.clear();
                        _contentController.clear();
                        address = "";
                        reqLng = "";
                        reqLat = "";
                      }
                    });
                  }
                },
                color: Colors.orange,
                child: const Text(
                  "드림이에게 요청서 작성",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _latLng = NLatLng(position.latitude, position.longitude);
    Logger().d("set latlng : ${_latLng.toString()}");
  }

  void onTabBarTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  void alertRequestRegist() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("요청자 신원등록"),
          content: Wrap(
            children: const [
              Text("심부름 요청서를 작성하려면 요청자 신원을 등록해야합니다."),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "등록하시겠습니까?",
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _viewModel.onUsersEvent(UsersEvent.requesterRegistration(_userState.user!.idx.toString())).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("등록")),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "취소",
                  style: TextStyle(color: Colors.grey),
                )),
          ],
        );
      },
    );
  }

  Future _showBottomModalSheet() async {
    return showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("요청서"),
                  ),
                  body: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "심부름 카테고리",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 51,
                          width: double.maxFinite,
                          child: ListView.builder(
                            itemCount: items.length,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index == _selectedCategory) {
                                if (index == items.length - 1) {
                                  return Container(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50), color: Color(0xffE77924), border: Border.all(color: Color(0xffE77924))),
                                    child: Text(
                                      items[index],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                                return Container(
                                  margin: EdgeInsets.only(right: 8),
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50), color: Color(0xffE77924), border: Border.all(color: Color(0xffE77924))),
                                  child: Text(
                                    items[index],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              } else {
                                if (index == items.length - 1) {
                                  return GestureDetector(
                                    onTap: () => setState(() {
                                      _selectedCategory = index;
                                    }),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      height: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50), color: Colors.white, border: Border.all(color: Color(0xffE77924))),
                                      child: Text(items[index]),
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    _selectedCategory = index;
                                  }),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50), color: Colors.white, border: Border.all(color: Color(0xffE77924))),
                                    child: Text(items[index]),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        //title
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '제목',
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: _titleController,
                            decoration:
                                const InputDecoration(label: Text('제목을 작성해주세요.'), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '설명',
                          style: TextStyle(fontSize: 20),
                        ),
                        // content
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: _contentController,
                            minLines: 2,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                label: Text('요청하는 내용을 간단히 작성해 주세요.'), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("심부름 장소", style: TextStyle(fontSize: 20)),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey),
                                      top: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey)),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                ),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => const PostWebView(),
                                    ),
                                  )
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        String jsonValue = jsonEncode(value);
                                        Map<String, dynamic> jsonMap = jsonDecode(jsonValue);
                                        Logger().d('return post value : $jsonMap');
                                        setState(() {
                                          address = jsonMap['address'];
                                          reqLat = jsonMap['latitude'];
                                          reqLng = jsonMap['longitude'];
                                        });
                                      }
                                    },
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(address, style: TextStyle(color: Colors.black54, fontSize: 16))),
                                      Icon(Icons.search_rounded),
                                    ],
                                  ),
                                ),
                              ),
                              TextField(
                                maxLines: 2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...waypoints,
                        Visibility(
                          visible: _addWaypointButtonVisible,
                          child: GestureDetector(
                            onTap: () {
                              final key = UniqueKey();
                              if (waypoints.length < 3) {
                                setState(() {
                                  waypoints.add(
                                    Dismissible(
                                      key: key,
                                      onDismissed: (direction) {
                                        setState(() {
                                          waypoints.removeWhere((element) => element.key.toString() == key.toString());
                                          if (waypoints.length < 3) {
                                            _addWaypointButtonVisible = true;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    left: BorderSide(color: Colors.grey),
                                                    right: BorderSide(color: Colors.grey),
                                                    top: BorderSide(color: Colors.grey),
                                                    bottom: BorderSide(color: Colors.grey)),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                              ),
                                              child: GestureDetector(
                                                onTap: () => Navigator.
                                                    push(context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const PostWebView(),
                                                  ),
                                                )
                                                    .then(
                                                  (value) {
                                                    if (value != null) {
                                                      String jsonValue = jsonEncode(value);
                                                      Map<String, dynamic> jsonMap = jsonDecode(jsonValue);
                                                      Logger().d('return post value : $jsonMap');
                                                      Logger().d('indexWhere : ${waypoints.indexWhere((element) => element.key.toString() == key.toString())}');
                                                        if(waypoints.indexWhere((element) => element.key.toString() == key.toString()) == 0) {
                                                          setState(() {
                                                            _fstWpAddr = jsonMap['address'];
                                                            _fstWpLat = jsonMap['latitude'];
                                                            _fstWpLng = jsonMap['longitude'];
                                                            Logger().d("after set waypoint - $_fstWpAddr, $_fstWpLat, $_fstWpLng");
                                                          });
                                                        } else if(waypoints.indexWhere((element) => element.key.toString() == key.toString()) == 1) {
                                                          setState(() {
                                                            _sndWpAddr = jsonMap['address'];
                                                            _sndWpLat = jsonMap['latitude'];
                                                            _sndWpLng = jsonMap['longitude'];
                                                          });
                                                        } else {
                                                          setState(() {
                                                            _trdWpAddr = jsonMap['address'];
                                                            _trdWpLat = jsonMap['latitude'];
                                                            _trdWpLng = jsonMap['longitude'];
                                                          });
                                                        }
                                                    }
                                                  },
                                                ),
                                                child: Row(
                                                  children: [
                                                    if(waypoints.indexWhere((element) => element.key.toString() == key.toString()) == 0)Expanded(child: Text(_fstWpAddr, style: TextStyle(color: Colors.black54, fontSize: 16)))
                                                    else if(waypoints.indexWhere((element) => element.key.toString() == key.toString()) == 1)Expanded(child: Text(_sndWpAddr, style: TextStyle(color: Colors.black54, fontSize: 16)))
                                                    else Expanded(child: Text(_trdWpAddr, style: TextStyle(color: Colors.black54, fontSize: 16))),
                                                    Icon(Icons.search_rounded),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            TextField(
                                              maxLines: 2,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                                Logger().d("length ${waypoints.length} waypoints : ${waypoints.toString()}");
                                Logger().d('indexWhere : ${waypoints.indexWhere((element) => element.key.toString() == key.toString())}');
                              }
                              if (waypoints.length >= 3) {
                                setState(() {
                                  _addWaypointButtonVisible = false;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "경유지 추가",
                                  style: TextStyle(decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "일정예약",
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showCalendar = !_showCalendar;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(12, 17, 12, 17),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month_outlined),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          child: Text("${_pickedDate.year}-${_pickedDate.month}-${_pickedDate.day}(${"월화수목금토일"[_pickedDate.weekday - 1]})")),
                                      Icon(Icons.expand_more)
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _showCalendar,
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: TableCalendar(
                                        onDaySelected: (selectedDay, focusedDay) {
                                          Logger().d(selectedDay);
                                          setState(() {
                                            _pickedDate = selectedDay;
                                          });
                                        },
                                        selectedDayPredicate: (day) {
                                          return isSameDay(_pickedDate, day);
                                        },
                                        locale: "ko_KR",
                                        focusedDay: _pickedDate,
                                        firstDay: DateTime.now(),
                                        availableGestures: AvailableGestures.horizontalSwipe,
                                        calendarStyle: CalendarStyle(
                                            tablePadding: EdgeInsets.all(16),
                                            todayDecoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                                            todayTextStyle: TextStyle(color: Colors.black),
                                            selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
                                        lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month + 2),
                                        headerStyle: HeaderStyle(
                                          titleCentered: true,
                                          formatButtonVisible: false,
                                          headerPadding: EdgeInsets.only(top: 16, bottom: 16),
                                        ),
                                        weekNumbersVisible: false,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            items: [DropdownMenuItem(child: Text("오전"))],
                                            buttonStyleData: ButtonStyleData(
                                              padding: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            items: [DropdownMenuItem(child: Text("오전"))],
                                            buttonStyleData: ButtonStyleData(
                                              padding: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            items: [DropdownMenuItem(child: Text("오전"))],
                                            buttonStyleData: ButtonStyleData(
                                              padding: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _rtController,
                          decoration: const InputDecoration(label: Text("소요시간"), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _rewardController,
                          decoration: const InputDecoration(label: Text("심부름비"), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                        ),
                        MaterialButton(
                            color: Colors.orange,
                            child: const Text('요청하기'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text('insert Request'),
                                        content: const Text('success'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop('ok');
                                            },
                                            child: const Text('ok'),
                                          ),
                                        ],
                                      )).then((value) {
                                if (value != null) {
                                  Logger().d(value);
                                  Navigator.pop(context, value);
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
