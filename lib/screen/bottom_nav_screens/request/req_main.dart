import 'dart:async';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/src/socket.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/vm/test_view_model.dart';

import '../../../domain/model/users/users.dart';
import '../../match_page.dart';
import '../../post_webview.dart';

class BodyReq extends StatefulWidget {
  final String userId;
  final Socket socket;
  final String category;

  const BodyReq(this.userId, this.socket, this.category, {Key? key}) : super(key: key);

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
  late String dropdownValue;
  late String reqLat;
  late String reqLng;
  String address = 'input address';

  //tabBar controller
  late TabController _tabController;

  //naverMap
  // late NaverMapController _mapController;
  late List<NMarker> markerList;
  late int tappedHelperIdx;

  late List<Users> _usersList;
  late String _userId;
  late TestViewModel _viewModel;
  late UsersState _state;
  NLatLng latLng = const NLatLng(37.565, 126.983);
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  final List<String> items = [
    '배달/구매 대행',
    '청소/가사 도움',
    '운반/수리',
    '동행/돌봄',
    '단기 알바',
    '기타',
  ];
  String? _selectedCategory;
  String? _categoryString;

  String _gender = '무관';

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
    _userId = widget.userId;
    initialize = _initialize();
  }

  Future _getHelpers() async {
    await _viewModel.onUsersEvent(UsersEvent.getAroundHelpers(_userId));
  }

  Future<void> _initialize() async {
    // WidgetsFlutterBinding.ensureInitialized();
    await NaverMapSdk.instance.initialize(
      clientId: 'w1vo0mp1hb',
      onAuthFailed: (ex) => print("!!!!!!naver map auth error : $ex !!!!!!"),
    );
    await _getHelpers();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<TestViewModel>();
    _state = _viewModel.usersState;

    Logger().d("userId(req page) : $_userId");

    return Column(
      children: [
        Expanded(
          child: Scaffold(
            body: FutureBuilder(
                future: initialize,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _usersList = _state.users;
                    _myIdx = _state.myIdx;
                    Logger().d(_myIdx);
                    return NaverMap(
                      options: const NaverMapViewOptions(indoorEnable: true, locationButtonEnable: true, consumeSymbolTapEvents: false),
                      onMapReady: (controller) async {
                        // _mapController = controller;
                        // controller.setLocationTrackingMode(NLocationTrackingMode.follow); // 내위치 줌

                        controller.latLngToScreenLocation(latLng);
                        markerList = [];
                        Logger().d("state : ${_state.users}");
                        for (int i = 0; i < _usersList.length; i++) {
                          if (_usersList[i].id != _userId) {
                            markerList.add(NMarker(id: _usersList[i].idx.toString(), position: NLatLng(_usersList[i].latitude, _usersList[i].longitude)));
                          }
                        }

                        // final markerList = latLngList
                        //     .map((point) => NMarker(id: point.toString() , position: point));
                        //네이버 맵 불러올때 실행
                        Logger().d('${markerList[2].position}');
                        for (NMarker marker in markerList) {
                          marker.setOnTapListener((marker) => onMarkerTap(marker));
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
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),

            //요청서 작성 버튼
            floatingActionButton: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment(Alignment.topRight.x - 0.1, Alignment.topRight.y + 0.05),
                  child: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: Container(
                                height: 400,
                                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("업무"),
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
                                        Text("성별 : "),
                                        Radio(
                                          value: '무관',
                                          groupValue: _gender,
                                          onChanged: (value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          },

                                        ),Text("무관"),
                                        Radio(
                                          value: '남자',
                                          groupValue: _gender,
                                          onChanged: (value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          },

                                        ),Text("남자"),
                                        Radio(
                                          value: '여자',
                                          groupValue: _gender,
                                          onChanged: (value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          },

                                        ),Text("여자"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      ).then((value) => null);
                    },
                    child: Icon(
                      Icons.manage_search,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(Alignment.bottomRight.x - 0.1, Alignment.bottomRight.y - 0.05),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (context, setState) {
                              return Wrap(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppBar(
                                        backgroundColor: Colors.white,
                                        title: const Text('카테고리 선택', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Column(
                                          children: [
                                            DropdownButton2(
                                              hint: const Text('select item'),
                                              isExpanded: true,
                                              items: items.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(value: value, child: Text(value));
                                              }).toList(),
                                              value: _selectedCategory,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedCategory = value as String;
                                                });
                                              },
                                            ),
                                            //title
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                              child: TextField(
                                                controller: _titleController,
                                                decoration: const InputDecoration(
                                                    hintText: '   제목을 입력해 주세요.',
                                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                                              ),
                                            ),
                                            // content
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                              child: TextField(
                                                controller: _contentController,
                                                minLines: 2,
                                                maxLines: 3,
                                                keyboardType: TextInputType.multiline,
                                                decoration: const InputDecoration(
                                                    hintText: '   심부름 내용을 입력해 주세요.',
                                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(9),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.orange),
                                                      ),
                                                      child: const Text('목적지 주소')),
                                                  Expanded(
                                                    child: Container(
                                                        padding: EdgeInsets.all(9),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.orange),
                                                        ),
                                                        child: Text(address)),
                                                  ),
                                                  MaterialButton(
                                                    child: const Text('search Post'),
                                                    color: Colors.orange,
                                                    onPressed: () => Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) => PostWebView(),
                                                    ))
                                                        .then((value) {
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
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                              child: MaterialButton(
                                                  color: Colors.orange,
                                                  child: const Text('요청하기'),
                                                  onPressed: () {
                                                    Logger().d('category: $_selectedCategory, '
                                                        'title: ${_titleController.value.text}, '
                                                        'content: ${_contentController.value.text}, '
                                                        'address: $address, '
                                                        'latitude: $reqLat'
                                                        'longitude: $reqLng');
                                                    var title = _titleController.value.text;
                                                    var content = _contentController.value.text;
                                                    int category = 0;
                                                    int i = 0;
                                                    for (String item in items) {
                                                      if (_selectedCategory == item) {
                                                        category = i;
                                                        Logger().d('categoryIdx: $category');
                                                      }
                                                      i++;
                                                    }
                                                    _viewModel.onUsersEvent(
                                                        UsersEvent.insertRequest(_myIdx, category.toString(), title, content, address, reqLat, reqLng));
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                              title: const Text('insert Request'),
                                                              content: Text('success'),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                    child: const Text('ok'))
                                                              ],
                                                            ));
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100,
                                      )
                                    ],
                                  )
                                ],
                              );
                            });
                          });
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
          ),
        ),
      ],
    );
  }

  void onMarkerTap(NMarker marker) {
    tappedHelperIdx = int.parse(marker.info.id);
    Logger().d("tappedHelperIdx: $tappedHelperIdx");
    showModalBottomSheet(
      context: context,
      builder: (context) => Center(
          child: MaterialButton(
        color: Colors.orange,
        child: const Text('match'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchPage(userId: _userId, helperId: tappedHelperIdx),
              ));
          // Navigator.pop(context);
        },
      )),
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    latLng = NLatLng(position.latitude, position.longitude);
    Logger().d("set latlng : ${latLng.toString()}");
  }

  void onTabBarTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  void onDropdownChanged(value) {
    setState(() {
      _selectedCategory = value!;
    });
  }
}
