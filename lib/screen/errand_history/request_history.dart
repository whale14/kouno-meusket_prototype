import 'dart:async';
import 'dart:convert';

import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/work_category.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/state/users/other_user_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/errand_history/recruitment_confirm_page.dart';
import 'package:test_project/screen/errand_history/work_info_page.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  late RequestViewModel _requestViewModel;
  late RequestState _state;
  late UserViewModel _userViewModel;
  int _tappedIndex = 0;

  double latitude = 0;
  double longitude = 0;

  late String? idx;
  late Future initialize;
  late IO.Socket socket;

  // bool _show = true;
  // Timer? _timer;

  @override
  void dispose() {
    // TODO: implement dispose
    _requestViewModel.onRequestEvent(RequestEvent.getRequests(idx!));
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
    //   setState(() {
    //     _show = !_show;
    //   });
    // });
    initialize = _initialize();
  }

  Future _initialize() async {
    await _getSharedIdx();
    await _getMyRequests(_tappedIndex);
  }

  Future _getSharedIdx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idx = prefs.getString('idx');
    Logger().d('>>>idx: $idx');
  }

  Future _getMyRequests(int index) async {
    Logger().d('when _getMyRequests start?');
    if (index == 0) {
      await _requestViewModel.onRequestEvent(RequestEvent.getMyRequestsRequesterSide(idx!));
    } else {
      await _requestViewModel.onRequestEvent(RequestEvent.getMyRequestsWorkerSide(idx!));
    }
    Logger().d("do getMyRequests${_state.requests}");
  }

  @override
  Widget build(BuildContext context) {
    _requestViewModel = context.watch<RequestViewModel>();
    _userViewModel = context.read<UserViewModel>();
    _state = _requestViewModel.requestState;
    return FutureBuilder(
        future: initialize,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Logger().d('!!!!!!!!!!!!!!@@@@@@@@@@@@@${_state.requests}');

            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    onTap: onTabBarTap,
                    tabs: const <Widget>[
                      Tab(
                        text: '부름이',
                      ),
                      Tab(
                        text: '드림이',
                      ),
                    ],
                  ),
                  title: const Text(
                    '요청내역',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: ListView.builder(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  itemCount: _state.requests.length,
                  itemBuilder: (context, index) {
                    final request = _state.requests[index];
                    return requestCard(request);
                  },
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void onTabBarTap(int index) {
    setState(() {
      _tappedIndex = index;
      _getMyRequests(index);
    });
  }

  void onRequestTap(Request request) {
    if (_tappedIndex == 0) {
      //부름이 활동 요청서 조회
      switch (request.status) {
        case 0:
          //드림이 모집중
          goRecruitmentConfirmPage(request);
          break;
        case 1:
          //수락 대기중
          workingStateModal(
            request,
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined),
                  Text(
                    "심부름 취소",
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ), //Action,
            NaverMap(
              options: NaverMapViewOptions(
                indoorEnable: false,
                locationButtonEnable: false,
                consumeSymbolTapEvents: false,
                scrollGesturesEnable: false,
                initialCameraPosition: NCameraPosition(target: NLatLng(request.latitude, request.longitude), zoom: 15),
              ),
              onMapReady: (controller) {
                controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
              },
            ),
            Container(),
          );
          break;
        case 2:
          //진행대기중
          workingStateModal(
            request,
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined),
                  Text(
                    "심부름 취소",
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
            NaverMap(
              options: NaverMapViewOptions(
                indoorEnable: false,
                locationButtonEnable: false,
                consumeSymbolTapEvents: false,
                scrollGesturesEnable: false,
                initialCameraPosition: NCameraPosition(target: NLatLng(request.latitude, request.longitude), zoom: 15),
              ),
              onMapReady: (controller) {
                controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
              },
            ),
            Container(),
          );
          break;
        case 3:
          //진행중
          workingStateModal(
            request,
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined),
                  Text(
                    "심부름 취소",
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
            Stack(children: [
              NaverMap(
                options: NaverMapViewOptions(
                  indoorEnable: false,
                  locationButtonEnable: false,
                  consumeSymbolTapEvents: false,
                  scrollGesturesEnable: false,
                  initialCameraPosition: NCameraPosition(target: NLatLng(request.latitude, request.longitude), zoom: 15),
                ),
                onMapReady: (controller) {
                  controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
                },
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  color: Colors.white,
                  child: const Icon(Icons.location_on_outlined),
                ),
              ),
            ]),
            Container(),
          );
          break;
        //진행중
        case 4:
        //진행종료
        default:
        //취소된 심부름
      }
    } else {
      switch (request.status) {
        //드림이 활동 요청서 조회
        case 0:
          //지원한 요청서
          workingStateModal(
            request,
            Container(),
            NaverMap(
              options: NaverMapViewOptions(
                indoorEnable: false,
                locationButtonEnable: false,
                consumeSymbolTapEvents: false,
                scrollGesturesEnable: false,
                initialCameraPosition: NCameraPosition(target: NLatLng(request.latitude, request.longitude), zoom: 15),
              ),
              onMapReady: (controller) {
                controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
              },
            ),
            Container(),
          );
          break;
        case 1:
          //지정요청서
          workingStateModal(
            request,
            Container(),
            NaverMap(
              options: NaverMapViewOptions(
                indoorEnable: false,
                locationButtonEnable: false,
                consumeSymbolTapEvents: false,
                scrollGesturesEnable: false,
                initialCameraPosition: NCameraPosition(target: NLatLng(request.latitude, request.longitude), zoom: 15),
              ),
              onMapReady: (controller) {
                controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
              },
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        '거절',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xffF8A239),
                        border: Border.all(color: Color(0xffF8A239)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        '수락',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          break;
        case 2:
          //진행대기
          workingStateModal(
            request,
            Container(),
            NaverMap(
              options: NaverMapViewOptions(
                indoorEnable: false,
                locationButtonEnable: false,
                consumeSymbolTapEvents: false,
                scrollGesturesEnable: false,
                initialCameraPosition: NCameraPosition(target: NLatLng(request.latitude, request.longitude), zoom: 15),
              ),
              onMapReady: (controller) {
                controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
              },
            ),
            GestureDetector(
              onTap: () async {
                await _requestViewModel.onRequestEvent(RequestEvent.startRequest(request.idx.toString()));
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xffF8A239),
                  border: Border.all(color: Color(0xffF8A239)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '심부름 시작',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          );
          break;
        case 3:
        //진행중
        case 4:
        //완료됨
        default:
        //취소된 심부름
      }
    }
  }

  void goRecruitmentConfirmPage(Request request) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecruitmentConfirmPage(request),
      ),
    );
  }

  void workingStateModal(Request request, Widget action, Widget map, Widget bottomBtn) {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateBuilder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    title: const Text(
                      '요청서 정보',
                    ),
                    leading: GestureDetector(onTap: () => Navigator.of(context).pop(true), child: const Icon(Icons.keyboard_arrow_down)),
                    actions: [action],
                  ),
                  SizedBox(
                    height: 250,
                    child: NaverMap(
                      options: NaverMapViewOptions(
                        indoorEnable: false,
                        locationButtonEnable: false,
                        consumeSymbolTapEvents: false,
                        scrollGesturesEnable: false,
                        initialCameraPosition: NCameraPosition(target: NLatLng(request.latitude, request.longitude), zoom: 15),
                      ),
                      onMapReady: (controller) {
                        controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      //유저 정보 보기
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    "http://${_tappedIndex == 0 ? request.workerImgUrl : request.requesterImgUrl}",
                                    cacheWidth: 1080,
                                    width: 48,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  _tappedIndex == 0 ? request.workerName : request.requesterName,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RatingBar.builder(
                                  initialRating: 5,
                                  ignoreGestures: true,
                                  itemSize: 20,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (value) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey), bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              request.title,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xffE77924),
                              ),
                              child: Text(
                                WorkCategory().setWorkCategory(request.workCategoryIdx),
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.check),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("상세내용 확인"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("심부름비:"),
                                          Text(
                                            request.reward.toString(),
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                          const Text("원"),
                                        ],
                                      ),
                                      Text("일시:${request.workDate == null ? "null" : request.workDate.toString()}"),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey),
                                      top: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey)),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(request.address, style: const TextStyle(color: Colors.black54, fontSize: 16))),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: TextEditingController(text: request.content),
                                enabled: false,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: bottomBtn,
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _connect(String idx) {
    socket = IO.io(
      'http://192.168.100.42:3000', //5층 ip
      // 'http://192.168.101.2:3000', // 3층 ip
      <String, dynamic>{
        'transports': ['websocket']
      },
    );

    socket.connect();
    socket.on('workerLocation', (data) {
      String jsonLocation = jsonEncode(data[0]);
      Map<String, dynamic> jsonMap = jsonDecode(jsonLocation);
      setState(() {
        latitude = jsonMap['latitude'];
        longitude = jsonMap['longitude'];
      });
      Logger().d('workerLocation : ($latitude, $longitude)}');
    });

    //헬퍼 idx 보내기
    socket.on('event', (data) {
      Logger().d('$data');
      socket.emit('getWorkerLocation', idx);
    });
  }

  requestCard(Request request) {
    Widget statusContainer;
    if (_tappedIndex == 0) {
      // 부름이 활동 내역
      switch (request.status) {
        case 0:
          {
            //드림이 모집중(일반요청)
            statusContainer = const Column(
              children: [
                Text("드림이 모집중"),
              ],
            );
            break;
          }
        case 1:
          {
            //수락대기 (지정요청)
            statusContainer = Column(
              children: [
                const Text("수락 대기중"),
                ClipOval(
                    child: Image.network(
                  "http://${request.workerImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.workerName),
              ],
            );
            break;
          }
        case 2:
          {
            //진행대기
            statusContainer = Column(
              children: [
                const Text("진행 대기중"),
                ClipOval(
                    child: Image.network(
                  "http://${request.workerImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.workerName),
              ],
            );
            break;
          }
        case 3:
          {
            //진행중
            statusContainer = Column(
              children: [
                const BlinkText("진행중", beginColor: Colors.redAccent, endColor: Colors.transparent, duration: Duration(seconds: 1)),
                ClipOval(
                    child: Image.network(
                  "http://${request.workerImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.workerName),
              ],
            );
            break;
          }
        case 4:
          {
            //완료된 심부름
            statusContainer = Column(
              children: [
                const Text("완료된 심부름"),
                ClipOval(
                    child: Image.network(
                  "http://${request.workerImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.workerName),
              ],
            );
            break;
          }
        default:
          //취소된 심부름
          statusContainer = const Column(
            children: [
              Text("취소된 심부름"),
            ],
          );
      }
    } else {
      // 드림이 활동 내역
      switch (request.status) {
        case 0:
          {
            //내가 지원한 요청서
            statusContainer = Column(
              children: [
                const Text("지원한 요청"),
                ClipOval(
                    child: Image.network(
                  "http://${request.requesterImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.requesterName),
              ],
            );
            break;
          }
        case 1:
          {
            //지정요청서 열람
            statusContainer = Column(
              children: [
                const Text("수락 대기중"),
                ClipOval(
                    child: Image.network(
                  "http://${request.requesterImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.requesterName),
              ],
            );
            break;
          }
        case 2:
          {
            statusContainer = Column(
              children: [
                const Text(
                  "진행 대기중",
                ),
                ClipOval(
                    child: Image.network(
                  "http://${request.requesterImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.requesterName),
              ],
            );
            break;
          }
        case 3:
          {
            statusContainer = Column(
              children: [
                const BlinkText(
                  "진행중",
                  beginColor: Colors.redAccent,
                  endColor: Colors.transparent,
                  duration: Duration(seconds: 1),
                ),
                ClipOval(
                    child: Image.network(
                  "http://${request.requesterImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.requesterName),
              ],
            );
            break;
          }
        case 4:
          {
            statusContainer = Column(
              children: [
                const Text(
                  "완료된 심부름",
                ),
                ClipOval(
                    child: Image.network(
                  "http://${request.requesterImgUrl}",
                  cacheWidth: 1080,
                  width: 54,
                )),
                Text(request.requesterName),
              ],
            );
            break;
          }
        default:
          {
            statusContainer = const Column(
              children: [
                BlinkText(
                  "취소된 심부름",
                  beginColor: Colors.redAccent,
                  endColor: Colors.transparent,
                  duration: Duration(seconds: 1),
                ),
              ],
            );
            break;
          }
      }
    }
    return GestureDetector(
      onTap: () async {
        await _requestViewModel.onRequestEvent(RequestEvent.getRequest(request.idx.toString())).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkInfoPage(request, _tappedIndex),
                ),
              ).then((value) {
                _getMyRequests(_tappedIndex);
              }),
            );
      }, //onRequestTap(request),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: const BorderSide(color: Color(0xffF0F0F0))),
        margin: const EdgeInsets.only(top: 16),
        elevation: 4,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        request.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("카테고리${request.workCategoryIdx.toString()}"),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(request.address),
                  const SizedBox(
                    width: 8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(request.workDate != null ? "null" : "notnull"),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text("심부름비"),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("${request.reward.toString()}원"),
                    ],
                  ),
                ],
              ),
              statusContainer,
            ],
          ),
        ),
      ),
    );
  }
}

class realTimeLocation extends StatefulWidget {
  final Request request;

  const realTimeLocation(this.request, {Key? key}) : super(key: key);

  @override
  State<realTimeLocation> createState() => _realTimeLocationState();
}

class _realTimeLocationState extends State<realTimeLocation> {
  late UserViewModel _userViewModel;
  late UserState _userState;
  late OtherUserState _otherUserState;
  late RequestViewModel _requestViewModel;
  late RequestState _requestState;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const Duration(seconds: 3);
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _userViewModel.onUsersEvent(UsersEvent.getOtherUser(widget.request.workerIdx.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = context.watch<UserViewModel>();
    _otherUserState = _userViewModel.otherUserState;
    final NLatLng destination = NLatLng(widget.request.latitude, widget.request.longitude);
    final workerLocation = NLatLng(_otherUserState.user!.latitude, _otherUserState.user!.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text("실시간 위치 확인"),
      ),
      body: NaverMap(
        onMapReady: (controller) {
          final destMarker = NMarker(id: "destination", position: destination);
          final destinationInfo = NInfoWindow.onMarker(
            id: "destInfo",
            text: "도착지",
          );
          final workerMarker = NMarker(id: "worker", position: workerLocation);
          final workerInfo = NInfoWindow.onMarker(id: "workerInfo", text: "드림이");
          final path = NArrowheadPathOverlay(id: "path", coords: [workerLocation, destination], color: Colors.orange, width: 8);
          // final distance = workerLocation.distanceTo(destination);
          // final distanceInfo = NInfoWindow.onMap(id: "distanceInfo", text: "거리 : ${distance}M", position: NLatLng((workerLocation.latitude + destination.latitude) /2, (workerLocation.longitude + destination.longitude)/2));

          controller.addOverlay(destMarker);
          controller.addOverlay(workerMarker);
          destMarker.openInfoWindow(destinationInfo);
          workerMarker.openInfoWindow(workerInfo);
          controller.addOverlay(path);
          // controller.addOverlay(distanceInfo);
        },
        options: NaverMapViewOptions(initialCameraPosition: NCameraPosition(target: workerLocation, zoom: 14)),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
  }
}
