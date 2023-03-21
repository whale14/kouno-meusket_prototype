import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_project/data/repository/errand_repository_impl.dart';
import 'package:test_project/data/source/remote/errand_api.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/repository/errand_repository.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  late RequestViewModel _viewModel;
  late RequestState _state;
  int _tappedIndex = 0;

  double latitude = 0;
  double longitude = 0;

  late String? idx;
  late Future initialize;
  late IO.Socket socket;

  @override
  void dispose() {
    // TODO: implement dispose
    _viewModel.onRequestEvent(RequestEvent.getRequests(idx!));
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize = _initialize();
  }

  Future _initialize() async {
    await _getSharedIdx();
    //문제없음
    Logger().d('tappedIndex:$_tappedIndex');
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
      await _viewModel.onRequestEvent(RequestEvent.getMyRequestsRequesterSide(idx!));
    } else {
      await _viewModel.onRequestEvent(RequestEvent.getMyRequestsWorkerSide(idx!));
    }
    Logger().d("do getMyRequests${_state.requests}");
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RequestViewModel>();
    _state = _viewModel.requestState;
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
                        )
                      ],
                    ),
                    title: const Text(
                      '요청내역',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: ListView.builder(
                    itemCount: _state.requests.length,
                    itemBuilder: (context, index) {
                      final request = _state.requests[index];
                      return GestureDetector(
                        onTap: () => onRequestTap(request),
                        child: ListTile(
                          title: Text(request.title),
                          subtitle: Text(request.content),
                        ),
                      );
                    },
                  ),
                ));
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
    _connect(request.idx.toString());
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateBuilder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                AppBar(
                  title: Text('진행상황 확인', style: TextStyle(color: Colors.white),),
                  leading: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.keyboard_arrow_down)),),
                Expanded(child: NaverMap(
                  options: NaverMapViewOptions(indoorEnable: true, locationButtonEnable: true, consumeSymbolTapEvents: false),
                  onMapReady: (controller){
                    if(latitude != 0) {
                      setStateBuilder(() {
                        setState(() {
                          controller.addOverlay(NMarker(id: 'workerLocation', position: NLatLng(latitude, longitude)));
                        });
                      });
                    }
                    controller.addOverlay(NMarker(id: 'destination', position: NLatLng(request.latitude, request.longitude)));
                  },
                )),
              ],
            ),
          );
        });
      },
    ).whenComplete(() => _disConnect());
  }

  void _connect(String idx) {
    socket = IO.io(
      // 'http://192.168.100.42:3000', //5층 ip
      'http://192.168.101.2:3000', // 3층 ip
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

  void _disConnect() {
    Logger().d("socket disConnect");
    socket.clearListeners();
    socket.close();
  }

}
