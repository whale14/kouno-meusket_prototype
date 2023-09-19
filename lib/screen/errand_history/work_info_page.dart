import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/request/waypoint.dart';
import 'package:test_project/domain/model/work_category.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/state/request/waypoint_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/errand_history/recruitment_confirm_page.dart';
import 'package:test_project/screen/errand_history/request_history.dart';
import 'package:test_project/screen/mypage/user_info_screen.dart';
import 'package:test_project/screen/review/request_feedback_page.dart';

class WorkInfoPage extends StatefulWidget {
  final Request request;
  final int tappedIndex;

  const WorkInfoPage(
    this.request,
    this.tappedIndex, {
    super.key,
  });

  @override
  State<WorkInfoPage> createState() => _WorkInfoPageState();
}

class _WorkInfoPageState extends State<WorkInfoPage> {
  late int _tappedIndex;

  late Widget _action;
  late Widget _map;
  late Widget _bottomBtn;

  late RequestViewModel _requestViewModel;
  late RequestState _requestState;
  late WaypointState _waypointState;

  late UserViewModel _userViewModel;

  List<String> _cancelReasonCheckList = ['취소이유 1', '취소이유 2', '취소이유 3', '취소이유 4'];
  List<bool> _cancelReasonCheckVal = [false, false, false, false];
  bool _otherReasonCheckVal = false;

  final _otherReasonController = TextEditingController();

