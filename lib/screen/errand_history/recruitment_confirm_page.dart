import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/request/request_recruitment.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/state/request/request_recruitment_state.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';

class RecruitmentConfirmPage extends StatefulWidget {
  final Request request;

  const RecruitmentConfirmPage(this.request, {super.key});

  @override
  State<RecruitmentConfirmPage> createState() => _RecruitmentConfirmPageState();
}

class _RecruitmentConfirmPageState extends State<RecruitmentConfirmPage> {
  late RequestViewModel _requestViewModel;
  late RequestState _requestState;
  late RequestRecruitmentState _recruitmentState;

  Future _getRecruitments() async {
    await _requestViewModel.onRequestEvent(RequestEvent.getRecruitments(widget.request.idx.toString()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getRecruitments();
    });
  }

  @override
  Widget build(BuildContext context) {
    _requestViewModel = context.watch<RequestViewModel>();
    _requestState = _requestViewModel.requestState;
    _recruitmentState = _requestViewModel.recruitmentState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('지원서 확인'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                warningCancelRequest(0, _requestState.request!, _requestState.request!.requesterIdx.toString());
              },
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
          ), //Action,
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => onRequestTap(widget.request),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.maxFinite,
              color: const Color(0xffFBFBFB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("마감시간", style: TextStyle(color: Color(0xff797979), fontSize: 10)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.request.title, style: const TextStyle(fontSize: 24)),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("일시", style: TextStyle(color: Color(0xff959595), fontSize: 12)),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "※ 매칭 마감시간은 요청서 작성 후 1시간 입니다.",
                        style: TextStyle(color: Color(0xffCC272B), fontSize: 10),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text("드림이 매칭 대기"),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _recruitmentState.recruitments.length,
                itemBuilder: (context, index) {
                  var recruitment = _recruitmentState.recruitments[index];
                  Logger().d("_recruitments : ${_recruitmentState.recruitments.length}");
                  Color color;
                  if (recruitment.isRejected == 0) {
                    color = Colors.white;
                  } else {
                    color = const Color(0xffE9E9E9);
                  }
                  return Card(
                    color: color,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: const BorderSide(color: Color(0xffF0F0F0))),
                    elevation: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  "http://${recruitment.workerImgUrl}",
                                  cacheWidth: 1080,
                                  width: 60,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        recruitment.workerName,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(recruitment.transportation, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  RatingBar.builder(
                                    allowHalfRating: true,
                                    initialRating: 5,
                                    ignoreGestures: true,
                                    itemSize: 24,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (value) => (value) {},
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      for (String wc in recruitment.workCategory.split(",")) ...[
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                          child: Text(wc),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector( //심부름 반려 버튼
                                onTap: recruitment.isRejected == 0 //반려된 지원서는 탭 이벤트 비활성화
                                    ? () { //반려되지않은 지원서
                                        showGeneralDialog(
                                          context: context,
                                          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => Dialog(
                                            insetPadding: const EdgeInsets.all(26),
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
                                                    "거절 하시겠습니까?",
                                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text(
                                                    "※  거절된 드림이는 이 심부름을 지원할 수 없습니다.",
                                                    style: TextStyle(fontSize: 12, color: Colors.redAccent),
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
                                                            onTap: () => Navigator.of(context).pop(true),
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
                                                              await _requestViewModel
                                                                  .onRequestEvent(RequestEvent.rejectApplication(recruitment.idx.toString()));
                                                              await _requestViewModel
                                                                  .onRequestEvent(RequestEvent.getRecruitments(recruitment.requestIdx.toString()));
                                                              Navigator.of(context).pop(true);
                                                            },
                                                            child: Container(
                                                              alignment: Alignment.center,
                                                              decoration: const BoxDecoration(
                                                                  color: Color(0xffF8A239), borderRadius: BorderRadius.only(bottomRight: Radius.circular(3))),
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
                                      }
                                    : null,
                                child: Container(
                                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffEBEBEB)))),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    "거절",
                                    style: recruitment.isRejected == 0 ? null : const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            Expanded( // 심부름 선택 버튼
                              child: GestureDetector(
                                onTap: recruitment.isRejected == 0
                                    ? () {
                                        showGeneralDialog(
                                          context: context,
                                          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => Dialog(
                                            insetPadding: const EdgeInsets.all(26),
                                            child: SizedBox(
                                              width: double.maxFinite,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 32,
                                                  ),
                                                  const Text(
                                                    "수락 하시겠습니까?",
                                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ClipOval(
                                                          child: Image.network(
                                                        "http://${recruitment.workerImgUrl}",
                                                        cacheWidth: 1080,
                                                        width: 60,
                                                      )),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      Text(
                                                        recruitment.workerName,
                                                        style: const TextStyle(fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 32,
                                                  ),
                                                  Card(
                                                    margin: const EdgeInsets.only(bottom: 2),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: () => Navigator.of(context).pop(true),
                                                            child: Container(
                                                              color: Colors.white,
                                                              width: double.maxFinite,
                                                              padding: const EdgeInsets.all(16),
                                                              alignment: Alignment.center,
                                                              child: const Text(
                                                                "아니요(NO)",
                                                                style: TextStyle(fontSize: 16),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: () async { // 심부름 선택하고 드림이와 매칭만 구현되어있는상태 - 다른 심부름들을 반려시키고 알림을 보내는 코드를 추가해야함
                                                              String reqIdx = widget.request.idx.toString();
                                                              String workerIdx = recruitment.userIdx.toString();
                                                              await _requestViewModel.onRequestEvent(RequestEvent.acceptApplication(reqIdx, workerIdx));
                                                              Navigator.of(context).pop(false);
                                                            },
                                                            child: Container(
                                                              alignment: Alignment.center,
                                                              color: const Color(0xffF8A239),
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
                                        ).then((value) async {
                                          Logger().d(value);
                                          if (value == false) {
                                            await _requestViewModel
                                                .onRequestEvent(RequestEvent.getMyRequestsRequesterSide(widget.request.requesterIdx.toString()));
                                            Navigator.of(context).pop(true);
                                          }
                                        });
                                      }
                                    : null,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(recruitment.isRejected == 0 ? 0xffF8A239 : 0xffE9E9E9),
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15)),
                                      border: Border.all(color: const Color(0xffEBEBEB))),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    "수락",
                                    style: TextStyle(color: recruitment.isRejected == 0 ? Colors.white : Colors.grey),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  onRequestTap(Request request) { // 심부름 정보 컨테이너 탭 이벤트 - 심부름 정보 조회 (바텀 모달)
    request.latitude;
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateBuilder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              children: [
                AppBar(
                  title: const Text(
                    '요청서 정보',
                  ),
                  leading: GestureDetector(onTap: () => Navigator.of(context).pop(), child: const Icon(Icons.keyboard_arrow_down)),
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
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // user,
                      const SizedBox(height: 16),
                      Text(request.title),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(request.content),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(request.address),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text("null"),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(request.runningTime ?? "null"),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("${request.reward}원"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  warningCancelRequest(int tappedIndex, Request request, String userIdx) { // 심부름 취소
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("심부름 취소하시겠습니까?"),
          actions: [
            TextButton(
                onPressed: () async {
                  await _requestViewModel
                      .onRequestEvent(RequestEvent.requestCancel(_requestState.request!.idx.toString(), "취소 이유", _requestState.request!.status.toString(), userIdx, tappedIndex.toString()))
                      .then((value) => Navigator.of(context).pop());
                },
                child: Text('확인')),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('취소'),),
          ],
        );
      },
    );
  }
}
