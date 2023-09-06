import 'dart:async';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/src/socket.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_project/domain/model/work_category.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/other_user_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_project/screen/mypage/my_page_screen.dart';
import 'package:test_project/screen/errand_history/request_history.dart';
import 'package:test_project/screen/mypage/user_info_screen.dart';
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
  final categories = WorkCategory().categories;

  //비동기 선언
  late Future initialize;

  //내 idx
  late String _myIdx;

  //요청서 데이터
  final TextEditingController _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _rewardController = TextEditingController();
  late String dropdownValue;
  late String reqLat;
  late String reqLng;
  String address = '심부름지역';

  //tabBar controller

  //naverMap
  // late NaverMapController _mapController;
  late List<NMarker> _markerList;
  late int tappedWorkerIdx;

  late List<User> _usersList;
  late UserViewModel _viewModel;
  late UsersState _usersState;
  late UserState _userState;
  late NLatLng _latLng;
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  int _selectedCategory = 0;

  DateTime _pickedDate = DateTime.now();

  bool _showCalendar = false;

  final List<Map<String, dynamic>> _waypointsLocation = [];
  final List<String> _waypointsContent = [];
  final List<TextEditingController> _waypointsContentController = [];

  String? _meridiemValue;
  int? _workStartHourValue;
  int? _workStartMinuetValue = 0;

  int? _runningTimeHourValue = 1;
  int? _runningTimeMinuetValue = 0;

  bool _isServiceTab = true;

  double _appBarBottomHeight = AppBar().preferredSize.height;

  List<bool> _workCategoryCheckValues = [];

  late List<bool> _backupCategoryValues;
  late List<bool> _innerBackupCategories;

  late List<bool> _genderCheckValues = [true, false, false];
  late List<bool> _backupGenderValues;

  late List<String> _ageGroupTextList = ['전체', '20대', '30대', '40대', '50대', '60대 이상'];
  late List<bool> _ageGroupCheckValues = [true, false, false, false, false, false];
  late List<bool> _backupAgeValues;

  List distanceList = [1, 3, 5, 7, 10];
  int _distanceIndex = 2;
  late int _backupDistanceIndex;

  Function(List<NMarker> markerList)? addOverlay;

  late final NaverMapController _mapController;
  bool isReservation = false;

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
    categories.add('전체 서비스');
    for (String category in categories) {
      widget.category == category ? _workCategoryCheckValues.add(true) : _workCategoryCheckValues.add(false);
    }
    initialize = _initialize();
  }

  Future _getHelpers() async {
    Logger().d('reqMain getHelpers: do');
    try {
      await _viewModel.onUsersEvent(
          UsersEvent.getAroundHelpers(_userState.user!.idx.toString(), _workCategoryCheckValues, _ageGroupCheckValues, _genderCheckValues, [1,3,5,7,10][_distanceIndex]));
    } catch(e) {
      Logger().d('##########getAroundHelpers Error : $e');
    }
  }

  Future<void> _initialize() async {
    // WidgetsFlutterBinding.ensureInitialized();

    _backupCategoryValues = List.from(_workCategoryCheckValues);
    _backupAgeValues = List.from(_ageGroupCheckValues);
    _backupGenderValues = List.from(_genderCheckValues);
    _backupDistanceIndex = _distanceIndex;
    _innerBackupCategories = List.from(_workCategoryCheckValues);
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

    _meridiemValue = DateTime.now().hour < 12 ? '오전' : '오후';
    _workStartHourValue = DateTime.now().hour < 12 ? DateTime.now().hour : DateTime.now().hour - 11;
    double appBarHeight = _appBarBottomHeight + AppBar().preferredSize.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppBar(
          title: const Text("부름이"),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(_appBarBottomHeight),
            child: Container(
              height: _appBarBottomHeight,
              decoration: const BoxDecoration(color: Color(0xffFBFBFB), border: Border(top: BorderSide(color: Color(0xffE9E9E9)))),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isServiceTab = true;
                                    _appBarBottomHeight = AppBar().preferredSize.height;
                                  });
                                },
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _isServiceTab ? const Color(0xffE77924) : const Color(0xffE9E9E9),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text('서비스'),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isServiceTab = false;
                                    _appBarBottomHeight = AppBar().preferredSize.height * 2;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _isServiceTab ? const Color(0xffE9E9E9) : const Color(0xffE77924),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text('드림이명'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: _isServiceTab,
                            child: GestureDetector(
                              onTap: () => showModalBottomSheet(
                                  enableDrag: false,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.9,
                                      child: StatefulBuilder(builder: (context, setState) {
                                        return Scaffold(
                                          appBar: AppBar(
                                            leading: GestureDetector(
                                              onTap: () => Navigator.of(context).pop(false),
                                              child: const Icon(Icons.expand_more),
                                            ),
                                            title: const Text('검색 필터'),
                                            actions: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop(true);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets.all(12),
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50), border: Border.all(color: const Color(0xffF8A239))),
                                                  child: const Text(
                                                    '적용하기',
                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          body: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(32),
                                                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE9E9E9)))),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "카테고리",
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      GridView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: categories.length,
                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4),
                                                        itemBuilder: (context, index) {
                                                          final category = categories[index];
                                                          Logger().d(index);
                                                          return _workCategoryCheckValues[index]
                                                              ? Row(
                                                                  children: [
                                                                    SvgPicture.asset(
                                                                      'asset/icons/icon_${'${index + 1}'.padLeft(2, '0')}.svg',
                                                                      width: 40,
                                                                    ),
                                                                    Expanded(
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            category,
                                                                          ),
                                                                          Checkbox(
                                                                            value: _workCategoryCheckValues[index],
                                                                            onChanged: (value) {
                                                                              if (index == 11) {
                                                                                setState(() {
                                                                                  for (int i = 0; i <= 11; i++) {
                                                                                    _workCategoryCheckValues[i] = _innerBackupCategories[i];
                                                                                  }
                                                                                  // _categoryIsSelected[index] = value!;
                                                                                });
                                                                              } else {
                                                                                int i = 0;
                                                                                for (int j = 0; j < _workCategoryCheckValues.length; j++) {
                                                                                  if (_workCategoryCheckValues[j]) {
                                                                                    i++;
                                                                                  }
                                                                                }
                                                                                if (i > 1) {
                                                                                  setState(() {
                                                                                    _workCategoryCheckValues[index] = value!;
                                                                                    _workCategoryCheckValues[11] = false;
                                                                                  });
                                                                                } else {
                                                                                  Fluttertoast.showToast(msg: '카테고리는 하나 이상 선택해야합니다.');
                                                                                }
                                                                              }
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    SvgPicture.asset(
                                                                      'asset/icons/icon_${'${index + 1}'.padLeft(2, '0')}.svg',
                                                                      width: 40,
                                                                      color: const Color(0xffE9E9E9),
                                                                    ),
                                                                    Expanded(
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            category,
                                                                            style: const TextStyle(color: Color(0xffE9E9E9)),
                                                                          ),
                                                                          Checkbox(
                                                                            value: _workCategoryCheckValues[index],
                                                                            onChanged: (value) {
                                                                              if (index == 11) {
                                                                                Logger()
                                                                                    .d('################!!!!!!!!!!!!!!!${_innerBackupCategories.toString()}');
                                                                                _innerBackupCategories = List.from(_workCategoryCheckValues);
                                                                                setState(() {
                                                                                  for (int i = 0; i <= 11; i++) {
                                                                                    _workCategoryCheckValues[i] = value!;
                                                                                  }
                                                                                  // _categoryIsSelected[index] = value!;
                                                                                });
                                                                                Logger()
                                                                                    .d('################!!!!!!!!!!!!!!!${_innerBackupCategories.toString()}');
                                                                              } else {
                                                                                setState(() {
                                                                                  _workCategoryCheckValues[index] = value!;
                                                                                });
                                                                              }
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(32),
                                                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE9E9E9)))),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('성별', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _genderCheckValues[0] = true;
                                                                  _genderCheckValues[1] = false;
                                                                  _genderCheckValues[2] = false;
                                                                });
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(50),
                                                                  border: Border.all(
                                                                    color: _genderCheckValues[0] ? const Color(0xffF8A239) : const Color(0xffE9E9E9),
                                                                  ),
                                                                ),
                                                                padding: const EdgeInsets.all(8),
                                                                child: Text(
                                                                  '전체',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: _genderCheckValues[0] ? Colors.black : const Color(0xffE9E9E9),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _genderCheckValues[0] = false;
                                                                  _genderCheckValues[1] = true;
                                                                  _genderCheckValues[2] = false;
                                                                });
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(50),
                                                                  border: Border.all(
                                                                    color: _genderCheckValues[1] ? const Color(0xffF8A239) : const Color(0xffE9E9E9),
                                                                  ),
                                                                ),
                                                                padding: const EdgeInsets.all(8),
                                                                child: Text(
                                                                  '남성',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: _genderCheckValues[1] ? Colors.black : const Color(0xffE9E9E9),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _genderCheckValues[0] = false;
                                                                  _genderCheckValues[1] = false;
                                                                  _genderCheckValues[2] = true;
                                                                });
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(50),
                                                                  border: Border.all(
                                                                    color: _genderCheckValues[2] ? const Color(0xffF8A239) : const Color(0xffE9E9E9),
                                                                  ),
                                                                ),
                                                                padding: const EdgeInsets.all(8),
                                                                child: Text(
                                                                  '여성',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: _genderCheckValues[2] ? Colors.black : const Color(0xffE9E9E9),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(32),
                                                  decoration: const BoxDecoration(
                                                    border: Border(top: BorderSide(color: Color(0xffE9E9E9))),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            "연령대",
                                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text('※중복선택이 가능합니다.')
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      GridView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: _ageGroupTextList.length,
                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisExtent: 32,
                                                          crossAxisSpacing: 16,
                                                          mainAxisSpacing: 16,
                                                        ),
                                                        itemBuilder: (context, index) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              if (index == 0) {
                                                                setState(() {
                                                                  _ageGroupCheckValues[0] = true;
                                                                  _ageGroupCheckValues[1] = false;
                                                                  _ageGroupCheckValues[2] = false;
                                                                  _ageGroupCheckValues[3] = false;
                                                                  _ageGroupCheckValues[4] = false;
                                                                  _ageGroupCheckValues[5] = false;
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  if (_ageGroupCheckValues[index] == false) {
                                                                    _ageGroupCheckValues[0] = false;
                                                                    _ageGroupCheckValues[index] = !_ageGroupCheckValues[index];
                                                                  } else {
                                                                    int i = 0;
                                                                    for (bool b in _ageGroupCheckValues) {
                                                                      if (b) {
                                                                        i++;
                                                                      }
                                                                    }
                                                                    if (i > 1) {
                                                                      _ageGroupCheckValues[index] = !_ageGroupCheckValues[index];
                                                                    } else {
                                                                      Fluttertoast.showToast(msg: '연령대를 하나 이상 선택해야합니다.');
                                                                    }
                                                                  }
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(50),
                                                                border: Border.all(
                                                                  color: _ageGroupCheckValues[index] ? const Color(0xffF8A239) : const Color(0xffE9E9E9),
                                                                ),
                                                              ),
                                                              padding: const EdgeInsets.all(8),
                                                              child: Text(
                                                                _ageGroupTextList[index],
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w600,
                                                                  color: _ageGroupCheckValues[index] ? Colors.black : const Color(0xffE9E9E9),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(32),
                                                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE9E9E9)))),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        '반경',
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (_distanceIndex > 0) {
                                                                setState(() {
                                                                  _distanceIndex--;
                                                                });
                                                              } else {
                                                                Fluttertoast.showToast(msg: '최소반경입니다.');
                                                              }
                                                            },
                                                            child: const Icon(Icons.remove_circle_outline),
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Text('${distanceList[_distanceIndex]}km 이내'),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (_distanceIndex < 4) {
                                                                setState(() {
                                                                  _distanceIndex++;
                                                                });
                                                              } else {
                                                                Fluttertoast.showToast(msg: '최대반경입니다.');
                                                              }
                                                            },
                                                            child: const Icon(Icons.add_circle_outline),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  }).then((value) async {
                                Logger().d('filter return value: $value');
                                if (value == true) {
                                  //필터 적용
                                  _backupCategoryValues = List.from(_workCategoryCheckValues);
                                  _backupGenderValues = List.from(_genderCheckValues);
                                  _backupAgeValues = List.from(_ageGroupCheckValues);
                                  _backupDistanceIndex = _distanceIndex;
                                  await _viewModel.onUsersEvent(
                                    UsersEvent.getAroundHelpers(
                                      _userState.user!.idx.toString(),
                                      _workCategoryCheckValues,
                                      _ageGroupCheckValues,
                                      _genderCheckValues,
                                      _distanceIndex,
                                    ),
                                  );
                                } else {
                                  //필터 리셋
                                  _innerBackupCategories = List.from(_backupCategoryValues);
                                  _workCategoryCheckValues = List.from(_backupCategoryValues);
                                  _genderCheckValues = List.from(_backupGenderValues);
                                  _ageGroupCheckValues = List.from(_backupAgeValues);
                                  _distanceIndex = _backupDistanceIndex;
                                }
                              }),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset('asset/icons/filter.svg'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !_isServiceTab,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      height: AppBar().preferredSize.height,
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Color(0xffE9E9E9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: initialize,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _usersList = _usersState.users;
              _myIdx = _userState.user!.idx.toString();
              Logger().d(_myIdx);

              final List<NMarker> markerList = [];
              Logger().d("state : ${_usersState.users}");
              for (int i = 0; i < _usersState.users.length; i++) {
                if (_usersState.users[i].id != _userState.user!.id) {
                  markerList
                      .add(NMarker(id: _usersState.users[i].idx.toString(), position: NLatLng(_usersState.users[i].latitude, _usersState.users[i].longitude)));
                }
              }
              _markerList = List.from(markerList);
              for (NMarker marker in _markerList) {
                marker.setOnTapListener((marker) => _viewModel.onUsersEvent(UsersEvent.getOtherUser(marker.info.id)).then((value) => onMarkerTap(marker)));
              }
              if (addOverlay != null) {
                addOverlay!(_markerList);
              }

              return Column(
                children: [
                  Expanded(
                    child: NaverMap(
                      options: NaverMapViewOptions(
                          indoorEnable: true,
                          locationButtonEnable: true,
                          consumeSymbolTapEvents: false,
                          initialCameraPosition: NCameraPosition(target: _latLng, zoom: 15)),
                      onMapReady: (controller) async {
                        _mapController = controller;

                        _mapController.latLngToScreenLocation(_latLng);

                        _mapController.setLocationTrackingMode(NLocationTrackingMode.follow);

                        addOverlay = (markerList) {
                          _mapController.clearOverlays();
                          _mapController.addOverlayAll(markerList.toSet());
                        };

                        addOverlay!(_markerList);
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
      //플로팅 버튼(일반 요청서작성)
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
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
                      final int requestType = 0;
                      var title = _titleController.value.text.trim();
                      var content = _contentController.value.text.trim();
                      var runningTime = "$_runningTimeHourValue시간$_runningTimeMinuetValue분";
                      var reward = _rewardController.value.text.trim();
                      final String date;
                      final int secondType;
                      if(isReservation) {
                        secondType = 0;
                        date = "${DateFormat('yyyy-MM-dd').format(_pickedDate)} $_workStartHourValue:$_workStartMinuetValue:00";
                        //모집
                      } else {
                        //빠른매치 즉시수행
                        secondType = 1;
                        final now = DateTime.now();
                        date = "${DateFormat('yyyy-MM-dd').format(now)} ${now.hour+1}:${now.minute}:00";
                      }

                      // var workDate = _pickedDate + _pickedTime;
                      Logger().d('category: $_selectedCategory, '
                          'title: ${_titleController.value.text}, '
                          'content: ${_contentController.value.text}, '
                          'address: $address, '
                          'latitude: $reqLat'
                          'longitude: $reqLng,'
                          'runningTime: $runningTime,'
                          'reward = $reward,');

                      _viewModel.onUsersEvent(UsersEvent.insertRequest(_myIdx, _selectedCategory.toString(), title, content, address, reqLat, reqLng, date,
                          runningTime, reward, _waypointsLocation, _waypointsContent, requestType, secondType));
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
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await _viewModel
                          .onUsersEvent(UsersEvent.getOtherUser(otherUserState.user!.idx.toString()))
                          .then((value) => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserInfoScreen(),
                              )));
                    },
                    child: otherUserState.user!.profileImageUrl == null
                        ? Container(
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.orange, width: 2.5))),
                            margin: const EdgeInsets.only(right: 10),
                            child: const Icon(
                              Icons.person,
                              size: 60,
                            ),
                          )
                        : Container(
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
                        const int requestType = 1;
                        final int secondType;
                        final String date;
                        if(isReservation) {
                          secondType = 0;
                          date = "${DateFormat('yyyy-MM-dd').format(_pickedDate)} $_workStartHourValue:$_workStartMinuetValue:00";
                        }else {
                          secondType = 1;
                          final now = DateTime.now();
                          date = "${DateFormat('yyyy-MM-dd').format(now)} ${now.hour + 1}:${now.minute}:00";
                        }
                        Logger().d('category: $_selectedCategory, '
                            'title: ${_titleController.value.text}, '
                            'content: ${_contentController.value.text}, '
                            'address: $address, '
                            'latitude: $reqLat'
                            'longitude: $reqLng');
                        var title = _titleController.value.text;
                        var content = _contentController.value.text;
                        var runningTime = "$_runningTimeHourValue시간$_runningTimeMinuetValue분";
                        var reword = _rewardController.value.text.trim();
                        _viewModel.onUsersEvent(UsersEvent.sendRequestToWorker(_myIdx, otherUserState.user!.idx.toString(), _selectedCategory.toString(), title,
                            content, address, reqLat, reqLng, date, runningTime, reword, _waypointsLocation, _waypointsContent, otherUserState.user!.fcmToken, requestType, secondType));
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
          content: const Wrap(
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

  Future _showBottomModalSheet() async {
    return _userState.user!.accountState == 0
        ? showModalBottomSheet(
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
                        title: const Text("요청서"),
                      ),
                      body: SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            const Text(
                              "심부름 카테고리",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              height: 51,
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemCount: categories.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (index == _selectedCategory) {
                                    if (index == categories.length - 1) {
                                      return Container(
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        height: 35,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: const Color(0xffE77924),
                                            border: Border.all(color: const Color(0xffE77924))),
                                        child: Text(
                                          categories[index],
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }
                                    return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      height: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: const Color(0xffE77924),
                                          border: Border.all(color: const Color(0xffE77924))),
                                      child: Text(
                                        categories[index],
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    );
                                  } else {
                                    if (index == categories.length - 1) {
                                      return GestureDetector(
                                        onTap: () => setState(() {
                                          _selectedCategory = index;
                                        }),
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 8, right: 8),
                                          height: 35,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50), color: Colors.white, border: Border.all(color: const Color(0xffE77924))),
                                          child: Text(categories[index]),
                                        ),
                                      );
                                    }
                                    return GestureDetector(
                                      onTap: () => setState(() {
                                        _selectedCategory = index;
                                      }),
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                        height: 35,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50), color: Colors.white, border: Border.all(color: const Color(0xffE77924))),
                                        child: Text(categories[index]),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            //title
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              '제목',
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextField(
                                controller: _titleController,
                                decoration:
                                    const InputDecoration(label: Text('제목을 작성해주세요.'), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              '설명',
                              style: TextStyle(fontSize: 20),
                            ),
                            // content
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextField(
                                controller: _contentController,
                                minLines: 2,
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    label: Text('요청하는 내용을 간단히 작성해 주세요.'), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange))),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text("최종 도착지", style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
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
                                          Expanded(child: Text(address, style: const TextStyle(color: Colors.black54, fontSize: 16))),
                                          const Icon(Icons.search_rounded),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    maxLines: 2,
                                    controller: _contentController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // height: double.minPositive,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _waypointsContent.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
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
                                                child: GestureDetector(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const PostWebView(),
                                                    ),
                                                  ).then(
                                                    (value) {
                                                      if (value != null) {
                                                        String jsonValue = jsonEncode(value);
                                                        Map<String, dynamic> jsonMap = jsonDecode(jsonValue);
                                                        Logger().d('return post value : $jsonMap');
                                                        setState(() {
                                                          _waypointsLocation[index] = jsonMap;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(_waypointsLocation[index]['address'],
                                                              style: const TextStyle(color: Colors.black54, fontSize: 16))),
                                                      const Icon(Icons.search_rounded),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              TextField(
                                                maxLines: 2,
                                                controller: _waypointsContentController[index],
                                                onTap: () {
                                                  Logger().d('tap');
                                                },
                                                onTapOutside: (event) {
                                                  Logger().d('tap outside');
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    _waypointsContent[index] = value;
                                                  });
                                                  Logger().d(_waypointsContent[index]);
                                                },
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _waypointsLocation.removeAt(index);
                                              _waypointsContent.removeAt(index);
                                              _waypointsContentController.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            child: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.grey,
                                            ),
                                            margin: const EdgeInsets.only(left: 4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Visibility(
                              visible: _waypointsContent.length < 3,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _waypointsLocation.add({'address': '경유지'});
                                    _waypointsContent.add('');
                                    _waypointsContentController.add(TextEditingController());
                                  });
                                },
                                child: const Row(
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
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "심부름 일시",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isReservation = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(12, 17, 12, 17),
                                      decoration: BoxDecoration(
                                        color: isReservation ? Color(0xffB5B5B5) : Colors.black87,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: double.maxFinite,
                                      child: Text('바로 수행', style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isReservation = true;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(12, 17, 12, 17),
                                      decoration: BoxDecoration(
                                        color: !isReservation ? Color(0xffB5B5B5) : Colors.black87,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: double.maxFinite,
                                      child: Text('일정 예약',  style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Visibility(
                                    visible: isReservation,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState (() {
                                              _showCalendar = !_showCalendar;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(12, 17, 12, 17),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            width: double.maxFinite,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.calendar_month_outlined),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                    child:
                                                    Text("${_pickedDate.year}-${_pickedDate.month}-${_pickedDate.day}(${"월화수목금토일"[_pickedDate.weekday - 1]})")),
                                                Icon(_showCalendar ? Icons.expand_less : Icons.expand_more),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8,),
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
                                                  calendarStyle: const CalendarStyle(
                                                      tablePadding: EdgeInsets.all(16),
                                                      todayDecoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                                                      todayTextStyle: TextStyle(color: Colors.black),
                                                      selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
                                                  lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month + 2),
                                                  headerStyle: const HeaderStyle(
                                                    titleCentered: true,
                                                    formatButtonVisible: false,
                                                    headerPadding: EdgeInsets.only(top: 16, bottom: 16),
                                                  ),
                                                  weekNumbersVisible: false,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton2(
                                                        value: _meridiemValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _meridiemValue = value;
                                                          });
                                                        },
                                                        items: ['오전', '오후']
                                                            .map(
                                                              (e) => DropdownMenuItem<String>(
                                                            value: e,
                                                            child: Text(e),
                                                          ),
                                                        )
                                                            .toList(),
                                                        buttonStyleData: ButtonStyleData(
                                                          padding: const EdgeInsets.only(right: 8),
                                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton2(
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _workStartHourValue = value;
                                                          });
                                                        },
                                                        value: _workStartHourValue,
                                                        items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                                                            .map(
                                                              (e) => DropdownMenuItem(
                                                            value: e,
                                                            child: Text('${_meridiemValue == '오전' ? e : e + 12}시'),
                                                          ),
                                                        )
                                                            .toList(),
                                                        buttonStyleData: ButtonStyleData(
                                                          padding: const EdgeInsets.only(right: 8),
                                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton2(
                                                        value: _workStartMinuetValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _workStartMinuetValue = value;
                                                          });
                                                        },
                                                        items: [0, 10, 20, 30, 40, 50, 60]
                                                            .map(
                                                              (e) => DropdownMenuItem(
                                                            value: e,
                                                            child: Text('$e분'),
                                                          ),
                                                        )
                                                            .toList(),
                                                        buttonStyleData: ButtonStyleData(
                                                          padding: const EdgeInsets.only(right: 8),
                                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                        ),
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "소요시간",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        onChanged: (value) {
                                          setState(() {
                                            _runningTimeHourValue = value;
                                          });
                                        },
                                        value: _runningTimeHourValue,
                                        items: [0, 1, 2, 3, 4, 5, 6, 7, 8]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text('$e시간'),
                                              ),
                                            )
                                            .toList(),
                                        buttonStyleData: ButtonStyleData(
                                          padding: const EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        value: _runningTimeMinuetValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _runningTimeMinuetValue = value;
                                          });
                                        },
                                        items: [0, 10, 20, 30, 40, 50, 60]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text('$e분'),
                                              ),
                                            )
                                            .toList(),
                                        buttonStyleData: ButtonStyleData(
                                          padding: const EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "심부름비",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _rewardController,
                                decoration: const InputDecoration(border: OutlineInputBorder()),
                              ),
                            ),

                            MaterialButton(
                                color: Colors.orange,
                                child: const Text('요청하기'),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      Logger().d("reward######${_rewardController.value.text.trim()}");
                                      if (_titleController.value.text.trim() == "") {
                                        return const AlertDialog(
                                          title: Text('제목을 입력해주세요'),
                                        );
                                      }
                                      if (_contentController.value.text.trim() == "") {
                                        return const AlertDialog(
                                          title: Text("심부름 내용을 입력해주세요"),
                                        );
                                      }
                                      if (address == "심부름지역") {
                                        return const AlertDialog(
                                          title: Text("심부름 지역을 입력해주세요"),
                                        );
                                      }
                                      if (_waypointsContent.length > 0) {
                                        int i = 0;
                                        for (Map<String, dynamic> location in _waypointsLocation) {
                                          if (location['address'] == "경유지") {
                                            return const AlertDialog(
                                              title: Text("경유지를 입력하지 않았습니다."),
                                            );
                                          }
                                          if (_waypointsContent[i].trim() == "") {
                                            return const AlertDialog(
                                              title: Text("경유지 내용을 입력해주세요"),
                                            );
                                          }
                                          i++;
                                        }
                                      }
                                      if (_rewardController.value.text.trim() == "") {
                                        return const AlertDialog(
                                          title: Text("심부름비를 입력해주세요."),
                                        );
                                      }
                                      return AlertDialog(
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
                                      );
                                    },
                                  ).then((value) {
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
            })
        : showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text("계정이 차단상태입니다."),
            ),
          );
  }

  tossPaymentsWebview(url) {}
}
