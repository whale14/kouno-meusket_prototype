import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/work_category.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';
import 'package:test_project/screen/errand_history/recruitment_confirm_page.dart';
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

  Future getRequest() async {
    await _requestViewModel.onRequestEvent(RequestEvent.getRequest(widget.request.idx.toString()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tappedIndex = widget.tappedIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    _requestViewModel = context.watch<RequestViewModel>();
    _requestState = _requestViewModel.requestState;

    if (_tappedIndex == 0) {
      switch (_requestState.request!.status) {
        case 0:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RecruitmentConfirmPage(_requestState.request!),
              ));
          break;
        case 1:
          _action = const Padding(
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
          _action = const Padding(
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
        case 3:
          //진행중
          _action = const Padding(
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
            onTap: _requestState.request!.reviewRequesterIdx == null ? () async{
              //리뷰쓰기
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestFeedbackPage(_requestState.request!.requesterIdx),)).then((value) {
                if(value) {
                  _requestViewModel.onRequestEvent(RequestEvent.getRequest(_requestState.request!.idx.toString()));
                }
              });
            } : null,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _requestState.request!.reviewRequesterIdx == null ?  const Color(0xffF8A239) : const Color(0xffE9E9E9) ,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                _requestState.request!.reviewRequesterIdx == null ? '리뷰 쓰기' : "리뷰 작성 완료",
                style: TextStyle(color: Colors.white ),
              ),
            ),
          );
          break;
        default:
          break;
      }
    } else {
      switch (_requestState.request!.status) {
        case 0:
          //지원한 요청서
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
        case 1:
          //받은 요청서
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
                      (value) async{
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
          _action = const Padding(
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
              showAlert("심부름을 진행하시겠습니까?", "경고문구").then((value) async{
                if(value) {
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
          _action = const Padding(
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
            onTap: _requestState.request!.reviewWorkerIdx == null ? () async{
              //리뷰쓰기
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestFeedbackPage(_requestState.request!.workerIdx),)).then((value) {
                if(value) {
                  _requestViewModel.onRequestEvent(RequestEvent.getRequest(_requestState.request!.idx.toString()));
                }
              });
            } : null,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _requestState.request!.reviewWorkerIdx == null ?  const Color(0xffF8A239) : const Color(0xffE9E9E9) ,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                _requestState.request!.reviewWorkerIdx == null ? '리뷰 쓰기' : "리뷰 작성 완료",
                style: TextStyle(color: Colors.white ),
              ),
            ),
          );
          break;
        default:
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
                                Text("일시:${_requestState.request!.workDate == null ? "null" : _requestState.request!.workDate.toString()}"),
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
}
