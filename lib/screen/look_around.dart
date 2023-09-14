import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_project/main.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/wallet_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/fcm_test_page.dart';
import 'package:test_project/screen/mypage/my_page_screen.dart';

import 'home_screen.dart';

class LookAround extends StatefulWidget {
  final String userId;

  const LookAround(this.userId, {Key? key}) : super(key: key);

  @override
  State<LookAround> createState() => _LookAroundState();
}

class _LookAroundState extends State<LookAround> {
  String? initialMessage;
  bool _resolved = false;

  late Future initialize;

  late UserState _userState;
  late UserViewModel _userViewModel;
  late String _userId;

  int _currentIndex = 0;

  final ScrollController _scrollController = ScrollController();
  GlobalKey _priceInfoKey = GlobalKey();

  Future<void> _initialize() async {
    try {
      await _userViewModel.onUsersEvent(UsersEvent.getUser(_userId));
    } catch (e) {
      Logger().d("error!!!!!!! $e");
    }
    Logger().d("!!!!!!!!!!!!!!!!!!!!!!$_userId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) { // 화면이 빌드되고 나서 수행
      initialize = _initialize();
      FirebaseMessaging.instance.getInitialMessage().then(
            (value) => setState(
              () {
                _resolved = true;
                initialMessage = value?.data.toString();
              },
            ),
          );
      FirebaseMessaging.onMessage.listen(showFlutterNotification);
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        Logger().d('A new onMessageOpenedApp event was published!');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyPageScreen(),
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = context.watch<UserViewModel>();
    _userState = _userViewModel.userState;
    _userId = widget.userId;


    return Scaffold(
      appBar: appBarLA(), //앱바
      body: SingleChildScrollView(
        controller: _scrollController,
        child: FutureBuilder(
            future: initialize,
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                _userState = _userViewModel.userState;
                Logger().d("user: ${_userState.user}, $_userViewModel");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    walletContainer(), //지갑
                    SizedBox(
                      height: 10,
                    ),
                    carousel(), //캐로셀 슬라이더
                    SizedBox(
                      height: 8,
                    ),
                    workContainer(), // 카테고리별 심부름 그리드뷰
                    Container( // 미어켓 강점 부각
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.only(right: 16, left: 16, top: 18, bottom: 18),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffF8A239), Color(0xffEB8229)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '미어켓은 안전합니다.',
                            style: TextStyle(fontSize: 21, color: Colors.white),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text('1. 부름이와 드림이들의 철저한 신원 인증', style: TextStyle(color: Colors.white)),
                          Text('2. 전문가들의 자격증 진위여부 확인', style: TextStyle(color: Colors.white)),
                          Text('3. 신뢰할만한 신원 인증 시스템', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    footer() //푸터
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  AppBar appBarLA() {
    return AppBar(
      toolbarHeight: 72,
      leading: IconButton(
        icon: const Icon(
          Icons.home_outlined,
          size: 30,
          color: Color(0xff808080),
        ),
        onPressed: () {},
      ),
      title: SvgPicture.asset(
        "asset/logo/logo_ab.svg",
        height: 40,
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 16),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPageScreen(),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "asset/icons/mypage.svg",
                  width: 23,
                ),
                SizedBox(
                  height: 2,
                ),
                const Text(
                  "마이페이지",
                  style: TextStyle(fontSize: 8),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget walletContainer() {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 8),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (_userState.user!.profileImageUrl == null)
                  const Icon(Icons.person, size: 44)
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
                        "http://${_userState.user!.profileImageUrl}",
                        cacheWidth: 1080,
                      )),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userState.user!.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "내지갑 >",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${_userState.user!.money}원",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget carousel() {
    var ads = ["carousel1.png", "carousel2.png", "carousel3.png"];
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: ads
              .map(
                (e) => Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FCMTestPage(),)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("asset/carousel/$e"))),
                    ),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            autoPlay: true,
            viewportFraction: 1,
            height: 170,
          ),
        ),
        Positioned(
          child: AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: 3,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Color(0xffE77924),
              dotColor: Color(0xffD9D9D9),
            ),
          ),
          bottom: 10,
        )
      ],
    );
  }

  Widget workContainer() {
    final categories = ["동행", "안심귀가", "교통약자", "돌봄", "우편/민원", "펫시팅", "가사", "배달/운송", "조립/설치", "시간알바", "기타/대행", "전체 서비스"];
    final icons = [
      "icon_01.svg",
      "icon_02.svg",
      "icon_03.svg",
      "icon_04.svg",
      "icon_05.svg",
      "icon_06.svg",
      "icon_07.svg",
      "icon_08.svg",
      "icon_09.svg",
      "icon_10.svg",
      "icon_11.svg",
      "icon_12.svg"
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              const Expanded(
                  child: Text(
                "미어켓의 초단기 알바",
                style: TextStyle(color: Color(0xff704633), fontSize: 20, fontWeight: FontWeight.w600),
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: showPrice,
                child: Row(
                  children: [
                    Text(
                      "심부름비 알아보기",
                      style: TextStyle(fontSize: 12),
                      key: _priceInfoKey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                      child: Text(
                        "?",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          GridView.builder(
            primary: false,
            itemCount: categories.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 28, mainAxisExtent: 100),
            itemBuilder: (context, index) {
              String icon = icons[index];
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabPage(widget.userId, categories[index], _userState.user!),
                    )),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: Color(0xffF5F5F5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        // margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(color: Color(0xff000000).withOpacity(0.25), blurRadius: 1, offset: Offset(0, 1)),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: SvgPicture.asset("asset/icons/$icon"),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        categories[index],
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget footer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "고객센터",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              Expanded(child: Text("카카오톡 문의 하기")),
              Expanded(child: Text("카카오톡 채널")),
            ],
          ),
          Row(
            children: const [
              Expanded(child: Text("이메일 문의 하기")),
              Expanded(child: Text("help@meusket.com")),
            ],
          ),
          Row(
            children: const [
              Expanded(child: Text("상담/문의 시간")),
              Expanded(child: Text("10:00 ~ 17:00")),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  showPrice() {
    final categories = ["동행", "안심귀가", "교통약자", "돌봄", "우편/민원", "펫시팅", "가사", "배달/운송", "조립/설치", "일일알바", "기타/대행", "전체 서비스"];
    final price = ["6,000", "5,000", "6,000", "6,000", "6,000", "6,000", "6,000", "8,000", "8,000", "9,620", "6,000", ""];
    final icons = [
      "icon_01.svg",
      "icon_02.svg",
      "icon_03.svg",
      "icon_04.svg",
      "icon_05.svg",
      "icon_06.svg",
      "icon_07.svg",
      "icon_08.svg",
      "icon_09.svg",
      "icon_10.svg",
      "icon_11.svg",
      "icon_12.svg",
    ];

    RenderBox renderBox = _priceInfoKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Logger().d("offset >> ${_scrollController.offset}");
    double dx = (offset.dx)/2;
    double dy = offset.dy - 400;

    showGeneralDialog(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOutQuint.transform(animation.value);
        return Transform.scale(origin: Offset(dx, dy),scale: curve, child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset("asset/icons/cancel.svg", width: 26),),
            ),
            Dialog(
              insetPadding: EdgeInsets.only(left: 26, right: 26, top: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "미어켓 평균 심부름비",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff704633)),
                    ),
                    Container(
                      height: 26,
                    ),
                    GridView.builder(
                      primary: false,
                      itemCount: categories.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 20, mainAxisExtent: 100),
                      itemBuilder: (context, index) {
                        String icon = icons[index];
                        if(index == categories.length - 1) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 62,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  // shape: BoxShape.circle,
                                  // color: Colors.orange,
                                ),
                                child: SvgPicture.asset("asset/icons/$icon"),
                              ),
                              Text(
                                categories[index],
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 62,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  // shape: BoxShape.circle,
                                  // color: Colors.orange,
                                ),
                                child: SvgPicture.asset("asset/icons/$icon"),
                              ),
                              Text(
                                "￦${price[index]}~",
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                categories[index],
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "※ 요청지의 거리, 소요시간, 경유지등을 고려하여 적정금액을 선정해주시기 바랍니다.",
                    ),
                    const Text(
                      "※ 일을 주는 경우가 많아 경비처리가 될 수 있습니다.",
                    ),
                    const Text(
                      "※ 물건 구입비는 심부름 비용과 별도입니다.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),);
      },
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, a1, a2) => Container(),
    );
  }
}