  Future getRequest() async {
    await _requestViewModel.onRequestEvent(RequestEvent.getRequest(widget.request.idx.toString()));
    await _requestViewModel.onRequestEvent(RequestEvent.getWaypoints(widget.request.idx.toString()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tappedIndex = widget.tappedIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getRequest();
      if (_tappedIndex == 0) { //드림이 모집중인 심부름이라면 지원서 확인 페이지로 이동
        if (_requestState.request!.status == 0) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => RecruitmentConfirmPage(_requestState.request!),
          ));
        }

        if (_requestState.request!.status == 3 && _requestState.request!.successCheck == 0) {
          successCheck(_requestState.request!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _requestViewModel = context.watch<RequestViewModel>();
    _requestState = _requestViewModel.requestState;
    _waypointState = _requestViewModel.waypointState;

    _userViewModel = context.watch<UserViewModel>();

    if (_tappedIndex == 0) {
      //tappedIndex 는 부름이인지 드림이인지 구별하기위함
      //심부름의 type에 따라 다른 화면이 나와야한다. (requestType, secondType)
      //일반-예약, 일반-즉시, 지정-예약, 지정-즉시
      //매칭단계를 넘어가면 달라지는것은 딱히 없음.
      String userIdx = _requestState.request!.requesterIdx.toString();
      switch (_requestState.request!.status) {
        case 0:
          if(_requestState.request!.requestType == 0) {
            if(_requestState.request!.secondType == 0) {
              return Scaffold(
                body: Container(),
              );
            }else {
              _action = Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    warningCancelRequest(_tappedIndex, _requestState.request!, userIdx);
                  },
                  child: const Column(
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
              ); //Action,
              _map = NaverMap(
                options: NaverMapViewOptions(
                  indoorEnable: false,
                  locationButtonEnable: false,
                  consumeSymbolTapEvents: false,
                  scrollGesturesEnable: false,
                  initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
                ),
                onMapReady: (controller) {
                  controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
                },
              );
              _bottomBtn = Container();
            }
          } else {
            _action = Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  warningCancelRequest(_tappedIndex, _requestState.request!, userIdx);
                },
                child: const Column(
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
            ); //Action,
            _map = NaverMap(
              options: NaverMapViewOptions(
                indoorEnable: false,
                locationButtonEnable: false,
                consumeSymbolTapEvents: false,
                scrollGesturesEnable: false,
                initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
              ),
              onMapReady: (controller) {
                controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
              },
            );
            _bottomBtn = Container();
          }
          break;
        case 1://진행대기
          _action = Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                warningCancelRequest(_tappedIndex, _requestState.request!, userIdx);
              },
              child: const Column(
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
          ); //Action,
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = Container();
          break;
        case 2:
          //진행중
          _action = Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                warningCancelRequest(_tappedIndex, _requestState.request!, userIdx);
              },
              child: const Column(
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
          ); //Action,
          _map = Stack(
            children: [
              NaverMap(
                options: NaverMapViewOptions(
                  indoorEnable: false,
                  locationButtonEnable: false,
                  consumeSymbolTapEvents: false,
                  scrollGesturesEnable: false,
                  initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
                ),
                onMapReady: (controller) {
                  controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
                },
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: MaterialButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RealTimeLocation(widget.request),
                    ),
                  ),
                  child: Text('실시간 위치 확인'),
                ),
              ),
            ],
          );
          _bottomBtn = Container();
          break;
        case 3:
          //완료된 심부름
          _action = Container();
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = GestureDetector(
            onTap: _requestState.request!.reviewRequesterIdx == null
                ? () async {
              //리뷰쓰기
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => RequestFeedbackPage(_requestState.request!.requesterIdx),
              ))
                  .then((value) {
                if (value) {
                  _requestViewModel.onRequestEvent(RequestEvent.getRequest(_requestState.request!.idx.toString()));
                }
              });
            }
                : null,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _requestState.request!.reviewRequesterIdx == null ? const Color(0xffF8A239) : const Color(0xffE9E9E9),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                _requestState.request!.reviewRequesterIdx == null ? '리뷰 쓰기' : "리뷰 작성 완료",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
          break;
        default:
          //취소된 심부름
          _action = Container();
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = Container();
          break;
      }
    } else {
      String userIdx = _requestState.request!.workerIdx.toString();
      switch (_requestState.request!.status) {
        case 0:
          //지원한 요청서
          _action = Container(); //지원 취소 구현
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          if (_requestState.request!.workerIdx == 0) {
            _bottomBtn = GestureDetector(
              onTap: () async {
                showAlert("심부름을 지원하시겠습니까?", "경고문구").then((value) async {
                  if (value) {
                    await _requestViewModel
                        .onRequestEvent(RequestEvent.recruitmentRequest(_requestState.request!.idx.toString(), _userViewModel.userState.user!.idx.toString()))
                        .then((value) => Navigator.of(context).pop(true));
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffF8A239),
                  border: Border.all(color: const Color(0xffF8A239)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '심부름 지원하기',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            );
          } else {
            _bottomBtn = Container();
          }
          break;
        case 1:
          //받은 요청서
          _action = Container(); //없어도 됨
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    //지정요청서 거절
                    // await _requestViewModel.onRequestEvent(RequestEvent.acceptRequest(_requestState.request!.idx.toString(), _requestState.request!.workerIdx.toString()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(-1, 0), blurRadius: 0),
                        BoxShadow(color: Colors.grey, offset: Offset(0, 1)),
                        BoxShadow(color: Colors.grey, offset: Offset(0, -1)),
                      ],
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                    ),
                    child: const Text(
                      '거절',
                      style: TextStyle(color: Colors.grey, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    showAlert("심부름을 수락 하시겠습니까?", "경고문구").then(
                      (value) async {
                        Logger().d("########$value");
                        if (value) {
                          await _requestViewModel
                              .onRequestEvent(RequestEvent.acceptRequest(_requestState.request!.idx.toString(), _requestState.request!.workerIdx.toString()));
                        }
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8A239),
                      border: Border.all(color: const Color(0xffF8A239)),
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(5)),
                    ),
                    child: const Text(
                      '수락',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          );
          break;
        case 2:
          //진행대기
          _action = Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                warningCancelRequest(_tappedIndex, _requestState.request!, userIdx);
              },
              child: const Column(
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
          ); //Action,
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = GestureDetector(
            onTap: () async {
              showAlert("심부름을 진행하시겠습니까?", "경고문구").then((value) async {
                if (value) {
                  await _requestViewModel.onRequestEvent(RequestEvent.startRequest(_requestState.request!.idx.toString()));
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffF8A239),
                border: Border.all(color: const Color(0xffF8A239)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '심부름 시작',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          );
          break;
        case 3:
          _action = Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                warningCancelRequest(_tappedIndex, _requestState.request!, userIdx);
              },
              child: const Column(
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
          ); //Action,
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = GestureDetector(
            onTap: () async {
              await _requestViewModel.onRequestEvent(RequestEvent.finishRequest(_requestState.request!.idx.toString()));
            },
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffF8A239),
                border: Border.all(color: const Color(0xffF8A239)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '수행 완료',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          );
          break;
        case 4:
          _action = Container();
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = GestureDetector(
            onTap: _requestState.request!.reviewWorkerIdx == null
                ? () async {
                    //리뷰쓰기
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => RequestFeedbackPage(_requestState.request!.workerIdx),
                    ))
                        .then((value) {
                      if (value) {
                        _requestViewModel.onRequestEvent(RequestEvent.getRequest(_requestState.request!.idx.toString()));
                      }
                    });
                  }
                : null,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _requestState.request!.reviewWorkerIdx == null ? const Color(0xffF8A239) : const Color(0xffE9E9E9),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                _requestState.request!.reviewWorkerIdx == null ? '리뷰 쓰기' : "리뷰 작성 완료",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
          break;
        default:
          //취소된 심부름
          _action = Container();
          _map = NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: false,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              scrollGesturesEnable: false,
              initialCameraPosition: NCameraPosition(target: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude), zoom: 15),
            ),
            onMapReady: (controller) {
              controller.addOverlay(NMarker(id: 'destination', position: NLatLng(_requestState.request!.latitude, _requestState.request!.longitude)));
            },
          );
          _bottomBtn = Container();
          break;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("요청서 정보"),
        actions: [_action],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: _map,
            ),
            InkWell(
              onTap: () async {
                //유저 정보 보기
                await _userViewModel
                    .onUsersEvent(UsersEvent.getOtherUser(
                        _tappedIndex == 0 ? _requestState.request!.workerIdx.toString() : _requestState.request!.requesterIdx.toString()))
                    .then((value) => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfoScreen(),
                        )));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              "http://${_tappedIndex == 0 ? _requestState.request!.workerImgUrl : _requestState.request!.requesterImgUrl}",
                              cacheWidth: 1080,
                              width: 48,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            _tappedIndex == 0 ? _requestState.request!.workerName : _requestState.request!.requesterName,
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
                        _requestState.request!.title,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xffE77924),
                        ),
                        child: Text(
                          WorkCategory().setWorkCategory(_requestState.request!.workCategoryIdx),
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
                                      _requestState.request!.reward.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    const Text("원"),
                                  ],
                                ),
                                Text(
                                  "${DateFormat("yyyy-MM-dd").format(_requestState.request!.workDate!)} "
                                  "${_requestState.request!.workDate!.hour >= 12 ? '오후 ' : '오전 '}"
                                  "${_requestState.request!.workDate!.hour >= 13 ? _requestState.request!.workDate!.hour - 12 : _requestState.request!.workDate!.hour}시"
                                  "${_requestState.request!.workDate!.minute != 0 ? '${_requestState.request!.workDate!.minute}분' : ''}",
                                ),
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
                              Expanded(child: Text(_requestState.request!.address, style: const TextStyle(color: Colors.black54, fontSize: 16))),
                            ],
                          ),
                        ),
                        TextField(
                          controller: TextEditingController(text: _requestState.request!.content),
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
                  waypoint(_waypointState.waypoints) ?? Container(),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: _bottomBtn,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showAlert(String title, warningText) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
              ),
              SvgPicture.asset("asset/icons/warning.svg"),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "※ $warningText.",
                style: const TextStyle(fontSize: 12, color: Colors.redAccent),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 2),
                elevation: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            "아니요(NO)",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop(true);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(color: Color(0xffF8A239), borderRadius: BorderRadius.only(bottomRight: Radius.circular(3))),
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            "예(YES)",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((value) => value);
  }

  waypoint(List<Waypoint> waypoints) {
    if (waypoints.length > 0) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: waypoints.length,
        itemBuilder: (context, index) {
          final waypoint = waypoints[index];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text("경유지"),
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
                      Expanded(child: Text(waypoint.address, style: const TextStyle(color: Colors.black54, fontSize: 16))),
                    ],
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: waypoint.content),
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
          );
        },
      );
    }
  }

  warningCancelRequest(int tappedIndex, Request request, String userIdx) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 48,
                    ),
                    SvgPicture.asset("asset/icons/warning.svg"),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      '심부름을 취소하시겠습니까?',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "※ 경고문구(패널티 내용).",
                      style: TextStyle(fontSize: 12, color: Colors.redAccent),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('취소사유를 입력해주세요'),
                    const Text('...'),
                    ListView.builder(
                      itemExtent: 32,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _cancelReasonCheckList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Checkbox(
                                value: _cancelReasonCheckVal[index],
                                onChanged: (value) {
                                  setState(() {
                                    _cancelReasonCheckVal[index] = value!;
                                  });
                                }),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(_cancelReasonCheckList[index]),
                          ],
                        );
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _otherReasonCheckVal,
                            onChanged: (value) {
                              setState(() {
                                _otherReasonCheckVal = value!;
                              });
                            }),
                        Text('기타'),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: _otherReasonController,
                              enabled: _otherReasonCheckVal ? true : false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Card(
                      margin: const EdgeInsets.only(bottom: 2),
                      elevation: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(false),
                              child: Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  "아니요(NO)",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                bool b = false;
                                String content = '';
                                int i = 0;
                                for (bool value in _cancelReasonCheckVal) {
                                  if (value) {
                                    content += '${_cancelReasonCheckList[i]},';
                                    b = true;
                                  }
                                  i++;
                                }
                                if (b) {
                                  if (_otherReasonCheckVal) {
                                    if (_otherReasonController.value.text.trim() == "") {
                                      Fluttertoast.showToast(msg: "기타 이유를 작성해주세요");
                                    } else {
                                      content += _otherReasonController.value.text.trim();
                                      Fluttertoast.showToast(msg: "content : $content");
                                      _requestViewModel
                                          .onRequestEvent(RequestEvent.requestCancel(
                                              request.idx.toString(), content, request.status.toString(), userIdx, _tappedIndex.toString()))
                                          .then((value) => Navigator.of(context).pop(true));
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: "content : $content");
                                    _requestViewModel
                                        .onRequestEvent(RequestEvent.requestCancel(
                                            request.idx.toString(), content, request.status.toString(), userIdx, _tappedIndex.toString()))
                                        .then((value) => Navigator.of(context).pop(true));
                                  }
                                } else {
                                  if (_otherReasonCheckVal) {
                                    content += _otherReasonController.value.text;
                                    Fluttertoast.showToast(msg: "content : $content");
                                    _requestViewModel
                                        .onRequestEvent(RequestEvent.requestCancel(
                                            request.idx.toString(), content, request.status.toString(), userIdx, _tappedIndex.toString()))
                                        .then((value) => Navigator.of(context).pop(true));
                                  } else {
                                    Fluttertoast.showToast(msg: "취소이유를 선택해주세요");
                                  }
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(color: Color(0xffF8A239), borderRadius: BorderRadius.only(bottomRight: Radius.circular(3))),
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  "예(YES)",
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  successCheck(Request request) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('심부름이 정상적으로 완료되셨나요?'),
          actions: [
            TextButton(
              onPressed: () async {
                //
                await _requestViewModel
                    .onRequestEvent(RequestEvent.successCheckConfirm(
                        request.idx.toString(), request.requesterIdx.toString(), request.workerIdx.toString(), request.reward.toString()))
                    .then((value) => Navigator.of(context).pop(true));
              },
              child: Text('네'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('아니요'),
            ),
            //아니요일 경우 어떻게 해야할지
          ],
        );
      },
    );
  }
}
