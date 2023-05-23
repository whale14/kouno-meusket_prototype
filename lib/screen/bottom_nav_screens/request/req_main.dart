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
import 'package:test_project/presentation/state/users/other_user_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../domain/model/user/user.dart';
import '../../match_page.dart';
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
  late String dropdownValue;
  late String reqLat;
  late String reqLng;
  String address = 'input address';

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

    return Column(
      children: [
        Expanded(
          child: Scaffold(
            body: FutureBuilder(
                future: initialize,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _usersList = _usersState.users;
                    _myIdx = _usersState.myIdx;
                    Logger().d(_myIdx);
                    return NaverMap(
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
                Align(
                  alignment: Alignment(Alignment.topRight.x - 0.1, Alignment.topRight.y + 0.05),
                  child: FloatingActionButton(
                    heroTag: "search filter",
                    onPressed: () {
                      showDialog(
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
                      ).then((value) => null);
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
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder: (context, setState) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Wrap(
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
                                                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                          padding: const EdgeInsets.all(9),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.orange),
                                                          ),
                                                          child: const Text('목적지 주소')),
                                                      Expanded(
                                                        child: Container(
                                                            padding: const EdgeInsets.all(9),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.orange),
                                                            ),
                                                            child: Text(address)),
                                                      ),
                                                      MaterialButton(
                                                        color: Colors.orange,
                                                        onPressed: () => Navigator.of(context)
                                                            .push(MaterialPageRoute(
                                                          builder: (context) => const PostWebView(),
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
                                                        child: const Text('search Post'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    MaterialButton(
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
                                                                    content: const Text('success'),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed: () {
                                                                            _titleController.clear();
                                                                            _contentController.clear();
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: const Text('ok'))
                                                                    ],
                                                                  ));
                                                        }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 100,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
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
          ),
        ),
      ],
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
            SizedBox(
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
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            otherUserState.user!.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (otherUserState.user!.transportation != null)
                            for (String tp in otherUserState.user!.transportation!.split(',')) ...[
                              Text(
                                tp,
                                style: TextStyle(color: Colors.black26, fontSize: 12),
                              ),
                              SizedBox(
                                width: 5,
                              )
                            ],
                        ],
                      ),
                      RatingBar.builder(
                        itemBuilder: (context, index) => Icon(
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
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                child: Text(wc),
                              ),
                              SizedBox(
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
            SizedBox(height: 30),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  if (_userState.user!.isRequesterRegist == 0) {
                    alertRequestRegist();
                  } else {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: Wrap(
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
                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets.all(9),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.orange),
                                                      ),
                                                      child: const Text('목적지 주소')),
                                                  Expanded(
                                                    child: Container(
                                                        padding: const EdgeInsets.all(9),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.orange),
                                                        ),
                                                        child: Text(address)),
                                                  ),
                                                  MaterialButton(
                                                    color: Colors.orange,
                                                    onPressed: () => Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) => const PostWebView(),
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
                                                    child: const Text('search Post'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                const SizedBox(height: 20),
                                                MaterialButton(
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
                                                          UsersEvent.sendRequestToWorker(_myIdx, otherUserState.user!.idx.toString(), category.toString(), title, content, address, reqLat, reqLng, otherUserState.user!.fcmToken));
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                                title: const Text('insert Request'),
                                                                content: const Text('success'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed: () {
                                                                        _titleController.clear();
                                                                        _contentController.clear();
                                                                        Navigator.of(context).pop();
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: const Text('ok'))
                                                                ],
                                                              ));
                                                    }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
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

  void onDropdownChanged(value) {
    setState(() {
      _selectedCategory = value!;
    });
  }

  void alertRequestRegist() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("요청자 신원등록"),
          content: Wrap(
            children: [
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
}
